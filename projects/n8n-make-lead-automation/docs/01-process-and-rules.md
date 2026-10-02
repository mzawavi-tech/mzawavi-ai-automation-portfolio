# Phase 1 — Process, Business Rules, Exceptions

## AS-IS
1. Enquiry arrives by email or web form.
2. Staff read it when they can (hours to days).
3. Staff retype details into a spreadsheet; duplicates and typos are common.
4. Staff decide manually who handles it and reply by hand.
Gaps: slow first response, no duplicate check, no audit trail, spam wastes time.

## TO-BE
Web form -> webhook -> validate -> dedupe -> LLM classify/extract -> rules -> save to Supabase -> acknowledge lead + notify owner -> log errors.

## Business rules
| ID | Rule |
|---|---|
| BR1 | Required: name, email, message. Phone optional. Reject otherwise (HTTP 400). |
| BR2 | Duplicate = same email + same message hash within 24h. Do not create a second record; return 200 with `duplicate:true`. |
| BR3 | LLM returns JSON: `intent` (sales/support/spam/other), `confidence` (0-1), `name`, `phone`, `summary`. |
| BR4 | `spam` -> store with status `spam`, send nothing. |
| BR5 | `confidence < 0.6` -> status `needs_review`, notify owner only (no auto-reply). |
| BR6 | `sales` / `support` with confidence >= 0.6 -> status `new`, auto-reply to lead, notify owner. |
| BR7 | Any step failure -> retry 3x with backoff, then insert into `error_log` and alert owner. |

## Exceptions
- LLM returns invalid JSON -> treat as `needs_review`, keep raw text in `error_log`.
- Supabase unreachable -> retry, then alert; the lead must never be silently lost.
- Email send fails -> record saved, `ack_sent=false`, alert owner.

## Success measures
First response under 1 minute; 0 duplicate records in tests; 100% of failures visible in `error_log`.
