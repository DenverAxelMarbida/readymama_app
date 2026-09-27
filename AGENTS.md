# AGENTS.md — ReadyMAMA persistent project context

This file is the first thing any coding agent (OpenCode, Claude Code, etc.)
should read before touching this repository. It captures decisions made
during architecture planning that are NOT yet reflected in code, so the
agent doesn't have to rediscover them or, worse, re-assume the old
(incorrect) structure that shipped in earlier commits.

If anything in this file conflicts with `.ai/PROJECT_RULES.md`, treat both
as binding — `PROJECT_RULES.md` governs *how* to write code (architecture
layering, codegen, i18n discipline), this file governs *what the product
actually is*.

---

## 1. Source of truth hierarchy

In order, when anything is ambiguous or the code disagrees with a document:

1. **ReadyMama_Contents.pdf** (61 pages) — the actual bilingual (English +
   Tagalog) question bank and educational copy for every category. This is
   the master content source. Nothing in the app should contradict it.
2. **READYMAMA_DETAILS.pdf** (8 pages) — the original app proposal. Defines
   the feature list, the Plan A/Plan B concept, the offline-first
   requirement, and the "6 preparation categories" framing.
3. **UI.pdf** — the mockup (8 screens: Home Dashboard, Assess Overview,
   One-Question Assessment, Results, My Plan, Hospital Bag, Learn,
   Emergency Card). This defines screen structure and the 5-tab nav.
4. **The current codebase** — was built from an earlier, incorrect
   assumption about category structure (see §2). It is being corrected to
   match documents 1–3, not the other way around.

**Do not invent content.** If a scoring rule, a body-copy paragraph, or a
UI detail isn't in one of the three documents above, flag it as an open
question rather than filling it in. This project has already had one
significant structural assumption corrected (see §2) from guessing instead
of checking the source — don't repeat that pattern.

---

## 2. Corrected category structure (IMPORTANT — code does not yet reflect this)

The codebase's original `AssessmentCategory` enum
(`lib/core/database/app_database.dart`) has 7 values:
```
deliveryPlan, transportationPlan, emergencyFund, hospitalBag,
supportPerson, emergencyPlan, dangerSignKnowledge
```

This is **wrong**. `transportationPlan` and `emergencyFund` do not exist
as categories anywhere in the source material — transportation and money
questions are just questions #2 and #6 inside the Delivery Plan quiz.
`selfPreparedness` is missing entirely, despite being the largest single
section in ReadyMama_Contents.pdf (14 of 61 pages).

**The correct 6 categories**, in source order, are:
1. Delivery Plan
2. Hospital Bag (covers both Mother and Baby items in one 10-question quiz
   — the Mother/Baby split only applies to the *checklist* in My Plan,
   already correctly modeled by `ChecklistOwner` in `ChecklistItems`)
3. Emergency Plan
4. Danger Signs (see §4 — this one is NOT a scored category)
5. Self-Preparedness
6. Support Person (see §5 — this one is split between scored and
   data-entry halves)

So `AssessmentCategory` (the enum backing the *scored* `AssessmentScores`
table) should end up with **5 values**: `deliveryPlan`, `hospitalBag`,
`emergencyPlan`, `selfPreparedness`, `supportPerson`. Danger Signs is
tracked in its own table, not this enum.

---

## 3. The two-layer model: Assess vs. My Plan

- **Assess tab** = the scored questionnaire. Answers scores in `AssessmentScores`.
- **My Plan tab** = the actionable workspace where the mother actually
  builds her plan: Delivery Plan details, Hospital Bag checklist (already
  built), Support Person contact record, Emergency Plan A/B.

They are connected, not independent: My Plan's per-section status badges
read from `AssessmentScores`, and a low score in a category should point
the Dashboard's "Next Thing To Do" card at the matching My Plan section.

Data ownership:

