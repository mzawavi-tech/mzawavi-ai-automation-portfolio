# FleetCare PPM/CM: Fleet Maintenance System (Live in Production)

**Live demo (fictional data):** https://mzawavi-tech.github.io/mzawavi-ai-automation-portfolio/projects/fleet-maintenance-ppm-cm/demo/

**Status:** Phase 1 in daily production use at an airport aviation fuel terminal since October 2026.
**My role:** Business analysis, requirements, solution design, data migration design, AI-assisted build and rollout. I am also the site maintenance coordinator who uses it every day.

> The production system, its source code and all client data are private. The demo linked above is a standalone prototype that reproduces the workflows with invented units, people, order numbers and rates.

---

## Context

A maintenance contractor services a fleet of five aviation refuellers (fuel bowsers and a hydrant dispenser) at an airport fuel terminal for an oil-company client. The contract sets fixed time limits for each preventive maintenance (PM) task and a daily penalty for every unit that runs late.

## The problem (AS-IS)

| Pain point | What it caused |
|---|---|
| Breakdowns and services written on paper, then typed twice into two Excel workbooks | Double work every day, records out of sync |
| Daily report kept as one sheet per month (38 sheets since Aug 2023) | No way to see a unit's full history |
| Same PM task spelled up to 6 different ways; fault-category column empty in 330+ breakdown records | No reliable reporting by task or failure type |
| Dates typed as text (`5.10.26`, `6.10.206`, `4/8/2026` read by Excel as 8 April) | Wrong durations and impossible dates (years 206, 2027–2030) |
| Availability formula divided by one unit's PM-hours cell instead of the unit count | `#DIV/0!` in the monthly report whenever that unit had no PM |
| No early warning on which unit had not done its monthly PM | Risk of contract penalties discovered after the fact |

## The solution (TO-BE)

One mobile-first web app where technicians record each job **once** on their phone, and every report the client receives is generated from those records.

**Core workflows**
- **Corrective maintenance (CM):** report breakdown → ground unit → daily repair log (mechanics, parts, who pays) → release → coordinator verifies and closes.
- **Preventive maintenance (PPM):** yearly A/B/C/D schedule board → client maintenance order (MO) entered by coordinator → technician ticks the task checklist and records actual start/end → coordinator marks done.
- **Weekly interlock & bonding checks:** one MO per unit per week, continuity reading in ohms, automatic failure handling.

**Business rules encoded in the system**
- Units, task codes (W/A/B/C/D), 11 fault categories and staff are picked from master lists, never typed.
- A breakdown cannot be closed without a repair description, a category for every fault item, who repaired it, and a release time if grounded.
- A PM cannot be marked done until every checklist item is answered.
- Contract time limits per task (24 / 48 / 48 / 72 hours) with automatic late flag and penalty estimate.
- A bonding reading at or above the 25 Ω standard fails the check and opens a breakdown automatically.
- Release must be after grounding; only one PM in progress per unit; no future dates.
- Two separate date sets per order: the client scheduler's MO window and the technician's actual dates, compared automatically.
- Three roles (technician, coordinator, client read-only). Every change is written to an audit log; records are cancelled with a reason, never deleted.

**Automation and outputs**
- Live dashboard: units available x/5, grounded units, monthly PM compliance, weekly compliance, open breakdowns.
- Alerts computed from records: no MO yet, window closing (≤ 3 / ≤ 7 days), PM over time limit, weekly check pending, grounded units.
- On the 15th of each month, a parts list for next month's B/C/D services, built from the schedule and a per-vehicle-type parts kit.
- Every maintenance order becomes a Google Calendar event with reminders, updated (not duplicated) when dates or status change.
- Daily Report and Vehicle Availability workbooks exported as `.xlsx` in the **exact layout the client already uses**, so the client's process did not have to change.
- Fleet availability calculated from grounded/PM hours against terminal operating hours, with the formula error fixed.

**Data migration**
- Import script for three years of history (Aug 2023 – Oct 2026) from both workbooks: normalises unit IDs, converts text dates, flags impossible dates, maps legacy task labels to the new codes, de-duplicates breakdowns that appear in both files, and suggests fault categories by keyword.
- Produces a "needs review" list so the coordinator confirms anything uncertain before it enters the system.

## Architecture (production)

```text
Technician phone (PWA) ─┐
Coordinator phone/laptop ┼─► HTTPS (Nginx) ─► Node.js + Express ─► SQLite (typed dates, daily backup)
Client (read-only) ─────┘                         │
                                                  ├─► ExcelJS  → client-format .xlsx reports
                                                  ├─► Google Calendar / .ics → MO reminders
                                                  └─► Parameter workbook (master lists, checklists, parts kits)
Hosting: existing Debian VPS, PM2 process, own port, folder, repo and database
```

Master data (vehicles, tasks, checklists, parts kits, yearly schedule, fault categories) lives in one parameter workbook the coordinator can update without code changes.

## How it was delivered

```text
Shadow the work + analyse 3 years of Excel records
  → Written spec: roles, master lists, data model, rules, screens, acceptance tests
  → Build with AI coding agents (Claude Code), reviewed and tested against real month data
  → Import and clean history, coordinator review of flagged records
  → Acceptance on real October 2026 data → live on site
```

**Acceptance criteria used (examples)**
- A technician can report a breakdown from a phone in under 2 minutes.
- "x/5 units available" changes by itself when a breakdown is opened or released.
- Monthly availability from the system matches the manual calculation, without `#DIV/0!`.
- Exported reports match the layout of the client's current files.
- The client account can view and download but cannot change data.

## Skills demonstrated

Business analysis (AS-IS/TO-BE, gap analysis, business rules, exception handling) · requirements and acceptance criteria · data modelling · data cleansing and migration · workflow automation · reporting automation · role-based access and audit trail · AI-assisted software development · deployment on Linux/VPS · change management with field technicians and a client.

## Try the demo

Open the demo link above and switch **View as** between Technician, Coordinator and Client to see the permission rules. Try closing an open breakdown before filling in the repair, or submitting a weekly bonding check with a reading of 30 Ω. Data stays in your browser; use **Reset demo** to start again.
