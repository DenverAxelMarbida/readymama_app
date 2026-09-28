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
| `assets/i18n/en.json` | `sample_questions` → `questions`; 284 keys; stale `categories`/`assessment.feedback` keys removed (§13) |
| `assets/i18n/fil.json` | `sample_questions` → `questions`; 284 keys, identical key set; same key removals |
| `lib/features/assessment/domain/scoring/scoring_engine.dart` | Explicit points table + per-question structural validation |
| `test/features/assessment/question_bank_test.dart` | **New** — 40 tests over the bank |
| `test/features/assessment/scoring_engine_test.dart` | +19 tests: the 2/3/4-option table and structural validation |
| `lib/core/database/app_database.dart` | `assessment_scores` gains a UNIQUE constraint on `category` (one row per category) + v2→v3 migration that dedupes legacy rows first (§12) |
| `test/core/database/app_database_test.dart` | **New** — upsert-uniqueness + v2→v3 migration tests |
| `tools/verify_question_bank.py` | **New** — mechanical PDF-fidelity verifier (§8) |

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
| 2 | 5 | 1 | — | — |
| 3 | 5 | 3 | 1 | — |
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

During this pass **Emergency Q4** was corrected: "Ignore the pain" moved from
rank 3 to rank 4 and "Take any medicine available" from rank 4 to rank 3, so
active ignoring is now the worst answer consistently with Emergency Q1/Q6/Q10
(see §11). This is the **only** rank change made; no other option, text, or
prompt was touched.

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

1. **The ranking judgements.**
   `[CLINICAL REVIEW]` The source only ranks Hospital Bag. Every other
   bank's ranks 2..N are ours. In particular:
   - Delivery Q1: the source's key is A, but the "best" *distractor* ordering
     puts "I am still looking for a place" (D) above "I will decide when labor
     starts" (C). That was preserved from the previous sample bank, but it is
     arguable.
   - `[CLINICAL REVIEW]` Emergency Q7 ranks "put something in her mouth"
     (`q7_a`, rank 4) as the most dangerous distractor and "hold her down
     tightly" (`q7_b`, rank 2) as the least — "keep her safe" (`q7_c`,
     rank 1) is the correct answer. The distractor ordering is a judgement
     about harm, not something the source states.
   - `[CLINICAL REVIEW]` Support Person Q4's four options are ranked
     "Yes, anytime" > "Sometimes" > "Not sure" > "No", putting "Not sure"
     *above* a definite "No" on the grounds that a known negative answer is
     easier to plan around than uncertainty. Debatable.
2. **Self-Preparedness Tagalog labels are still English.** The source has no
   Tagalog Likert scale. A Tagalog-speaking user sees English option labels
   there. Worth a proper translation pass.
3. **The scoring model is unvalidated.** Per READYMAMA_DETAILS.pdf's own
   roadmap, this needs a maternal-health professional before real deployment.
4. **Danger Signs has full Tagalog** (pages 38–40), contrary to an earlier
   assumption that only English existed. It is transcribed verbatim from the
   PDF and shipped.
5. **`[CLINICAL REVIEW]` Emergency Plan distractors still score well.**
   The universal 5/3/2/1 scale gives every non-best option real points, even
   on safety questions. E.g. Emergency Q1's "Rest and wait for it to stop."
   (`q1_a`, rank 2) scores 3 of 5 points despite being an unsafe answer to a
   bleeding emergency. Should wrong answers on *safety* questions score lower,
   or a flat 1, so an unsafe emergency response is not rewarded?
6. **`[CLINICAL REVIEW]` Danger Signs Q8 option C is not flagged.**
   "I am not sure if fluid is leaking or if it is just urine" does not trigger
   the automated alert (only option A does), yet an uncertain possible amniotic
   leak could be unsafe. Should C — and any other "I am not sure"-style option in
   Danger Signs — also trigger a seek-care prompt?
