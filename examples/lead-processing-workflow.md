# Example: Lead Processing Workflow

> Conceptual example with fictional data. Not a production system.

## Objective

Turn raw inbound leads into qualified, reviewed outreach tasks, so a sales team spends its time on good-fit prospects instead of sorting a spreadsheet.

## Workflow

```text
Lead Source
  → Lead Capture
  → Data Validation
  → Lead Enrichment
  → AI Classification
  → Qualification
  → Human Review
  → Outreach
```

| Step | Purpose |
|---|---|
| Lead Source | Web form, CSV import or partner referral sends a lead |
| Lead Capture | Receive the lead through an API endpoint or webhook and store it with a unique ID |
| Data Validation | Check required fields, email format and duplicates |
| Lead Enrichment | Add public company details (industry, size) from an approved data source |
| AI Classification | An LLM assigns industry, fit and a short rationale as structured JSON |
| Qualification | Deterministic rules combine the AI output with business criteria into a score and status |
| Human Review | A person approves, edits or rejects each qualified lead |
| Outreach | Approved leads move to the outreach step with a drafted message |

## Sample JSON Input

All values are fictional (`example.com` is a reserved domain).

```json
{
  "lead_id": "lead_0001",
  "source": "website_form",
  "received_at": "2025-01-15T09:30:00Z",
  "contact": {
    "name": "Alex Tan",
    "email": "alex.tan@example.com",
    "job_title": "Operations Manager"
  },
  "company": {
    "name": "Example Logistics Sdn Bhd",
    "website": "https://example.com",
    "employee_count": 45
  },
  "message": "We are looking for a way to automate our customer follow-ups."
}
```

## Processing Logic

1. **Validate.** Reject or flag leads with a missing email, a malformed email, or a duplicate `email` already in the system.
2. **Enrich.** Add fields such as `industry` and `employee_count` if missing. If enrichment fails, continue with what is available and mark the lead `enrichment_incomplete`.
3. **Classify.** Send only the fields needed (job title, company profile, message) to the LLM and request a fixed JSON schema.
4. **Qualify.** Apply explicit rules, for example:
   - `fit = high` and company size within target range → `qualified`
   - `fit = medium` → `needs_review`
   - `fit = low` or outside target market → `not_qualified`
5. **Review.** Every lead marked `qualified` or `needs_review` goes to a review queue.
6. **Outreach.** Only leads a reviewer approved proceed.

The LLM classifies. The rules decide. Keeping those separate makes the outcome explainable and easy to adjust.

## Example AI Output

```json
{
  "lead_id": "lead_0001",
  "industry": "Logistics",
  "intent": "automation_interest",
  "fit": "high",
  "confidence": 0.82,
  "rationale": "Operations role at a mid-sized company; message asks directly about automating follow-ups.",
  "suggested_next_step": "personalized_intro_email"
}
```

Model output is validated against the expected schema. Malformed or out-of-range output is routed to manual review rather than trusted.

## Human-in-the-Loop

- A reviewer sees the lead, the AI classification, the rationale and the rule result together.
- They can approve, edit, or reject, and can override the AI's classification.
- Nothing is sent to a lead without an approval recorded.
- Overrides are logged so the classification prompt and rules can be improved over time.

## Security Considerations

- Store API keys and secrets in environment variables or a secrets manager, never in the workflow definition or the repository.
- Send the LLM only the fields it needs; avoid unnecessary personal data.
- Validate and sanitize all inbound data; treat lead text as untrusted input, including possible prompt injection.
- Restrict access to the review queue and lead data by role.
- Respect consent and applicable data-protection and anti-spam rules for outreach.
- Keep an audit log of who approved what and when.

## Skills Demonstrated

- Workflow design and business process automation
- Data validation and structured JSON handling
- Combining LLM output with deterministic business rules
- Human-in-the-loop design
- Security-aware handling of customer data
