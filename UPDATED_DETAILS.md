# UPDATED_DETAILS.md

What changed in the assessment data layer, and why. Written for a
maternal-health reviewer as much as for the next developer.

## 1. What this change does

Replaces the 12-question placeholder sample with the **complete 59-question
bilingual bank** transcribed from `ReadyMama Contents.pdf`, and extends the
scoring engine to handle the option counts the source actually uses.

| Bank | Questions | Category | Notes |
|---|---|---|---|
| Delivery Plan | 10 | `deliveryPlan` | |
| Hospital Bag | 10 | `hospitalBag` | |
| Emergency Plan | 10 | `emergencyPlan` | |
| Self-Preparedness | 10 | `selfPreparedness` | Likert-style |
| Support Person | 9 | `supportPerson` | scored subset, see §5 |
| Danger Signs | 10 | `null` | binary screener, never scored |
| **Total** | **59** | | 225 options, ×2 languages |

## 2. Files changed

| File | Change |
|---|---|
| `lib/features/assessment/data/question_bank.dart` | **Renamed** from `sample_questions.dart` (`git mv`, history preserved) and rewritten: 59 questions, 225 options |
| `assets/i18n/en.json` | `sample_questions` → `questions`; 284 keys |
| `assets/i18n/fil.json` | `sample_questions` → `questions`; 284 keys, identical key set |
| `lib/features/assessment/domain/scoring/scoring_engine.dart` | Explicit points table + per-question structural validation |
| `test/features/assessment/question_bank_test.dart` | **New** — 40 tests over the bank |
| `test/features/assessment/scoring_engine_test.dart` | +19 tests: the 2/3/4-option table and structural validation |

No `.g.dart` file was hand-edited; `build_runner` was re-run and reported no
drift requiring regeneration of the assessment models.

## 3. ID and key migration

| | Before | After |
|---|---|---|
| Question id | `sample.delivery_plan.q1` | `q.delivery_plan.q1` |
| Option id | `sample.delivery_plan.q1_a` | `q.delivery_plan.q1_a` |
| i18n namespace | `sample_questions` | `questions` |
| Prompt key | `sample_questions.delivery_plan.q1` | `questions.delivery_plan.q1` |
| Option key | `sample_questions.delivery_plan.q1_a` | `questions.delivery_plan.q1_a` |

Ids are stable strings so a persisted `QuestionResponse` replays against the
bank without retaining question objects. **Any stored responses from a build
using the old `sample.*` ids will not resolve** — there is no migration, since
this app has no real users yet.

Option suffixes are `a`/`b`/`c`/`d` for lettered questions, `sa`/`a`/`d`/`sd`
for the Likert scale, and `yes`/`no`/`not_sure`/`sometimes`/`partially` for
Support Person. Note `not_sure` itself contains an underscore — anything
parsing these ids must strip the question stem by length, not by splitting on
`_` (this bit the test suite during development).

## 4. Scoring

One explicit table, indexed by how many options a question offers, because the
source mixes option counts and does not derive one scale from another:

| Options | Rank 1 | Rank 2 | Rank 3 | Rank 4 |
|---|---|---|---|---|
| 2 | 5 | — | — | — |
| 3 | 5 | 3 | — | — |
| 4 | 5 | 3 | 2 | — |
| 4 | 5 | 3 | 2 | 1 |

- `maxPossible` = questions × 5, so 50 per 10-question bank.
- **The floor is 1, never 0.** The app measures degree of readiness, not
  pass/fail, so the worst possible answer still earns a point. All-worst-case
  is therefore 20%, not 0%.
- A 3-option question skips the "2 points" tier entirely (5/3/1), because
  Yes/Not sure/No has no "slightly prepared" middle.

### Where rank 1 comes from

| Bank | Source of rank 1 |
|---|---|
| Hospital Bag | The source's own published key (A=5, B=3, C=2, D=1) — the only bank the source ranks itself |
| Self-Preparedness | Strongly Agree → 1 |
| Delivery Plan, Emergency Plan | The source's own "Best answers" / "Answer Key" lists |
| Support Person | Yes → 1, with Not sure at 2 |
| Danger Signs | **Inverted** — rank 1 is the option that *is* the danger sign |

**Rank 1 is not always option A.** Delivery Plan Q2's key is B; Emergency Plan
Q2's is C; Emergency Q4, Q6, Q7, Q9, Q10 and Q1 also key off non-A letters.
Options are emitted in **source display order** with `rank` as a separate
attribute, so several questions have non-monotonic ranks (e.g. Delivery Q1 is
A=1, B=2, C=4, D=3). Any code that assumes "rank = position + 1" is wrong.

Ranks 2..N for Delivery Plan, Emergency Plan and Support Person are **not in
the source** — they were ordered by how prepared each option describes the
mother (most planning → least). These are judgement calls and are the most
worth a clinical reviewer's attention. See §7.

## 5. What was deliberately left out

**Support Person Q2** ("Who is your primary support person?", 7 categorical
options) is excluded from the scored bank. It is a relationship field, not a
readiness measure, so per AGENTS.md §5 it belongs to My Plan's
`SupportPersonRecord.relationship`. It is also 7 options, and the scoring table
is only defined for 2–4. Flattening it into the scored set would have meant
either inventing a 7-tier scale or pretending it is a readiness question.