| Record | Written in | Also read by |
|---|---|---|
| `AssessmentScores` (existing table, now 5 categories) | Assess | Dashboard, My Plan status badges |
| `DeliveryPlanRecord` (new) | My Plan | Emergency Card |
| `ChecklistItems` (existing) | My Plan | Dashboard progress |
| `SupportPersonRecord` (new) | My Plan | Emergency Card, Emergency quick-dial |
| `EmergencyPlanRecord` (new — the Plan A / Plan B data) | My Plan | Emergency Card, Emergency quick-dial |
| `DangerSignsScreening` (new, see §4) | Assess | Emergency alert trigger |

Learn tab has no data dependency at all — it's static bilingual reference
content plus (eventually) video, nothing is written or read from the
database for it.

---

## 4. Danger Signs is a screener, not a score — do not put it in the 0–100 dashboard number

ReadyMama_Contents.pdf's own scoring instructions for this section are
explicit: *"If Option A is selected for ANY question → DANGER SIGN
DETECTED"* → the app should surface an immediate "seek care now" alert.
If B/C/D on all 10 → no immediate danger signs.

This is a real-time binary safety screener, not a readiness metric. It
must not be averaged into the Birth Preparedness Score, and a "danger
detected" result should route straight to the Emergency tab / an
emergency CTA — never sit quietly as a percentage.

Implementation: a `DangerSignsScreening` table/model separate from
`AssessmentScores` (fields roughly: `id`, `isDangerDetected`,
`triggeringQuestionIds`, `completedAt`). Do not add `dangerSigns` back
into the `AssessmentCategory` enum.

---

## 5. Support Person is split — first 10 items scored, rest is data entry

Reading the actual Support Person pages (55–61) closely: items 1–10 are
Yes/No/Not Sure readiness questions (these DO score, and belong to
Assess → `AssessmentScores`). Items 11 onward are plain data fields — full
name, relationship, contact number, address, alternate contact — with no
scoring anywhere. Those belong to My Plan → `SupportPersonRecord`, and
that same record is what the Emergency Card's "Support Person /
Significant Other" field displays. She should never have to enter this
information twice.

---

## 6. Scoring model (chosen: "Model 1" — universal 4-tier ordinal scale)

Only Hospital Bag has an explicit weight scheme in the source (A=5 Well
Prepared, B=3 Prepared, C=2 Slightly Prepared, D=1 Not Prepared). Rather
than inventing a different formula per category, that same convention is
extended everywhere, with one correction: **the floor is always 1, never
0** — even the worst answer still earns a point, because the app measures
degree of readiness, not pass/fail.

- **Hospital Bag, Self-Preparedness**: direct 5/3/2/1 mapping onto their
  existing 4-option scales (Self-Preparedness's Strongly Agree → Strongly
  Disagree maps the same way).
- **Delivery Plan, Emergency Plan**: these have a "best answer" key per
  question, but the best letter isn't always A (it varies by question).
  Rank each question's four options by their actual described degree of
  readiness — not by letter position — and apply 5/3/2/1 to that ranking.
  The correct ranking is usually obvious from what each option says (e.g.
  "already have a planned ride" > "will find a ride when labor starts" >
  "haven't thought about it").
- **Support Person items 1–10** (Yes/No/Not Sure, 3 tiers): Yes=5, Not
  Sure=3, No=1.
- Each category: 10 questions × max 5 = 50 raw points → convert to a
  0–100% per category.
- Overall dashboard score = average of the 5 scoreable categories'
  percentages (Danger Signs excluded, see §4).
- Each category's % buckets into the 4 existing status tiers already in
  `assets/i18n/*.json` (`ready`, `needs_preparation`, `not_yet_ready`,
  `needs_improvement`) for My Plan's section badges.

**This has NOT been reviewed by a maternal-health professional.** Per
READYMAMA_DETAILS.pdf's own development roadmap (step 2, "expert review"),
this scoring model should be sanity-checked before real deployment. Ship
it as the working implementation, but don't treat it as clinically
validated.

