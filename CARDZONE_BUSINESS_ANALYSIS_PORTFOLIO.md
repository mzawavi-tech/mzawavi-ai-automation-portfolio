# Business Analysis Portfolio — Workflow & Application Implementation

**Portfolio owner:** Mohamad Zawavi Muda  
**Purpose:** Demonstrate transferable business analysis and implementation capabilities for Business Analyst / Senior Business Analyst roles.  
**Important boundary:** These are the candidate's own portfolio and operational workflow projects. They are not Cardzone client projects and do not establish direct card-switching, ISO8583, NDC+ or card-management delivery experience.

## Additional banking experience — Bill Payment module and MEPS responsibilities

While responsible for IT Application Development & Support at Bank Islam Malaysia Berhad, the candidate handled the Bill Payment module and had MEPS-related responsibilities among the systems/services under his care. This is relevant banking payment application and service-support exposure and strengthens the banking systems context for payment-related implementation work.

The exact MEPS components, product/platform, technical architecture, payment rails, card-processing relationship, transaction volumes and protocols have not been confirmed. Do not describe this as MEPS platform development, card-switching engineering, ISO8583, NDC+ or payment-gateway implementation unless separately evidenced.

## 1. Referly — B2B Referral & Affiliate SaaS

### Business problem
A referral business needs consistent handling of customer registration, referral attribution, booking and reward calculation. If these rules are scattered across manual processes, referral ownership and reward outcomes can become inconsistent.

### Business workflow
`Customer → Registration → Referral Code Resolution → Booking → Reward → Admin Review`

### Business rules represented in the application
- Resolve and retain the referral relationship during registration.
- Support member-to-agent upgrade logic.
- Connect eligible bookings to the referral workflow.
- Apply reward calculation and expose relevant information through an admin dashboard.

### Analysis and implementation evidence
- Translate user journeys into discrete workflow stages.
- Identify business rules and hand-off points.
- Represent data relationships through Supabase/PostgreSQL-backed application workflows.
- Implement and review workflow behaviour in a Next.js/TypeScript application.

### Relevance to a banking technology implementation role
Shows transferable experience with customer-facing workflows, business rules, data-backed processes, user journeys and implementation logic. It is not a payment-card processing system.

## 2. MiraAI — AI Knowledge & Workflow Platform

### Business problem
Business knowledge and operational instructions need to be imported, organised and made retrievable through a consistent conversational workflow.

### Workflow
`Knowledge Import → OCR → Knowledge Storage → Retrieval → Response`

### Analysis and implementation evidence
- Define modular Knowledge, Learning, Workflow, Agent, Connector and Import components.
- Connect a Node.js/Express backend to SQLite and LLM APIs.
- Integrate WhatsApp Cloud API through webhooks.
- Implement OCR-assisted knowledge ingestion.
- Review the request/response path and workflow behaviour during project development.

### Relevance to a banking technology implementation role
Shows API integration, structured information handling, workflow decomposition and technical/business translation. It does not establish production banking integration or payment-rail experience.

## 3. Aviation Bowser PPM/CM Maintenance Workflow

### Business problem
Operations need visibility of upcoming preventive maintenance, corrective maintenance follow-up and checklist items that must be prepared before a maintenance date.

### Workflow
`Bowser Record → PPM Schedule / CM Record → Checklist Review → Calendar Reminder → Procurement Readiness Follow-up`

### Analysis and implementation evidence
- Separate planned maintenance from corrective maintenance workflows.
- Track maintenance by individual bowser.
- Connect upcoming PPM schedules to advance Google Calendar reminders.
- Identify checklist items that require stock/procurement follow-up.
- Keep client, asset, security and operational records out of the public portfolio.

### Relevance to a banking technology implementation role
Demonstrates process discovery, exception visibility, operational requirements, reminder integration and coordination between operational stakeholders. It is not a banking or payment-card system.

## 4. Business Analyst delivery approach

For a new customer implementation, the candidate's proposed working approach is:

1. Understand the customer objective and current process.
2. Record user requirements, actors, inputs, outputs and business rules.
3. Map the current and target workflow, including exceptions and hand-offs.
4. Confirm requirements and acceptance scenarios with stakeholders.
5. Support configuration and implementation coordination with technical teams.
6. Review test scenarios against agreed requirements and record issues.
7. Prepare functional notes, user guidance and training/walkthrough materials.
8. Track deliverables, open issues and customer feedback through handover.

This is a proposed approach based on transferable experience, not a claim that every artefact above has already been delivered on a card-management project.

## 5. Technical context

- JavaScript / TypeScript
- Node.js / Express
- Next.js
- REST APIs and webhooks
- WhatsApp Cloud API
- SQLite
- Supabase / PostgreSQL
- Git / GitHub
- LLM API integration and OCR-assisted ingestion

**Not claimed:** ISO8583, NDC+, financial switching, card management platforms, Oracle, DB2, advanced SQL or production payment processing.

## 6. Portfolio links

- Main portfolio: https://github.com/mzawavi-tech/mzawavi-ai-automation-portfolio
- Aviation maintenance case study: https://github.com/mzawavi-tech/mzawavi-ai-automation-portfolio/blob/main/AVIATION-BOWSER-MAINTENANCE-CASE-STUDY.md
