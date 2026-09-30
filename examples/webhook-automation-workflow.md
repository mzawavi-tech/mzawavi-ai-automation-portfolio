# Example: Webhook Automation Workflow

> Conceptual example with fictional data. Not a production system.

## Objective

Show how an event from one system can be received, checked, processed and acted on reliably by another, with clear error handling and logs.

## Workflow

```text
Webhook Event
  → Validate Payload
  → Transform Data
  → Business Rules
  → AI Processing (optional)
  → Action
  → Logging
```

## Key Concepts

- **REST API.** A way for systems to talk over HTTP using standard methods (`GET`, `POST`, ...) and JSON. Used here for the outbound action.
- **Webhook.** An HTTP `POST` that a source system sends to your endpoint when something happens, instead of you polling for changes.
- **JSON payload.** The structured body of the request, carrying the event data.
- **Validation.** Confirming the request is authentic and the payload has the expected shape and values before doing anything with it.
- **Error handling.** Deciding what happens when a step fails: reject, skip, or park the event for review.
- **Retry.** Re-attempting a failed step, usually with increasing delays, when the failure is likely temporary.
- **Logging.** Recording what happened for debugging and audit.

## Sample Webhook Payload

```json
{
  "event_id": "evt_1001",
  "event_type": "order.created",
  "created_at": "2025-01-20T08:15:00Z",
  "data": {
    "order_id": "ord_5001",
    "customer": {
      "name": "Jordan Lim",
      "email": "jordan.lim@example.com"
    },
    "items": [
      { "sku": "SKU-DEMO-1", "quantity": 2, "unit_price": 25.0 }
    ],
    "currency": "USD",
    "notes": "Please call before delivery."
  }
}
```

## Processing Steps

### 1. Receive and respond quickly
Accept the `POST`, run the cheap checks, store the event, and return `2xx` promptly. Do slower work asynchronously so the sender does not time out and resend.

### 2. Validate payload
- Verify the request signature (for example an HMAC of the body using a shared secret) and reject if it does not match.
- Check required fields, types and allowed values against a schema.
- Reject unknown `event_type` values with `4xx`.
- Check `event_id` against processed events to ignore duplicates (**idempotency**), since webhooks may be delivered more than once.

### 3. Transform data
Map the source format to the internal one.

```json
{
  "order_ref": "ord_5001",
  "customer_email": "jordan.lim@example.com",
  "total": 50.0,
  "currency": "USD",
  "needs_follow_up": true
}
```

### 4. Business rules
Explicit, testable rules, for example:
- `total` above a set threshold → flag for manual review
- notes present → set `needs_follow_up`
- unsupported currency → route to an exception queue

### 5. AI processing (optional)
If free text needs interpretation, an LLM can summarize `notes` or suggest a category, returned as structured JSON. AI output supports the rules; it does not replace validation, and sensitive actions still go to human review.

### 6. Action
Call the target system's REST API, for example create a task or update a record.

### 7. Logging
Log `event_id`, event type, each step's outcome, duration and final status. Do not log secrets or full personal data.

## Error Handling and Retry

| Failure | Handling |
|---|---|
| Invalid signature | Reject (`401`/`403`), log, do not process |
| Invalid payload | Reject (`400`/`422`), log the reason |
| Duplicate event | Acknowledge, skip processing |
| Temporary downstream error (timeout, `5xx`, rate limit) | Retry with exponential backoff and a maximum attempt count |
| Permanent error (`4xx` from target) | Do not retry; send to a failed-events queue |
| Retries exhausted | Move to a dead-letter queue and alert a person |

Retried actions should be idempotent (for example by sending an idempotency key), so a retry cannot create duplicates.

## Security Considerations

- Verify signatures; never trust a request only because it reaches the endpoint.
- Serve the endpoint over HTTPS only.
- Keep secrets and API keys in environment variables or a secrets manager.
- Limit request size and apply rate limiting.
- Use least-privilege credentials for downstream APIs.
- Redact personal data in logs.

## Skills Demonstrated

- REST API and webhook integration concepts
- Schema validation and data transformation
- Idempotency, retry and error-handling design
- Rule-based logic with optional LLM support
- Logging and operational thinking