---

## 7. Navigation structure (target state — not yet built)

Five bottom-nav tabs, in this order: **Dashboard, Assessment, My Plan,
Emergency, Learn.**

- **My Plan** is a cosmetic rename of the current Hospital Bag tab for now
  — same screen, same routes, same files, label only. The full My Plan
  aggregator (Delivery Plan / Hospital Bag / Support Person / Emergency
  Plan as four sections with a rolled-up progress bar, matching UI.pdf
  screen 5) is a deliberately deferred, larger task — do not build it
  opportunistically inside an unrelated prompt.
- **Learn** replaces Profile's old tab slot. It's a new feature
  (`lib/features/learn/`) with 5 topics matching UI.pdf screen 7 exactly:
  Pregnancy Danger Signs, Preparing for Delivery, Self-Preparedness and
  Affirmation, Hospital Bag Guide, Support Person. Only
  Self-Preparedness has video content, and that content is
  **placeholder-only** — no real video files exist yet, do not fetch,
  generate, or invent any.
- **Profile** moves out of the bottom nav entirely, reachable via a
  hamburger Drawer opened from the Dashboard's AppBar. The drawer also
  hosts Language toggle (EN/FIL — navigates to Profile for now, real
  reactive locale switching is a separate follow-up task), Terms &
  Conditions (new placeholder screen), and About ReadyMAMA (new
  placeholder screen).
- Emergency Plan does NOT appear in Learn's topic list, even though it
  has its own educational copy in the source material — that content's
  eventual home is the Emergency tab itself, not Learn.

---

## 8. Build-order philosophy (don't skip ahead)

Agreed sequencing for this project, do not reprioritize without being
asked:

1. **Functionality + mockup-faithful UI, together — not sequential.** The
   mockup is the spec for how data should be organized, not a skin
   applied after logic works.
2. Accessibility per `.ai/PROJECT_RULES.md` (icon+text pairing, contrast,
   touch targets) is part of "done," not a later polish pass.
3. Content/scoring should get expert review and pilot testing before
   being treated as final (per READYMAMA_DETAILS.pdf's own roadmap).
4. Marketing-grade visual flourish (animations, custom illustrations,
   celebratory micro-interactions, final app icon/launch screen) comes
   **last**, and ideally only where pilot testing shows it's actually
   needed — this app's audience (low-literacy, possibly low-connectivity
   users) is not well served by unnecessary visual complexity.

---

## 9. Current known-placeholder state (as of this file's writing)

These screens are intentionally still "Section 1 placeholder" stubs, not
missing features to panic about: `AssessmentScreen`,
`AssessmentResultsScreen`, `HospitalBagScreen` (real build pending the My
Plan decision above), `EmergencyScreen`, `RemindersScreen`,
`ProfileScreen`. `DashboardScreen` is also a placeholder pending its real
Section 3 build.

`pubspec.yaml` does not yet include `video_player`. `en.json`/`fil.json`'s
`categories` object still has the old 7-category keys
(`transportation_plan`, `emergency_fund` need removal; `self_preparedness`
needs adding) — this is a correction, not a deprecation, so removing the
wrong keys is appropriate even though `.ai/PROJECT_RULES.md` generally
prefers additive changes.

---

## 10. Non-negotiables (repeated from PROJECT_RULES.md because they matter most here)

- No hardcoded user-facing strings — every string goes through
  `AppI18n.t()` with keys added to BOTH `en.json` and `fil.json` in the
  same change.
- Never hand-edit a `.g.dart` file. Edit the source annotation/table and
  run `flutter pub run build_runner build --delete-conflicting-outputs`.
- Full-file output with a `// <path>` header comment on line 1 for every
  file created or touched.
- Prefer additive changes; the category-enum correction in §2 is a named
  exception because it fixes a factual error, not a preference change —
  don't use it as precedent for unrelated refactors.
