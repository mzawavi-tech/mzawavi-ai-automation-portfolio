# Example: AI Reply Approval Workflow

> Conceptual example with fictional data. Not a production system.

## Objective

Handle replies to outbound outreach faster and more consistently. AI classifies each reply and drafts a response; **a human reviews every draft before anything is sent.**

## Workflow

```text
Incoming Prospect Reply
  → Message Classification
  → Intent Detection
  → AI Draft Response
  → Human Approval
  → Send / Revise
  → Log Result
  → Follow-up
```

| Step | Purpose |
|---|---|
| Incoming Reply | A reply arrives via inbox integration or webhook |
| Message Classification | Separate genuine replies from auto-responders, out-of-office notices and bounces |
| Intent Detection | An LLM labels the intent and extracts key details |
| AI Draft Response | An LLM drafts a reply using approved templates and tone guidelines |
| Human Approval | A reviewer approves, edits or rejects the draft |
| Send / Revise | Approved drafts are sent; rejected drafts are revised and re-reviewed |
| Log Result | Store the reply, intent, draft, decision and outcome |
| Follow-up | Schedule the next step based on intent |

## Intents and Handling

| Intent | Example (fictional) | Drafted action | Follow-up |
|---|---|---|---|
| `interested` | "This sounds useful, can we talk?" | Propose meeting times | Reminder if no answer in a few days |
| `asking_pricing` | "What does this cost?" | Share approved pricing information or route to a person | Check in after sending |
| `needs_more_info` | "Does it integrate with our CRM?" | Answer from approved material, or flag for a person if unsure | Follow up after answering |
| `not_interested` | "Not a fit for us right now." | Short, polite acknowledgement | Stop the sequence |
| `unsubscribe` | "Please remove me from your list." | No sales reply; confirm removal | Add to suppression list immediately |

`unsubscribe` is handled by rule as a compliance action. It should not depend on AI judgment or wait for a draft.

## Example Input

```json
{
  "reply_id": "reply_0042",
  "thread_id": "thread_0007",
  "from": "sam.lee@example.com",
  "received_at": "2025-01-16T14:05:00Z",
  "body": "Thanks for reaching out. Could you send over pricing?"
}
```

## Example JSON Response

```json
{
  "reply_id": "reply_0042",
  "is_auto_reply": false,
  "intent": "asking_pricing",
  "confidence": 0.91,
  "sentiment": "neutral",
  "requires_human_attention": true,
  "draft": {
    "subject": "Re: Pricing",
    "body": "Hi Sam, thanks for your interest. I'd be happy to share pricing details. Could you tell me roughly how many users you have in mind so I can send the right information?"
  },
  "approval_status": "pending_review",
  "suggested_follow_up": {
    "action": "check_in",
    "after_days": 3
  }
}
```

`approval_status` starts as `pending_review`. Only a reviewer can change it to `approved`.

## Human Approval

- **No auto-send.** Every AI draft waits in a review queue.
- A reviewer can **approve**, **edit then approve**, or **reject**.
- Low-confidence classifications, pricing, legal or complaint-type messages are flagged for closer attention.
- The system records the original draft and the final sent version, so the team can see where AI drafts needed changes and improve the prompts.

## Logging

Each reply produces a record with: reply ID, detected intent, confidence, draft, reviewer decision, timestamps, and send status. Logs contain no secrets and limit personal data to what is needed.

## Security Considerations

- Treat incoming message text as untrusted; it may contain instructions aimed at the model. The model output is only ever a draft, never an action.
- Restrict the model to approved templates and facts so it does not invent pricing, commitments or features.
- Keep credentials for email and LLM providers in a secrets manager.
- Honor unsubscribe requests immediately and keep a suppression list.
- Limit who can approve and send.

## Skills Demonstrated

- Intent classification and structured LLM output
- AI-assisted drafting with human approval controls
- Compliance-aware workflow design
- Logging and feedback loops
- Follow-up scheduling logic
