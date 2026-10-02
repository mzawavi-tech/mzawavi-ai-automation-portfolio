# Make scenario (Phase 3) — build guide

Same business rules (BR1-BR7) as the n8n flow. Build after the n8n version works.

Modules, in order:
1. **Webhooks > Custom webhook** (name: lead-intake). Run once with the form to learn the data structure.
2. **Tools > Set multiple variables**: lowercased email, trimmed fields, `sha256(message)` (use the `sha256` function with hex encoding).
3. **Filter** (BR1): name, email, message not empty, email matches a basic pattern. Add **Webhooks > Webhook response** (400) on a fallback route.
4. **HTTP > Make a request** GET Supabase `/rest/v1/leads?email=eq.…&message_hash=eq.…&created_at=gte.…` (24h). Header `apikey` + `Authorization` with the service key.
5. **Router**: duplicate found -> Webhook response `{"ok":true,"duplicate":true}` and stop.
6. **HTTP > Make a request** POST `https://api.anthropic.com/v1/messages` (same prompt as the n8n flow; parse response = Yes).
7. **JSON > Parse JSON** on the model text; use an **error handler (Ignore/Resume with defaults)** so bad JSON yields `needs_review` (BR3, exception 1).
8. **Router** by BR4-BR6: spam / needs_review / new.
9. **HTTP** POST Supabase `/rest/v1/leads`.
10. **Webhooks > Webhook response** `{"ok":true}`.
11. **Email** acknowledgement (route `new` only) and owner notification.
12. **Error handlers** on the HTTP modules: **Break** with 3 retries (interval 1 min), then a final route inserting into `error_log` and alerting the owner (BR7).

Compare after building: debugging experience, error handling model, pricing per operation, and how each tool handles retries. Record this in the write-up.
