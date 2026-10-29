# CampusLoop — A Campus Lost & Found and Second-hand Marketplace with Verified Identity

## Project Proposal

**Team:** [Team Name] · **Members:** [Names / Student IDs]
**Course:** [Course Name] — Final Team Project
**Date:** 29 October 2026
**Project type:** Self-proposed (not sponsored)

---

## Executive Summary

Campus lost-and-found and second-hand trading already happen — inside WeChat groups that bury a post within hours and cannot be searched. The information exists; the infrastructure does not. CampusLoop is a mobile-first web app that gives three campus behaviours (lost & found, second-hand trading, short notices) a persistent, searchable, identity-bound home. The frontend is already built and working; this project's work is to replace browser-local storage with shared cloud storage, then validate the product with real users outside this class — dormitory custodians on the "finder" side, and students from other departments on the "trading" side.

---

## 1. Customer Scenarios

### 1.1 The problem in one sentence

Second-hand goods and lost-and-found information on campus live in ephemeral group chats: a post is buried within hours, is not searchable, and never reaches the person who actually holds the item.

### 1.2 Three concrete scenarios

The three scenarios below come from our own observation of how campus channels currently work. The specific quantities are **working assumptions**, to be confirmed or corrected in the Week 1 interviews — they are written down here so that they can be proven wrong.