7. **`[BLOCKING]` Self-Preparedness EN and FIL: the two runs are not the
   same questionnaire.** Read against §10, the FIL run (PDF p.49–50) is
   largely the *same emotional-readiness instrument as the EN run in a
   different order* — EN Q4 ≈ FIL Q6 (knowledge reduces fears), EN Q5 ≈ FIL
   Q7 (what to do when anxious), EN Q6 ≈ FIL Q8/Q9 (whom to talk to, and
   being comfortable asking for support), and EN Q3's clauses are spread
   across FIL Q3–Q5 (remain calm / face pain / face problems). The real
   mismatch is at the tail: **EN Q7–Q10 (breastfeeding, newborn handling,
   newborn care, and recognising when the baby needs medical attention) have
   no FIL counterpart, and FIL Q10 (ready to care for self and baby after
   birth) has no EN counterpart.** The transcription is faithful in both
   languages (the verifier passes), so this is a source-content problem, not
   a typo. **The source authors must say which set is authoritative** — a
   Filipino user is never asked about breastfeeding or newborn care, which
   the English user is, so one category's score is not the same construct
   across languages. **Do not ship until that decision is made; do not change
   the bank meanwhile.**

## 8. Verification performed

- `flutter pub get`
- `flutter analyze --no-fatal-infos` → no issues
- `flutter test` → 69 passing
- `flutter pub run build_runner build --delete-conflicting-outputs` → clean
- All 568 strings were diffed mechanically against the `pdftotext` extraction
  of the PDF rather than by eye: 59 prompts × 2 languages (118) plus 225
  options × 2 languages (450). The option check caught 6 real errors, all
  since fixed:
  - 5 option transpositions in Delivery Plan (Q1, Q3, Q8, Q9, Q10 in both
    languages) where the C/D — or B/C — options had been swapped;
  - 1 Tagalog typo, `kinabukusan` for the source's `kinabukasan`.
  The prompt-text check (new in this pass) caught 2 further transcription
  errors, also fixed:
  - **Support Person Q10 (FIL)** shipped `natatanggap ko`; the source
    (PDF p.56–61, "Do you receive enough support …") reads `natatanggap mo`.
  - **Self-Preparedness Q9 (FIL)** shipped `Komfortable`; the source
    (PDF p.50) reads `Komportable`.
  The 58 strings inherited from the previous sample bank are now byte-identical
  to their originals.
- Tests assert per-bank counts, rank structure, id/key shape, and that all 284
  keys resolve in **both** locales.

## 9. What was not done

No UI work. The screens that consume this bank (assessment runner, results,
per-category progress) are still the placeholders described in AGENTS.md §9 and
are not wired to `question_bank.dart` yet. Nothing in the router, Learn,
results, or reminders was touched. `app_database.dart` was changed only for the
`assessment_scores` single-row-per-category UNIQUE key and its v2→v3 migration
(see §12), not for assessment-related scoring or UI.

## 10. Self-Preparedness EN/FIL pairing audit (report-only)

Extracted from the PDF itself (EN run: p.42–43; FIL run: p.49–50), **not** from
`en.json`/`fil.json`, so the table shows whether the transcription or the
source is the problem. Nothing in the bank or the JSONs was changed by this
audit.

