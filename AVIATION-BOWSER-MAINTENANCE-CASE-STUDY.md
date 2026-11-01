# Aviation Bowser Maintenance Management — PPM, CM & Procurement Readiness

**Project type:** Operational workflow digitisation  
**Role:** Aviation Refueling Coordinator / Workflow Designer  
**Deployment context:** VPS-hosted browser-based web application  
**Confidentiality:** Public portfolio case study. Client identifiers, asset identifiers, operational records, security details and internal data are intentionally excluded.

## Overview

Designed and implemented a browser-based maintenance coordination workflow for aviation refuelling bowsers. The system brings Planned Preventive Maintenance (PPM) and Corrective Maintenance (CM) tracking into a per-bowser workflow and connects upcoming maintenance requirements to advance reminders and procurement preparation.

The goal is to improve maintenance visibility, reduce last-minute preparation and help the relevant teams identify checklist items that need stock or purchasing follow-up before planned work.

## Operational problem

Maintenance coordination requires more than recording a service date. Teams also need visibility of:

- Which bowser has upcoming PPM.
- What inspection or maintenance checklist items are required.
- Which corrective maintenance activities need follow-up.
- What items should be prepared ahead of the planned maintenance date.
- Which checklist requirements may not be available in stock and therefore need procurement attention.

When these steps are handled separately, preparation can become reactive and important requirements may be identified too late.

## Solution delivered

### 1. Per-bowser PPM tracking

A web workflow to manage planned preventive maintenance by individual bowser, including upcoming maintenance schedules and the relevant checklist requirements.

### 2. Corrective Maintenance (CM)

A separate CM workflow to record and coordinate corrective maintenance activities for each bowser, supporting follow-up and maintenance visibility.

### 3. Advance Google Calendar alerts

Upcoming PPM information is used to create advance reminders in Google Calendar. The reminder identifies when the next PPM is due and which checklist items need attention.

### 4. Procurement readiness notification

The advance workflow helps alert the procurement function early so required items can be prepared before the maintenance activity.

### 5. Checklist and stock-gap follow-up

Where a required checklist item is not available in stock, the gap can be identified for procurement follow-up rather than waiting until the maintenance date.

## High-level workflow

```text
Bowser Maintenance Record
          |
          +----------------------+
          |                      |
       PPM Schedule          CM Record
          |                      |
  Checklist Requirements    Corrective Follow-up
          |
  Upcoming PPM Identification
          |
  Google Calendar Advance Alert
          |
  Checklist / Stock Readiness Review
          |
  Procurement Notification
          |
  Maintenance Preparation
```

## Technology and implementation approach

- Claude used as an AI-assisted development partner.
- Browser-based web application hosted on a VPS.
- Google Calendar used for advance maintenance reminders.
- Per-bowser maintenance and checklist workflow.
- Database technology is not specified in this public case study because the exact deployed database configuration has not yet been verified.

This project demonstrates practical workflow analysis, AI-assisted application development, deployment awareness and integration of operational reminders. It should not be described as predictive AI: the documented advance alerts are schedule- and checklist-driven.

## Business value

The workflow is designed to support:

- Better visibility of PPM requirements by bowser.
- Earlier awareness of upcoming maintenance.
- More structured corrective maintenance follow-up.
- Advance preparation of checklist items.
- Earlier procurement visibility when required items are unavailable.
- Better coordination between operations, maintenance and procurement.

No quantified savings, uptime improvement or compliance outcome is claimed because validated before-and-after measurements have not been published.

## Skills demonstrated

- Operational process analysis
- Maintenance workflow design
- PPM and CM coordination
- Checklist and exception handling
- Procurement readiness workflow
- Google Calendar integration
- AI-assisted development with Claude
- VPS application deployment
- Cross-functional coordination

## Confidentiality note

This case study is a sanitized description of a real operational workflow. It does not publish client-owned code, asset registers, bowser identifiers, maintenance records, internal checklists, credentials, infrastructure details or sensitive operating procedures.