**Support Person Q11–Q16** are plain data-entry blanks (name, relationship,
contact number, contact method, address, alternate contact). No readiness
wording, no scoring anywhere in the source. They become `SupportPersonRecord`
fields in My Plan so the Emergency Card can show them without the mother
entering them twice.

Also excluded, as follow-up capture rather than answer options: the "If yes,
who?" free-text blanks under Q1 and Q9, and Q8's item checklist.

Source numbering is preserved (`q1`, `q3`, `q4`, … `q10`) so every scored
question maps straight back to its page. **The source skips number 12** in the
English run (11 → 13) while the Tagalog run does contain a Q12. That gap sits
inside the excluded data-entry block, so nothing was renumbered and nothing was
invented to fill it.

## 6. Verbatim-copy policy, and the source oddities that were kept

Every prompt and option is copied character-for-character from the PDF,
**including its typos**. Nothing was paraphrased or "cleaned up". The oddities
that are now in shipped strings, on purpose:

| Where | Oddity |
|---|---|
| Self-Preparedness Q10 (EN) | Prompt begins `know how to recognize…` — the leading "I" is missing in the source |
| Emergency Q3 (FIL) | Prompt begins `Aling sintomas` — a source typo |
| Emergency Q7 (FIL) | Prompt reads `Ano ang dapat gawin` — missing "mong" |
| Self-Preparedness (FIL) | The source repeats the four Likert labels in **English** inside its Tagalog section, so the Tagalog bank reuses those English labels |
| Danger Signs, page 34 | A stray author note, `follw up ko nalang po yung references`, sits above the heading. Not question content; not copied |
| Hospital Bag (EN) | The numbering runs `10.Which` with no space after the number |
| Delivery Plan | The answer list writes `10.A` with no space |
| Emergency Plan (EN) | Every option ends with a full stop, unlike the other banks |
| Delivery Plan Q1 (FIL) | Ends `prenatal checkup` (singular) where the English says `checkups` |
| Delivery Plan Q8 (FIL) | Reads `mula sa aming bahay` ("our house") where the English says "my home" |
| Hospital Bag Q8 (FIL) | Says `kung kailangan mong pumunta agad sa ospital` where the English says "if you need to go to the health facility unexpectedly" |
| Hospital Bag Q10 (FIL) | Drops the English's opening "what my facility requires" clause |

Layout artifacts (a mid-sentence line break in Delivery Q10, trailing spaces at
line ends) were re-joined or trimmed; those are not content changes.

`test/features/assessment/question_bank_test.dart` pins the two most
consequential typos (the missing "I", `Aling sintomas`) with explicit
assertions, so a future "helpful" copy-edit fails the build rather than
silently diverging from the source.

## 7. Open questions for expert review

1. **The ranking judgements.** The source only ranks Hospital Bag. Every other
   bank's ranks 2..N are ours. In particular:
   - Delivery Q1: the source's key is A, but the "best" *distractor* ordering
     puts "I am still looking for a place" (D) above "I will decide when labor
     starts" (C). That was preserved from the previous sample bank, but it is
     arguable.
   - Emergency Q7 ranks "hold her down" as the most dangerous distractor and
     "put something in her mouth" as the least. That ordering is a judgement
     about harm, not something the source states.
   - Support Person Q4's four options are ranked "Yes, anytime" > "Sometimes" >
     "No" > "Not sure", putting *Not sure* below a definite *No* on the
     grounds that uncertainty is worse than a known negative. Debatable.
2. **Self-Preparedness Tagalog labels are still English.** The source has no
   Tagalog Likert scale. A Tagalog-speaking user sees English option labels
   there. Worth a proper translation pass.
3. **The scoring model is unvalidated.** Per READYMAMA_DETAILS.pdf's own
   roadmap, this needs a maternal-health professional before real deployment.
4. **Danger Signs has full Tagalog** (pages 38–40), contrary to an earlier
   assumption that only English existed. It is translated and shipped.

## 8. Verification performed

- `flutter pub get`
- `flutter analyze --no-fatal-infos` → no issues
- `flutter test` → 62 passing
- `flutter pub run build_runner build --delete-conflicting-outputs` → clean
- All 225 options × 2 languages (450 strings) were diffed mechanically against
  the `pdftotext` extraction of the PDF rather than by eye. That check caught
  6 real errors, all since fixed:
  - 5 option transpositions in Delivery Plan (Q1, Q3, Q8, Q9, Q10 in both
    languages) where the C/D — or B/C — options had been swapped;
  - 1 Tagalog typo, `kinabukusan` for the source's `kinabukasan`.
  The 58 strings inherited from the previous sample bank are now byte-identical
  to their originals.
- Tests assert per-bank counts, rank structure, id/key shape, and that all 284
  keys resolve in **both** locales.

## 9. What was not done

No UI work. The screens that consume this bank (assessment runner, results,
per-category progress) are still the placeholders described in AGENTS.md §9 and
are not wired to `question_bank.dart` yet. Nothing in `app_database.dart`, the
router, Learn, results, or reminders was touched.