| id | EN prompt | FIL prompt | same question? | PDF page |
|---|---|---|---|---|
| Q1 | I feel emotionally prepared for the changes that pregnancy, childbirth, and becoming a mother may bring to my life. | Nakakaramdam ako na handa ako sa mga pagbabago… dahil sa pagbubuntis at panganganak. | **yes** | 42 / 49 |
| Q2 | I can manage my emotions when I experience fear, worry, or stress during pregnancy. | Kaya kong kontrolin ang aking emosyon… takot, pag-aalala, o stress habang buntis. | **yes** | 42 / 49 |
| Q3 | I feel confident that I can remain calm **and cope with pain, fear, or unexpected situations** during childbirth. | Kaya kong manatiling kalmado kapag naiisip ko ang aking panganganak. | **partly** (FIL drops the "cope with pain/fear/unexpected" clause) | 42 / 49 |
| Q4 | I have enough **knowledge about pregnancy and childbirth** to help reduce my fears and worries. | Handa akong **harapin ang sakit, hirap, o takot**… habang nanganganak. | **no** (EN = knowledge; FIL = readiness to face labour pain) | 42 / 49 |
| Q5 | I know **healthy ways to cope** when I feel anxious, stressed, or overwhelmed during pregnancy. | Naniniwala akong **kaya kong harapin ang mga problema**… habang nanganganak. | **no** (EN = coping strategies; FIL = belief I can handle problems) | 43 / 49 |
| Q6 | I know **whom to approach… for emotional support**. | May sapat akong **kaalaman tungkol sa panganganak** upang mabawasan ang takot at pag-aalala. | **no** (FIL Q6 ≈ EN Q4's concept) | 43 / 50 |
| Q7 | I feel confident that I can properly **breastfeed** my baby… | Alam ko kung **ano ang maaari kong gawin kapag kaba, stress**… habang buntis. | **no** (FIL Q7 ≈ EN Q5's concept; breastfeeding absent in FIL) | 43 / 50 |
| Q8 | I feel confident that I can safely **hold, carry, and handle my newborn**… | Alam ko **kung sino ang maaari kong kausapin**… bigat ng loob habang buntis. | **no** (FIL Q8 ≈ EN Q6's concept; newborn handling absent in FIL) | 43 / 50 |
| Q9 | I know how to perform **basic newborn care**… diaper changing… | Komportable akong **humingi ng emosyonal na suporta** sa asawa/partner… | **no** (FIL Q9 is the support half of EN Q6) | 43 / 50 |
| Q10 | I know how to **recognize when my baby needs medical attention**. | Nakakaramdam ako na handa ako sa **isip at damdamin na alagaan ang aking sarili at ang sanggol** pagkatapos manganak. | **no** (EN = recognising medical need; FIL = ready to care for self+baby after birth) | 43 / 50 |

**Finding: the PDF itself contains two different questionnaires.** Only Q1–Q2
(and Q3 loosely) are translations of each other; the FIL run is a distinct
parallel instrument (facing labour pain, coping-when-anxious, who-to-talk-to,
asking for support) while the EN run covers breastfeeding, newborn
handling/care, and recognising medical need — topics entirely absent from the
FIL run. The transcription is faithful in both languages (the 568-string
verifier passes), so this is a source-content problem, not a typo. Tracked as
the `[BLOCKING]` item 7 in §7. A Tagalog user is scored on different readiness
items than an English user, so the category is not the same construct across
languages.

## 11. Ranking audit (report-only)

Every question whose ranks 2..N were judgement. Hospital Bag,
Self-Preparedness, and Danger Signs are excluded: their order is defined by the
source (5/3/2/1) or by rule (screener). Support Person options have no display
letters, so their suffix type is shown instead. **Nothing here was changed.**

| id | shipped ranks | one-line reason for ranks 2..N |
|---|---|---|
| delivery_plan.q1 | A=1 B=2 C=4 D=3 | Planned facility best; home 2; "still looking" beats "decide at labour" (searching is progress). |
| delivery_plan.q2 | A=2 B=1 C=3 D=4 | Planned ride best; will-wait-for-ride 2; find-ride-at-labour 3; never-thought 4. |
| delivery_plan.q3 | A=1 B=2 C=4 D=3 | Trusted companion best; anyone-available 2; not-decided beats alone (alone most isolating). |
| delivery_plan.q4 | A=1 B=2 C=3 D=4 | Full agreement+awareness best; mentioned-once 2; will-talk-at-labour 3; never-talked 4. |
| delivery_plan.q5 | A=2 B=1 C=3 D=4 | Backup plan best; wait-for-someone 2; search-after-stronger-contractions 3; stay-home 4. |
| delivery_plan.q6 | A=1 B=2 C=3 D=4 | Funds set aside best; some-money-no-plan 2; borrow-if-needed 3; nothing 4. |
| delivery_plan.q7 | A=1 B=2 C=3 D=4 | Before EDD best; at labour 2; after arrival 3; unplanned 4. |
| delivery_plan.q8 | A=1 B=2 C=4 D=3 | Full facility knowledge best; doctor-name-only 2; **cost-only 4** (cost least useful in an emergency) beats distance-only 3. |
| delivery_plan.q9 | A=1 B=3 C=2 D=4 | Backup plan best; **food&water 2 beats extra clothes 3** (sustenance > spare clothes); decide-at-time 4. |
| delivery_plan.q10 | A=1 B=3 C=2 D=4 | Full plan best; **bag-ready-no-plan 2 beats know-hospital-no-transport 3** (tangibles > partial knowledge); plan-at-labour 4. |
| emergency_plan.q1 | A=2 B=1 C=3 D=4 | Seek-help-immediately best; rest&wait 2; drink-water 3; ignore 4. |
| emergency_plan.q2 | A=2 B=3 C=1 D=4 | Contact-provider best; wait-until-next-day 2; bath&sleep 3; exercise-to-induce-labour 4 (active risk). |
| emergency_plan.q3 | A=1 B=2 C=3 D=4 | Headache+blurred vision is the danger sign (best match = rank 1); mild-hunger 2; sleepy 3; backache 4. |
| emergency_plan.q4 | A=4 B=2 C=1 D=3 | Seek-help best; wait-for-checkup 2; **take-any-medicine 3; ignore-pain 4** (active ignoring is as unsafe as Q1/Q6/Q10's ignore options). |
| emergency_plan.q5 | A=1 B=2 C=3 D=4 | Bag+records best; new-clothes 2; week-of-food 3; toys 4. |
| emergency_plan.q6 | A=2 B=1 C=3 D=4 | Seek-advice-promptly best; wait-until-tomorrow 2; sleep 3; ignore 4. |
| emergency_plan.q7 | A=4 B=2 C=1 D=3 | Safe-from-injury+emergency help best; hold-her-down 2; give-food/water 3; put-something-in-her-mouth 4 (`[CLINICAL REVIEW]`). |
| emergency_plan.q8 | A=1 B=2 C=3 D=4 | Records+ID+meds best; toys 2; makeup 3; nothing 4. |
| emergency_plan.q9 | A=4 B=1 C=2 D=3 | Reach-facility-quickly best; save-money 2; travel-for-fun 3; **avoid-hospital 4**. |
| emergency_plan.q10 | A=2 B=1 C=4 D=3 | Know-signs+bag+plan best; wait-for-emergency 2; someone-else-decides 3; **ignore-unusual-symptoms 4**. |
| support_person.q1 | yes=1 no=2 | Binary yes/no. |
| support_person.q3 | yes=1 sure=2 no=3 | Yes best; not-sure 2; no 3. |
| support_person.q4 | anytime=1 sometimes=2 sure=3 no=4 | Anytime best; sometimes 2; not-sure 3; no 4. |
| support_person.q5 | yes=1 no=2 | Binary yes/no. |
| support_person.q6 | yes=1 sure=2 no=3 | Yes best; not-sure 2; no 3. |
| support_person.q7 | yes=1 sure=2 no=3 | Yes best; not-sure 2; no 3. |
| support_person.q8 | yes=1 partially=2 sure=3 no=4 | Yes best; partially 2; not-sure 3; no 4. |
| support_person.q9 | yes=1 no=2 | Binary yes/no. |
| support_person.q10 | yes=1 sometimes=2 no=3 | Yes best; sometimes 2; no 3. |

### Places where the same kind of option is ranked differently

| Location | Status | Recommendation |
|---|---|---|
| Emergency Q1/Q6/Q10 vs Q4 | **RESOLVED** — "ignore it" was last (4) in Q1(`d`), Q6(`d`), Q10(`c`) but Q4 ranked "Ignore the pain" at 3; Q4 is now A=4 B=2 C=1 D=3. | Applied: "ignore the pain" is now rank 4 and "take any medicine" rank 3 — actively ignoring a severe symptom is as unsafe as self-medicating. |
| Delivery Q9 | Open. "Only extra clothes" = 3 vs "Only food and water" = 2. Defensible (provisions > clothes) but both are wrong-answer distractors. | Acceptable as-is; if strictness preferred, tie both at 3 or make both 4. Low priority. |
| Delivery Q10 | Open. "know the hospital, no transport" = 3 vs "bag ready, no emergency plan" = 2. A plan-less but prepared bag outscores knowing the hospital with no way to get there. | Defensible; note it conflicts with Q9's "plan > items" logic. Either is fine — document the choice. |
| Delivery Q1 vs Q3 | Consistent. Both rank the "active bad choice" as 4 ("decide at labour", "go alone") and the "undecided" option as 3. | No change. |

Internal-consistency notes: Emergency Q2/Q4/Q6 all rank "wait until …" at 2 —
consistent. Support Person ranks partial states (sure/partially/sometimes) at 2
or 3 uniformly across q3/q4/q6/q7/q8/q10 — consistent.

## 12. How the migration dedupe was verified

`test/core/database/app_database_test.dart` holds a dedicated v2→v3 migration
test (`v2 -> v3 migration dedupes legacy duplicate rows per category`):

1. It opens a **raw `sqlite3` in-memory database** and hand-builds the exact
   v2 `assessment_scores` schema (the table before the UNIQUE-category key
   existed), with no drift/tooling involved.
2. It inserts **duplicate rows for one category interleaved with another
   category** — `deliveryPlan(30)`, `hospitalBag(40)`, `deliveryPlan(35)` — so
   ordering is well-defined and the surviving-row rule is actually exercised
   rather than trivialised.
3. It sets `userVersion = 2` and hands that handle to
   `AppDatabase.forTesting(NativeDatabase.opened(legacyDb))`, forcing the real
   app migration to run against the legacy file.
4. Assertions:
   - `deliveryPlan` collapses to **exactly one row**;
   - the survivor is the **newest (highest id)** — score `35`, not `30`
     (the migration uses `DELETE … WHERE id NOT IN (SELECT MAX(id) …
     GROUP BY category)`, keeping the latest write per category);
   - the non-duplicated `hospitalBag` row (score `40`) survives untouched;
   - the table ends with **2 rows total**.

The also-passing upsert tests cover the happy path without migration:
upserting the same category twice leaves one row with the latest score, and
upserting all five categories leaves exactly five rows.

## 13. Removed i18n keys: no remaining references

Part 4 removed four stale keys from **both** `assets/i18n/en.json` and
`assets/i18n/fil.json`:

| Key | Where it lived | Why removed |
|---|---|---|
| `transportation_plan` | `categories` | Not a category (AGENTS.md §2) |
| `emergency_fund` | `categories` | Not a category (AGENTS.md §2) |
| `transportation_needs_preparation` | `assessment.feedback` | No category to feed |
| `emergency_fund_needs_preparation` | `assessment.feedback` | No category to feed |

`delivery_plan_not_ready` / `emergency_plan_not_ready` were kept; and
`self_preparedness` was **added** to `categories`. Confirmation of zero
residual references (pattern `transportation|emergency_fund` over `assets/`,
`lib/`, `test/`):

- `grep -rn "transportation\|emergency_fund" assets/ lib/ test/` → **0 matches**
  in source: the only hits are the `transportation` word inside legitimate
  question text (e.g. Delivery Q2/Q5/Q9, Emergency Q9, Support Person Q6) —
  none reference the removed keys.
- `grep -rn "transportation\|emergency_fund" lib/ test/` → **0 matches**; no
  Dart code references the removed keys (all string lookup goes through
  `AppI18n.t()`).
- Both files remain valid JSON with **identical key sets** across locales
  (asserted by the existing i18n tests in `test/features/assessment/…`).
- The only `grep` hits anywhere in the repo are **stale `build/`
  artifacts** (copies of earlier i18n JSONs) — these regenerate on the next
  `flutter build` and are not source references, and `AGENTS.md` §2, which
  intentionally documents the old 7-value enum and this correction (historical
  record, not a code reference).