**Scenario A — The lost student card (the finder's side)**

A dormitory custodian collects three to five lost student cards a week. She keeps them in a drawer and mentions them once in the building's WeChat group. A student who lost a card has no idea that drawer exists, and the group message has scrolled away within a day. The item is effectively lost even though it has already been found.

*Unmet need:* a persistent, searchable place where the **finder** can register an item once, and any student can search it without joining a specific group.

**Scenario B — The end-of-term textbook pile**

At the end of each semester a student holds six to eight textbooks and exam-prep books. Selling on Xianyu means shipping costs or meeting a stranger across town; posting in campus groups means reposting every few days and dealing with no-shows. Most of these books end up at the recycling station for well under one yuan per kilogram.

*Unmet need:* a campus-scoped listing where the buyer is 200 metres away, and the seller lists once instead of reposting weekly.

**Scenario C — "Is this person actually a student?"**

Students already trade on Xianyu and Weibo, but cannot tell whether the counterpart belongs to this school. Deposit scams and no-shows are common enough that many simply give up on second-hand trading.

*Unmet need:* identity-bound participation, so every listing has an accountable owner.

### 1.3 Who the early customers are

Deliberately **outside this class**:

1. **Dormitory custodians and building managers** — the finders. High frequency, currently zero tooling beyond a drawer.
2. **Students from at least two other departments** — reached through dormitory floors and student clubs, not through this course.
3. *(Optional)* **A campus print shop or convenience store** as a drop-off and collection point.

We will not count classmates, teammates, or friends recruited purely as a favour. Interviews will be recorded with permission, and every reported user will be a real account with real activity in the database.

### 1.4 What we still need to verify

We treat the scenarios above as hypotheses, not facts. The first week is dedicated to confirming three things before any code changes: (a) how finders currently handle found items, (b) how often students actually search for a lost item versus give up, and (c) whether identity visibility changes willingness to trade. If the interviews contradict a scenario, we will narrow or drop that module rather than defend it.

---

## 2. Proposed Solution

### 2.1 Product scope (MVP)

CampusLoop is a mobile-first web app with three surfaces:

1. **Lost & Found** — post a lost or found item; filter by category, location and date; full-text search; image upload; status from `open` to `returned`.
2. **Second-hand Market** — listing with price, condition and category; seller contact; status from `available` to `reserved` to `sold`.
3. **Notice Wall** — short posts for requests and announcements.

**Explicitly out of scope for the MVP:** in-app chat, payments, delivery, ratings and reviews. These are the features that make such projects fail to ship.

### 2.2 Architecture

| Layer | Choice | Reason |
|---|---|---|
| Frontend | Existing single-page app: HTML / CSS / vanilla JS, no build step, mobile-first | Already implemented and functional (three modules, seeded data, image compression, list pagination) |
| Backend | Managed backend-as-a-service: authentication, relational database, object storage for images | No server to operate, public HTTPS URL included, fits a seven-week timeline |
| Deployment | Static hosting on the same platform | One URL that opens on any phone |

**The single change that matters this iteration:** replace browser-local storage with shared cloud storage, so two people on two phones see the same data. That is the difference between a demo and a product, and it is the reason the current build cannot yet be validated by anyone.

### 2.3 Identity binding — what we will and will not claim

Participation requires a **student ID and department**, gated by an invite code distributed through dormitory channels. We will **not** connect to, imitate, or claim integration with the university's real single sign-on system: we have no authorisation to do so, and a fake login screen would mislead users about how their credentials are handled. Identity binding here means *accountability and campus scoping*, not institutional authentication. This constraint will be stated in plain language on the sign-up screen.

### 2.4 Why this can ship

The interface is already built — roughly 6,000 lines covering all three modules, list and detail views, publishing flows, image compression and search. The remaining work is backend integration plus real-user operation, not a rewrite. Scope is deliberately smaller than comparable campus platforms that attempt chat, orders and payments.

---

## 3. Expected Results

Pilot targets by 16 December. Every number is measured from server-side records, not self-reported.

| Metric | Target | Measurement |
|---|---|---|
| Real users outside this class | ≥ 40 | Unique accounts with a student ID, team members excluded |
| Real listings published | ≥ 50 | Database rows, seeded demo data excluded |
| Completed offline handovers | ≥ 8 | Seller-confirmed `sold` / `returned` status |
| Items returned to their owner via the platform | ≥ 3 | Lost-item status changed to `returned` |
| Two-week return rate | ≥ 30% | Users with two sessions at least 14 days apart |
| Time to first contact on a new listing | median < 24 h | Timestamp difference between publish and first contact click |

**Qualitative evidence:** five short interviews — three with finders (custodians), two with sellers — on whether they would keep using the product after the pilot, plus one written note from each on what would make them stop.

**Honest failure criteria:** if after four weeks of operation fewer than 15 external users have published anything, we will report that the need was not validated and analyse why, rather than inflate the numbers with team-generated content.

---

## 4. Execution Plan

| Week | Dates | Work | Owner |
|---|---|---|---|
| W1 | 10/29 – 11/04 | 15 customer interviews (custodians, other-department students); confirm or revise scenarios; freeze MVP scope | PM + Design |
| W2 | 11/05 – 11/11 | Backend setup: auth, schema, image storage; migrate publish, list and detail flows to the cloud | Backend + Frontend |
| W3 | 11/12 – 11/18 | Search, filters, "my posts" management; internal testing on real devices | Frontend + QA |
| W4 | 11/19 – 11/25 | Closed beta with five seed users; fix defects; mobile polish | All |
| W5 | 11/26 – 12/02 | Cold start: dormitory-floor outreach, custodian onboarding, QR posters at building entrances | Ops + PM |
| W6 | 12/03 – 12/09 | Grow to 40+ external users; monitor metrics; iterate on the weakest funnel step | All |
| W7 | 12/10 – 12/16 | Data analysis, validation report, final demo | PM + QA |

**Risks and mitigations**

- *Cold start / empty platform* — begin with custodians, who already hold physical inventory and have a reason to register it.
- *Low listing volume* — seed with the team's own genuinely unused items, clearly labelled as team listings, never counted as external validation.
- *Backend delay* — the frontend already runs offline-first; if cloud integration slips a week, the beta continues on a single shared device.
- *Privacy* — no phone numbers shown publicly; contact happens through an in-app reveal action that is logged.

---

## 5. Team Introduction

| Name | Student ID | Role | Responsibilities |
|---|---|---|---|
| [Name] | [ID] | Project lead / Customer validation | Interviews, scope control, metrics, final report |
| [Name] | [ID] | Frontend | UI implementation, interaction, mobile adaptation |
| [Name] | [ID] | Backend / Data | Backend service setup, schema design, deployment |
| [Name] | [ID] | Design / Content | Visual system, posters, copywriting, user onboarding material |
| [Name] | [ID] | QA / Documentation | Test cases, regression checks, documentation, demo script |

*Adjust names, IDs and role assignment to match the actual team.*

---

## 6. AI Usage Statement

AI tools were used for interface design iteration, code generation and refactoring, and copy editing. All customer interviews, requirement decisions, scope trade-offs and validation data are produced by team members. No synthetic users, fabricated interviews or inflated metrics will be reported; the seeded demo records shipped with the frontend are clearly separated from real user data and excluded from every metric above.
