# AI Lead Intake & Follow-up Automation (n8n + Make)

**Status: built from spec, NOT yet executed.** Workflow JSON and form are written but untested on a live n8n Cloud trial. Do not claim n8n/Make experience on the CV until `docs/02-test-cases.md` is filled with real results.

Flow: web form -> n8n webhook -> validate -> duplicate check -> LLM classify -> rules -> Supabase -> acknowledgement + owner alert, with retries and an error log.

## Layout
- `docs/01-process-and-rules.md` AS-IS/TO-BE, business rules, exceptions
- `db/schema.sql` Supabase tables
- `form/index.html` web form (set `WEBHOOK_URL`)
- `n8n/lead-intake.workflow.json` import via n8n Cloud > Workflows > Import from file
- `make/README.md` Make rebuild guide
- `docs/02-test-cases.md` test matrix

## Your setup steps (needs your accounts; I can't do these from here)
1. Supabase: create a free project, run `db/schema.sql`.
2. n8n Cloud trial: set variables `SUPABASE_URL`, `SUPABASE_SERVICE_KEY`, `ANTHROPIC_API_KEY`, `MAIL_FROM`, `OWNER_EMAIL`. If your plan lacks environment variables, replace the `$env.` references with Credentials. Configure an SMTP credential on the two email nodes.
3. Import the workflow, publish it, copy the **production** webhook URL into `form/index.html`.
4. Run the tests T1-T10 and tell me the results. I will fix whatever fails.

Never commit keys. The service-role key bypasses row-level security, so keep it server-side only.
