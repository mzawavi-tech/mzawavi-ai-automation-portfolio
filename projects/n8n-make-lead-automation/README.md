# Project: AI Lead Intake & Follow-up Automation (n8n + Make/Zapier)

Status: PLAN. Nothing here is built yet. Update the CV only after the workflows run and are demonstrable.

## Goal
Close the CV gap for postings 3, 4 and 5 (n8n, Zapier/Make) with one real project that reuses existing strengths (Supabase, WhatsApp Cloud API, LLMs, referral logic from Referly).

## Business problem
Inbound enquiries (web form or WhatsApp) are answered late and unevenly. Staff copy details into a sheet by hand.

## TO-BE workflow
1. Webhook receives an enquiry (form or WhatsApp message).
2. Validate and normalise the payload; reject duplicates (idempotency key).
3. LLM step classifies intent (sales / support / spam) and extracts name, phone and need into structured JSON.
4. Rules: route by intent; flag low-confidence results for human review.
5. Write the record to Supabase/PostgreSQL.
6. Send an acknowledgement (WhatsApp Cloud API or email) and notify the owner.
7. On failure: retry with backoff, then log to an errors table and alert.

## Build plan
| Phase | Deliverable |
|---|---|
| 1 | Process map (AS-IS / TO-BE), business rules and exception list |
| 2 | n8n implementation with error paths, retries and structured logs |
| 3 | Same flow rebuilt in Make (or Zapier) for comparison |
| 4 | Test cases, short demo recording, write-up with what failed and what was fixed |
| 5 | Update CV with the tools, once Phases 2–3 are working |

## Decisions needed from you
- n8n: self-hosted (Docker) or n8n Cloud trial?
- Make or Zapier for Phase 3? (Make's free tier is generally friendlier.)
- Trigger channel for the demo: web form or WhatsApp?
