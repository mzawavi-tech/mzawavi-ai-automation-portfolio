create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  name text not null,
  email text not null,
  phone text,
  message text not null,
  message_hash text not null,
  intent text,
  confidence numeric,
  summary text,
  status text not null default 'new' check (status in ('new','needs_review','spam')),
  ack_sent boolean not null default false,
  source text not null default 'web_form'
);
create index if not exists leads_dedupe_idx on leads (email, message_hash, created_at);

create table if not exists error_log (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  workflow text not null,
  step text,
  payload jsonb,
  error text
);

-- Only the n8n/Make server (service role key) writes. No public access.
alter table leads enable row level security;
alter table error_log enable row level security;
