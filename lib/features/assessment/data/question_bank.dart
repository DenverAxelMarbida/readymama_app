// lib/features/assessment/data/question_bank.dart
import 'package:readymama_app/core/database/app_database.dart';
import 'package:readymama_app/features/assessment/domain/models/question.dart';
import 'package:readymama_app/features/assessment/domain/models/question_option.dart';

/// The full ReadyMAMA question bank, transcribed verbatim from
/// `ReadyMama Contents.pdf` (61 pages, the master content source; AGENTS.md
/// §1). Every prompt and option string is copied character-for-character from
/// the source, INCLUDING its typos, odd punctuation and capitalization — see
/// the "Source oddities" notes on each bank. Nothing here may be paraphrased
/// or "cleaned up".
///
/// i18n: every `promptKey` / `labelKey` resolves through `AppI18n.t()` to
/// `questions.<category>.q<n>[_<option>]` in BOTH `assets/i18n/en.json` and
/// `assets/i18n/fil.json`. Stable ids use the `q.` namespace
/// (`q.<category>.q<n>`, `q.<category>.q<n>_<option>`) so a saved response
/// replays against this bank without holding question objects.
///
/// Ranks: `1` is the best answer per the source's own key, and the source
/// letter is NOT always A — Delivery Plan Q2 and Emergency Plan Q2 are
/// answered B and C respectively. Ranks 2..N were ordered by how prepared the
/// option describes the mother (most planning -> least), which is a judgement
/// call the source only makes for Hospital Bag. The floor is always 1, never 0
/// (AGENTS.md §6).
///
/// Options are listed in SOURCE DISPLAY ORDER (A, B, C, D / Yes, No, Not
/// sure ...). `rank` is a separate attribute, so a question's ranks are not
/// necessarily monotonic down the list.

/// DELIVERY PLAN — 10 scored questions.
///
/// Ranks: the source's own 'Best answers' list (1.A 2.B 3.A 4.A 5.B 6.A
/// 7.A 8.A 9.A 10.A) supplies rank 1. Ranks 2-4 are a judgement call, ordered
/// by how much planning each option describes: e.g. Q2 'already have a
/// planned ride' > 'wait for family to find a ride' > 'will find a ride only
/// when labor starts' > 'have not thought about it yet'.
///
/// Source oddities, copied verbatim and deliberately NOT corrected:
/// * Q10 option A is broken across two lines mid-sentence in the PDF
///   ('...and what I need / to bring'); the line break is a layout artifact
///   and has been re-joined here.
/// * The source's answer list writes '10.A' with no space after the number.
/// * Tagalog Q1 A ends 'prenatal checkup' (singular) where the English says
///   'prenatal checkups' (plural).
/// * Tagalog Q8 D reads 'mula sa aming bahay' ('our house') where the English
///   says 'my home'.
const List<Question> deliveryPlanQuestions = [
  Question(
    id: "q.delivery_plan.q1",
    category: AssessmentCategory.deliveryPlan,
    promptKey: "questions.delivery_plan.q1",
    options: [
      QuestionOption(
        id: "q.delivery_plan.q1_a",
        labelKey: "questions.delivery_plan.q1_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.delivery_plan.q1_b",
        labelKey: "questions.delivery_plan.q1_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.delivery_plan.q1_c",
        labelKey: "questions.delivery_plan.q1_c",
        rank: 4,
      ),
      QuestionOption(
        id: "q.delivery_plan.q1_d",
        labelKey: "questions.delivery_plan.q1_d",
        rank: 3,
      ),
    ],
  ),
  Question(
    id: "q.delivery_plan.q2",
    category: AssessmentCategory.deliveryPlan,
    promptKey: "questions.delivery_plan.q2",
    options: [
      QuestionOption(
        id: "q.delivery_plan.q2_a",
        labelKey: "questions.delivery_plan.q2_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.delivery_plan.q2_b",
        labelKey: "questions.delivery_plan.q2_b",
        rank: 1,
      ),
      QuestionOption(
        id: "q.delivery_plan.q2_c",
        labelKey: "questions.delivery_plan.q2_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.delivery_plan.q2_d",
        labelKey: "questions.delivery_plan.q2_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.delivery_plan.q3",
    category: AssessmentCategory.deliveryPlan,
    promptKey: "questions.delivery_plan.q3",
    options: [
      QuestionOption(
        id: "q.delivery_plan.q3_a",
        labelKey: "questions.delivery_plan.q3_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.delivery_plan.q3_b",
        labelKey: "questions.delivery_plan.q3_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.delivery_plan.q3_c",
        labelKey: "questions.delivery_plan.q3_c",
        rank: 4,
      ),
      QuestionOption(
        id: "q.delivery_plan.q3_d",
        labelKey: "questions.delivery_plan.q3_d",
        rank: 3,
      ),
    ],
  ),
  Question(
    id: "q.delivery_plan.q4",
    category: AssessmentCategory.deliveryPlan,
    promptKey: "questions.delivery_plan.q4",
    options: [
      QuestionOption(
        id: "q.delivery_plan.q4_a",
        labelKey: "questions.delivery_plan.q4_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.delivery_plan.q4_b",
        labelKey: "questions.delivery_plan.q4_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.delivery_plan.q4_c",
        labelKey: "questions.delivery_plan.q4_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.delivery_plan.q4_d",
        labelKey: "questions.delivery_plan.q4_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.delivery_plan.q5",
    category: AssessmentCategory.deliveryPlan,
    promptKey: "questions.delivery_plan.q5",
    options: [
      QuestionOption(
        id: "q.delivery_plan.q5_a",
        labelKey: "questions.delivery_plan.q5_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.delivery_plan.q5_b",
        labelKey: "questions.delivery_plan.q5_b",
        rank: 1,
      ),
      QuestionOption(
        id: "q.delivery_plan.q5_c",
        labelKey: "questions.delivery_plan.q5_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.delivery_plan.q5_d",
        labelKey: "questions.delivery_plan.q5_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.delivery_plan.q6",
    category: AssessmentCategory.deliveryPlan,
    promptKey: "questions.delivery_plan.q6",
    options: [
      QuestionOption(
        id: "q.delivery_plan.q6_a",
        labelKey: "questions.delivery_plan.q6_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.delivery_plan.q6_b",
        labelKey: "questions.delivery_plan.q6_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.delivery_plan.q6_c",
        labelKey: "questions.delivery_plan.q6_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.delivery_plan.q6_d",
        labelKey: "questions.delivery_plan.q6_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.delivery_plan.q7",
    category: AssessmentCategory.deliveryPlan,
    promptKey: "questions.delivery_plan.q7",
    options: [
      QuestionOption(
        id: "q.delivery_plan.q7_a",
        labelKey: "questions.delivery_plan.q7_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.delivery_plan.q7_b",
        labelKey: "questions.delivery_plan.q7_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.delivery_plan.q7_c",
        labelKey: "questions.delivery_plan.q7_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.delivery_plan.q7_d",
        labelKey: "questions.delivery_plan.q7_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.delivery_plan.q8",
    category: AssessmentCategory.deliveryPlan,
    promptKey: "questions.delivery_plan.q8",
    options: [
      QuestionOption(
        id: "q.delivery_plan.q8_a",
        labelKey: "questions.delivery_plan.q8_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.delivery_plan.q8_b",
        labelKey: "questions.delivery_plan.q8_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.delivery_plan.q8_c",
        labelKey: "questions.delivery_plan.q8_c",
        rank: 4,
      ),
      QuestionOption(
        id: "q.delivery_plan.q8_d",
        labelKey: "questions.delivery_plan.q8_d",
        rank: 3,
      ),
    ],
  ),
  Question(
    id: "q.delivery_plan.q9",
    category: AssessmentCategory.deliveryPlan,
    promptKey: "questions.delivery_plan.q9",
    options: [
      QuestionOption(
        id: "q.delivery_plan.q9_a",
        labelKey: "questions.delivery_plan.q9_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.delivery_plan.q9_b",
        labelKey: "questions.delivery_plan.q9_b",
        rank: 3,
      ),
      QuestionOption(
        id: "q.delivery_plan.q9_c",
        labelKey: "questions.delivery_plan.q9_c",
        rank: 2,
      ),
      QuestionOption(
        id: "q.delivery_plan.q9_d",
        labelKey: "questions.delivery_plan.q9_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.delivery_plan.q10",
    category: AssessmentCategory.deliveryPlan,
    promptKey: "questions.delivery_plan.q10",
    options: [
      QuestionOption(
        id: "q.delivery_plan.q10_a",
        labelKey: "questions.delivery_plan.q10_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.delivery_plan.q10_b",
        labelKey: "questions.delivery_plan.q10_b",
        rank: 3,
      ),
      QuestionOption(
        id: "q.delivery_plan.q10_c",
        labelKey: "questions.delivery_plan.q10_c",
        rank: 2,
      ),
      QuestionOption(
        id: "q.delivery_plan.q10_d",
        labelKey: "questions.delivery_plan.q10_d",
        rank: 4,
      ),
    ],
  ),
];

/// HOSPITAL BAG — 10 scored questions.
///
/// Ranks: the source prints its own weighting beneath the questionnaire —
/// 'A = 5 Well Prepared, B = 3 Prepared, C = 2 Slightly Prepared,
/// D = 1 Not Prepared' (Tagalog: 'A = 5 Handa na Handa, B = 3 Handa,
/// C = 2 Medyo Handa, D = 1 Hindi Pa Handa'). Letter order IS the ranking
/// here: A=1, B=2, C=3, D=4. This is the one bank the source ranks itself,
/// and the scale it defines is the one AGENTS.md §6 generalises elsewhere.
///
/// Source oddities, copied verbatim and deliberately NOT corrected:
/// * The English numbering runs '10.Which' with no space after the number.
/// * Tagalog Q8's prompt says 'kung kailangan mong pumunta agad sa ospital'
///   where the English says 'if you need to go to the health facility
///   unexpectedly' — the two word the same idea differently.
/// * Tagalog Q10 A drops the English's opening 'what my facility requires'
///   clause and starts at 'Alam ko ang mga kailangang dalhin'.
const List<Question> hospitalBagQuestions = [
  Question(
    id: "q.hospital_bag.q1",
    category: AssessmentCategory.hospitalBag,
    promptKey: "questions.hospital_bag.q1",
    options: [
      QuestionOption(
        id: "q.hospital_bag.q1_a",
        labelKey: "questions.hospital_bag.q1_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.hospital_bag.q1_b",
        labelKey: "questions.hospital_bag.q1_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.hospital_bag.q1_c",
        labelKey: "questions.hospital_bag.q1_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.hospital_bag.q1_d",
        labelKey: "questions.hospital_bag.q1_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.hospital_bag.q2",
    category: AssessmentCategory.hospitalBag,
    promptKey: "questions.hospital_bag.q2",
    options: [
      QuestionOption(
        id: "q.hospital_bag.q2_a",
        labelKey: "questions.hospital_bag.q2_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.hospital_bag.q2_b",
        labelKey: "questions.hospital_bag.q2_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.hospital_bag.q2_c",
        labelKey: "questions.hospital_bag.q2_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.hospital_bag.q2_d",
        labelKey: "questions.hospital_bag.q2_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.hospital_bag.q3",
    category: AssessmentCategory.hospitalBag,
    promptKey: "questions.hospital_bag.q3",
    options: [
      QuestionOption(
        id: "q.hospital_bag.q3_a",
        labelKey: "questions.hospital_bag.q3_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.hospital_bag.q3_b",
        labelKey: "questions.hospital_bag.q3_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.hospital_bag.q3_c",
        labelKey: "questions.hospital_bag.q3_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.hospital_bag.q3_d",
        labelKey: "questions.hospital_bag.q3_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.hospital_bag.q4",
    category: AssessmentCategory.hospitalBag,
    promptKey: "questions.hospital_bag.q4",
    options: [
      QuestionOption(
        id: "q.hospital_bag.q4_a",
        labelKey: "questions.hospital_bag.q4_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.hospital_bag.q4_b",
        labelKey: "questions.hospital_bag.q4_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.hospital_bag.q4_c",
        labelKey: "questions.hospital_bag.q4_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.hospital_bag.q4_d",
        labelKey: "questions.hospital_bag.q4_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.hospital_bag.q5",
    category: AssessmentCategory.hospitalBag,
    promptKey: "questions.hospital_bag.q5",
    options: [
      QuestionOption(
        id: "q.hospital_bag.q5_a",
        labelKey: "questions.hospital_bag.q5_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.hospital_bag.q5_b",
        labelKey: "questions.hospital_bag.q5_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.hospital_bag.q5_c",
        labelKey: "questions.hospital_bag.q5_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.hospital_bag.q5_d",
        labelKey: "questions.hospital_bag.q5_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.hospital_bag.q6",
    category: AssessmentCategory.hospitalBag,
    promptKey: "questions.hospital_bag.q6",
    options: [
      QuestionOption(
        id: "q.hospital_bag.q6_a",
        labelKey: "questions.hospital_bag.q6_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.hospital_bag.q6_b",
        labelKey: "questions.hospital_bag.q6_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.hospital_bag.q6_c",
        labelKey: "questions.hospital_bag.q6_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.hospital_bag.q6_d",
        labelKey: "questions.hospital_bag.q6_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.hospital_bag.q7",
    category: AssessmentCategory.hospitalBag,
    promptKey: "questions.hospital_bag.q7",
    options: [
      QuestionOption(
        id: "q.hospital_bag.q7_a",
        labelKey: "questions.hospital_bag.q7_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.hospital_bag.q7_b",
        labelKey: "questions.hospital_bag.q7_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.hospital_bag.q7_c",
        labelKey: "questions.hospital_bag.q7_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.hospital_bag.q7_d",
        labelKey: "questions.hospital_bag.q7_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.hospital_bag.q8",
    category: AssessmentCategory.hospitalBag,
    promptKey: "questions.hospital_bag.q8",
    options: [
      QuestionOption(
        id: "q.hospital_bag.q8_a",
        labelKey: "questions.hospital_bag.q8_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.hospital_bag.q8_b",
        labelKey: "questions.hospital_bag.q8_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.hospital_bag.q8_c",
        labelKey: "questions.hospital_bag.q8_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.hospital_bag.q8_d",
        labelKey: "questions.hospital_bag.q8_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.hospital_bag.q9",
    category: AssessmentCategory.hospitalBag,
    promptKey: "questions.hospital_bag.q9",
    options: [
      QuestionOption(
        id: "q.hospital_bag.q9_a",
        labelKey: "questions.hospital_bag.q9_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.hospital_bag.q9_b",
        labelKey: "questions.hospital_bag.q9_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.hospital_bag.q9_c",
        labelKey: "questions.hospital_bag.q9_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.hospital_bag.q9_d",
        labelKey: "questions.hospital_bag.q9_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.hospital_bag.q10",
    category: AssessmentCategory.hospitalBag,
    promptKey: "questions.hospital_bag.q10",
    options: [
      QuestionOption(
        id: "q.hospital_bag.q10_a",
        labelKey: "questions.hospital_bag.q10_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.hospital_bag.q10_b",
        labelKey: "questions.hospital_bag.q10_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.hospital_bag.q10_c",
        labelKey: "questions.hospital_bag.q10_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.hospital_bag.q10_d",
        labelKey: "questions.hospital_bag.q10_d",
        rank: 4,
      ),
    ],
  ),
];

/// EMERGENCY PLAN — 10 scored questions.
///
/// Ranks: the source's 'Answer Key' (1.B 2.C 3.A 4.C 5.A 6.B 7.C 8.A 9.B
/// 10.B) supplies rank 1. The three distractors per question are NOT ranked
/// by the source, so ranks 2-4 are ordered here from least harmful / most
/// reasonable to most harmful or absurd (e.g. Q7: 'hold her down' > 'give her
/// food or water' > 'put something in her mouth').
///
/// Source oddities, copied verbatim and deliberately NOT corrected:
/// * Every English option in this bank ends with a full stop, unlike the
///   options in the other banks, which do not.
/// * Tagalog Q3's prompt starts 'Aling sintomas' — a source typo, left as is.
/// * Tagalog Q7's prompt reads 'Ano ang dapat gawin', missing 'mong'.
/// * The 'Answer Key' is printed with no space after the question number
///   ('1.B') and is split across a page break in the source.
const List<Question> emergencyPlanQuestions = [
  Question(
    id: "q.emergency_plan.q1",
    category: AssessmentCategory.emergencyPlan,
    promptKey: "questions.emergency_plan.q1",
    options: [
      QuestionOption(
        id: "q.emergency_plan.q1_a",
        labelKey: "questions.emergency_plan.q1_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.emergency_plan.q1_b",
        labelKey: "questions.emergency_plan.q1_b",
        rank: 1,
      ),
      QuestionOption(
        id: "q.emergency_plan.q1_c",
        labelKey: "questions.emergency_plan.q1_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.emergency_plan.q1_d",
        labelKey: "questions.emergency_plan.q1_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.emergency_plan.q2",
    category: AssessmentCategory.emergencyPlan,
    promptKey: "questions.emergency_plan.q2",
    options: [
      QuestionOption(
        id: "q.emergency_plan.q2_a",
        labelKey: "questions.emergency_plan.q2_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.emergency_plan.q2_b",
        labelKey: "questions.emergency_plan.q2_b",
        rank: 3,
      ),
      QuestionOption(
        id: "q.emergency_plan.q2_c",
        labelKey: "questions.emergency_plan.q2_c",
        rank: 1,
      ),
      QuestionOption(
        id: "q.emergency_plan.q2_d",
        labelKey: "questions.emergency_plan.q2_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.emergency_plan.q3",
    category: AssessmentCategory.emergencyPlan,
    promptKey: "questions.emergency_plan.q3",
    options: [
      QuestionOption(
        id: "q.emergency_plan.q3_a",
        labelKey: "questions.emergency_plan.q3_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.emergency_plan.q3_b",
        labelKey: "questions.emergency_plan.q3_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.emergency_plan.q3_c",
        labelKey: "questions.emergency_plan.q3_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.emergency_plan.q3_d",
        labelKey: "questions.emergency_plan.q3_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.emergency_plan.q4",
    category: AssessmentCategory.emergencyPlan,
    promptKey: "questions.emergency_plan.q4",
    options: [
      QuestionOption(
        id: "q.emergency_plan.q4_a",
        labelKey: "questions.emergency_plan.q4_a",
        rank: 4,
      ),
      QuestionOption(
        id: "q.emergency_plan.q4_b",
        labelKey: "questions.emergency_plan.q4_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.emergency_plan.q4_c",
        labelKey: "questions.emergency_plan.q4_c",
        rank: 1,
      ),
      QuestionOption(
        id: "q.emergency_plan.q4_d",
        labelKey: "questions.emergency_plan.q4_d",
        rank: 3,
      ),
    ],
  ),
  Question(
    id: "q.emergency_plan.q5",
    category: AssessmentCategory.emergencyPlan,
    promptKey: "questions.emergency_plan.q5",
    options: [
      QuestionOption(
        id: "q.emergency_plan.q5_a",
        labelKey: "questions.emergency_plan.q5_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.emergency_plan.q5_b",
        labelKey: "questions.emergency_plan.q5_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.emergency_plan.q5_c",
        labelKey: "questions.emergency_plan.q5_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.emergency_plan.q5_d",
        labelKey: "questions.emergency_plan.q5_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.emergency_plan.q6",
    category: AssessmentCategory.emergencyPlan,
    promptKey: "questions.emergency_plan.q6",
    options: [
      QuestionOption(
        id: "q.emergency_plan.q6_a",
        labelKey: "questions.emergency_plan.q6_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.emergency_plan.q6_b",
        labelKey: "questions.emergency_plan.q6_b",
        rank: 1,
      ),
      QuestionOption(
        id: "q.emergency_plan.q6_c",
        labelKey: "questions.emergency_plan.q6_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.emergency_plan.q6_d",
        labelKey: "questions.emergency_plan.q6_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.emergency_plan.q7",
    category: AssessmentCategory.emergencyPlan,
    promptKey: "questions.emergency_plan.q7",
    options: [
      QuestionOption(
        id: "q.emergency_plan.q7_a",
        labelKey: "questions.emergency_plan.q7_a",
        rank: 4,
      ),
      QuestionOption(
        id: "q.emergency_plan.q7_b",
        labelKey: "questions.emergency_plan.q7_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.emergency_plan.q7_c",
        labelKey: "questions.emergency_plan.q7_c",
        rank: 1,
      ),
      QuestionOption(
        id: "q.emergency_plan.q7_d",
        labelKey: "questions.emergency_plan.q7_d",
        rank: 3,
      ),
    ],
  ),
  Question(
    id: "q.emergency_plan.q8",
    category: AssessmentCategory.emergencyPlan,
    promptKey: "questions.emergency_plan.q8",
    options: [
      QuestionOption(
        id: "q.emergency_plan.q8_a",
        labelKey: "questions.emergency_plan.q8_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.emergency_plan.q8_b",
        labelKey: "questions.emergency_plan.q8_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.emergency_plan.q8_c",
        labelKey: "questions.emergency_plan.q8_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.emergency_plan.q8_d",
        labelKey: "questions.emergency_plan.q8_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.emergency_plan.q9",
    category: AssessmentCategory.emergencyPlan,
    promptKey: "questions.emergency_plan.q9",
    options: [
      QuestionOption(
        id: "q.emergency_plan.q9_a",
        labelKey: "questions.emergency_plan.q9_a",
        rank: 4,
      ),
      QuestionOption(
        id: "q.emergency_plan.q9_b",
        labelKey: "questions.emergency_plan.q9_b",
        rank: 1,
      ),
      QuestionOption(
        id: "q.emergency_plan.q9_c",
        labelKey: "questions.emergency_plan.q9_c",
        rank: 2,
      ),
      QuestionOption(
        id: "q.emergency_plan.q9_d",
        labelKey: "questions.emergency_plan.q9_d",
        rank: 3,
      ),
    ],
  ),
  Question(
    id: "q.emergency_plan.q10",
    category: AssessmentCategory.emergencyPlan,
    promptKey: "questions.emergency_plan.q10",
    options: [
      QuestionOption(
        id: "q.emergency_plan.q10_a",
        labelKey: "questions.emergency_plan.q10_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.emergency_plan.q10_b",
        labelKey: "questions.emergency_plan.q10_b",
        rank: 1,
      ),
      QuestionOption(
        id: "q.emergency_plan.q10_c",
        labelKey: "questions.emergency_plan.q10_c",
        rank: 4,
      ),
      QuestionOption(
        id: "q.emergency_plan.q10_d",
        labelKey: "questions.emergency_plan.q10_d",
        rank: 3,
      ),
    ],
  ),
];

/// SELF-PREPAREDNESS — 10 scored questions.
///
/// Ranks: Strongly Agree = 1, Agree = 2, Disagree = 3, Strongly Disagree = 4,
/// matching the source's 5/3/2/1 scale for this section (AGENTS.md §6).
///
/// Source oddities, copied verbatim and deliberately NOT corrected:
/// * Q10's English prompt begins 'know how to recognize...' — the leading 'I'
///   is missing in the source and has NOT been restored here.
/// * The source repeats the four Likert labels in ENGLISH inside its Tagalog
///   section, so the Tagalog bank reuses those same four English labels
///   rather than translating them.
/// * Several source prompts end with a trailing space at the line break; that
///   is a layout artifact and is not reproduced.
const List<Question> selfPreparednessQuestions = [
  Question(
    id: "q.self_preparedness.q1",
    category: AssessmentCategory.selfPreparedness,
    promptKey: "questions.self_preparedness.q1",
    options: [
      QuestionOption(
        id: "q.self_preparedness.q1_sa",
        labelKey: "questions.self_preparedness.q1_sa",
        rank: 1,
      ),
      QuestionOption(
        id: "q.self_preparedness.q1_a",
        labelKey: "questions.self_preparedness.q1_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.self_preparedness.q1_d",
        labelKey: "questions.self_preparedness.q1_d",
        rank: 3,
      ),
      QuestionOption(
        id: "q.self_preparedness.q1_sd",
        labelKey: "questions.self_preparedness.q1_sd",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.self_preparedness.q2",
    category: AssessmentCategory.selfPreparedness,
    promptKey: "questions.self_preparedness.q2",
    options: [
      QuestionOption(
        id: "q.self_preparedness.q2_sa",
        labelKey: "questions.self_preparedness.q2_sa",
        rank: 1,
      ),
      QuestionOption(
        id: "q.self_preparedness.q2_a",
        labelKey: "questions.self_preparedness.q2_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.self_preparedness.q2_d",
        labelKey: "questions.self_preparedness.q2_d",
        rank: 3,
      ),
      QuestionOption(
        id: "q.self_preparedness.q2_sd",
        labelKey: "questions.self_preparedness.q2_sd",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.self_preparedness.q3",
    category: AssessmentCategory.selfPreparedness,
    promptKey: "questions.self_preparedness.q3",
    options: [
      QuestionOption(
        id: "q.self_preparedness.q3_sa",
        labelKey: "questions.self_preparedness.q3_sa",
        rank: 1,
      ),
      QuestionOption(
        id: "q.self_preparedness.q3_a",
        labelKey: "questions.self_preparedness.q3_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.self_preparedness.q3_d",
        labelKey: "questions.self_preparedness.q3_d",
        rank: 3,
      ),
      QuestionOption(
        id: "q.self_preparedness.q3_sd",
        labelKey: "questions.self_preparedness.q3_sd",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.self_preparedness.q4",
    category: AssessmentCategory.selfPreparedness,
    promptKey: "questions.self_preparedness.q4",
    options: [
      QuestionOption(
        id: "q.self_preparedness.q4_sa",
        labelKey: "questions.self_preparedness.q4_sa",
        rank: 1,
      ),
      QuestionOption(
        id: "q.self_preparedness.q4_a",
        labelKey: "questions.self_preparedness.q4_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.self_preparedness.q4_d",
        labelKey: "questions.self_preparedness.q4_d",
        rank: 3,
      ),
      QuestionOption(
        id: "q.self_preparedness.q4_sd",
        labelKey: "questions.self_preparedness.q4_sd",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.self_preparedness.q5",
    category: AssessmentCategory.selfPreparedness,
    promptKey: "questions.self_preparedness.q5",
    options: [
      QuestionOption(
        id: "q.self_preparedness.q5_sa",
        labelKey: "questions.self_preparedness.q5_sa",
        rank: 1,
      ),
      QuestionOption(
        id: "q.self_preparedness.q5_a",
        labelKey: "questions.self_preparedness.q5_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.self_preparedness.q5_d",
        labelKey: "questions.self_preparedness.q5_d",
        rank: 3,
      ),
      QuestionOption(
        id: "q.self_preparedness.q5_sd",
        labelKey: "questions.self_preparedness.q5_sd",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.self_preparedness.q6",
    category: AssessmentCategory.selfPreparedness,
    promptKey: "questions.self_preparedness.q6",
    options: [
      QuestionOption(
        id: "q.self_preparedness.q6_sa",
        labelKey: "questions.self_preparedness.q6_sa",
        rank: 1,
      ),
      QuestionOption(
        id: "q.self_preparedness.q6_a",
        labelKey: "questions.self_preparedness.q6_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.self_preparedness.q6_d",
        labelKey: "questions.self_preparedness.q6_d",
        rank: 3,
      ),
      QuestionOption(
        id: "q.self_preparedness.q6_sd",
        labelKey: "questions.self_preparedness.q6_sd",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.self_preparedness.q7",
    category: AssessmentCategory.selfPreparedness,
    promptKey: "questions.self_preparedness.q7",
    options: [
      QuestionOption(
        id: "q.self_preparedness.q7_sa",
        labelKey: "questions.self_preparedness.q7_sa",
        rank: 1,
      ),
      QuestionOption(
        id: "q.self_preparedness.q7_a",
        labelKey: "questions.self_preparedness.q7_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.self_preparedness.q7_d",
        labelKey: "questions.self_preparedness.q7_d",
        rank: 3,
      ),
      QuestionOption(
        id: "q.self_preparedness.q7_sd",
        labelKey: "questions.self_preparedness.q7_sd",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.self_preparedness.q8",
    category: AssessmentCategory.selfPreparedness,
    promptKey: "questions.self_preparedness.q8",
    options: [
      QuestionOption(
        id: "q.self_preparedness.q8_sa",
        labelKey: "questions.self_preparedness.q8_sa",
        rank: 1,
      ),
      QuestionOption(
        id: "q.self_preparedness.q8_a",
        labelKey: "questions.self_preparedness.q8_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.self_preparedness.q8_d",
        labelKey: "questions.self_preparedness.q8_d",
        rank: 3,
      ),
      QuestionOption(
        id: "q.self_preparedness.q8_sd",
        labelKey: "questions.self_preparedness.q8_sd",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.self_preparedness.q9",
    category: AssessmentCategory.selfPreparedness,
    promptKey: "questions.self_preparedness.q9",
    options: [
      QuestionOption(
        id: "q.self_preparedness.q9_sa",
        labelKey: "questions.self_preparedness.q9_sa",
        rank: 1,
      ),
      QuestionOption(
        id: "q.self_preparedness.q9_a",
        labelKey: "questions.self_preparedness.q9_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.self_preparedness.q9_d",
        labelKey: "questions.self_preparedness.q9_d",
        rank: 3,
      ),
      QuestionOption(
        id: "q.self_preparedness.q9_sd",
        labelKey: "questions.self_preparedness.q9_sd",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.self_preparedness.q10",
    category: AssessmentCategory.selfPreparedness,
    promptKey: "questions.self_preparedness.q10",
    options: [
      QuestionOption(
        id: "q.self_preparedness.q10_sa",
        labelKey: "questions.self_preparedness.q10_sa",
        rank: 1,
      ),
      QuestionOption(
        id: "q.self_preparedness.q10_a",
        labelKey: "questions.self_preparedness.q10_a",
        rank: 2,
      ),
      QuestionOption(
        id: "q.self_preparedness.q10_d",
        labelKey: "questions.self_preparedness.q10_d",
        rank: 3,
      ),
      QuestionOption(
        id: "q.self_preparedness.q10_sd",
        labelKey: "questions.self_preparedness.q10_sd",
        rank: 4,
      ),
    ],
  ),
];

/// SUPPORT PERSON — the SCORED half of the source questionnaire only.
///
/// EXCLUDED FROM THE SCORED BANK, and why:
///
/// * Q2 'Who is your primary support person during your pregnancy and
///   childbirth?' — 7 categorical options (Husband/Partner, Mother/Father,
///   Sibling, Other relative, Friend, Other, No support person). That is a
///   relationship field, not a readiness measure, so it belongs to My Plan's
///   `SupportPersonRecord.relationship`, not to `AssessmentScores`
///   (AGENTS.md §5). It is excluded rather than flattened into a 7-option
///   question because the scoring table is only defined for 2-4 options.
/// * Q11-Q16 — plain data-entry blanks (full name, relationship, contact
///   number, preferred contact method, address, alternate contact). No
///   readiness wording and no scoring anywhere in the source; these become
///   `SupportPersonRecord` fields in My Plan so the Emergency Card can
///   display them without the mother typing them twice (AGENTS.md §5).
/// * The 'If yes, who?' free-text blanks under Q1 and Q9, and the Q8
///   item checklist (mother/baby clothes, hygiene items, documents,
///   transportation, other) — follow-up capture, not answer options.
///
/// Source numbering is preserved (q1, q3, q4, ... q10) so every scored
/// question maps straight back to its page in the PDF. The source itself
/// skips number 12 in the English run (11 -> 13) while the Tagalog run
/// does contain a Q12; that gap sits inside the excluded data-entry
/// block, so nothing was renumbered and nothing was invented to fill it.
///
/// Ranks: the Yes / Not sure / No questions rank 1 / 2 / 3 (Not sure sits
/// between the two certainties). Q4, Q8 and Q10 use different option sets
/// and rank accordingly — see the per-option ranks below.
const List<Question> supportPersonQuestions = [
  Question(
    id: "q.support_person.q1",
    category: AssessmentCategory.supportPerson,
    promptKey: "questions.support_person.q1",
    options: [
      QuestionOption(
        id: "q.support_person.q1_yes",
        labelKey: "questions.support_person.q1_yes",
        rank: 1,
      ),
      QuestionOption(
        id: "q.support_person.q1_no",
        labelKey: "questions.support_person.q1_no",
        rank: 2,
      ),
    ],
  ),
  Question(
    id: "q.support_person.q3",
    category: AssessmentCategory.supportPerson,
    promptKey: "questions.support_person.q3",
    options: [
      QuestionOption(
        id: "q.support_person.q3_yes",
        labelKey: "questions.support_person.q3_yes",
        rank: 1,
      ),
      QuestionOption(
        id: "q.support_person.q3_no",
        labelKey: "questions.support_person.q3_no",
        rank: 3,
      ),
      QuestionOption(
        id: "q.support_person.q3_not_sure",
        labelKey: "questions.support_person.q3_not_sure",
        rank: 2,
      ),
    ],
  ),
  Question(
    id: "q.support_person.q4",
    category: AssessmentCategory.supportPerson,
    promptKey: "questions.support_person.q4",
    options: [
      QuestionOption(
        id: "q.support_person.q4_yes_anytime",
        labelKey: "questions.support_person.q4_yes_anytime",
        rank: 1,
      ),
      QuestionOption(
        id: "q.support_person.q4_sometimes",
        labelKey: "questions.support_person.q4_sometimes",
        rank: 2,
      ),
      QuestionOption(
        id: "q.support_person.q4_no",
        labelKey: "questions.support_person.q4_no",
        rank: 4,
      ),
      QuestionOption(
        id: "q.support_person.q4_not_sure",
        labelKey: "questions.support_person.q4_not_sure",
        rank: 3,
      ),
    ],
  ),
  Question(
    id: "q.support_person.q5",
    category: AssessmentCategory.supportPerson,
    promptKey: "questions.support_person.q5",
    options: [
      QuestionOption(
        id: "q.support_person.q5_yes",
        labelKey: "questions.support_person.q5_yes",
        rank: 1,
      ),
      QuestionOption(
        id: "q.support_person.q5_no",
        labelKey: "questions.support_person.q5_no",
        rank: 2,
      ),
    ],
  ),
  Question(
    id: "q.support_person.q6",
    category: AssessmentCategory.supportPerson,
    promptKey: "questions.support_person.q6",
    options: [
      QuestionOption(
        id: "q.support_person.q6_yes",
        labelKey: "questions.support_person.q6_yes",
        rank: 1,
      ),
      QuestionOption(
        id: "q.support_person.q6_no",
        labelKey: "questions.support_person.q6_no",
        rank: 3,
      ),
      QuestionOption(
        id: "q.support_person.q6_not_sure",
        labelKey: "questions.support_person.q6_not_sure",
        rank: 2,
      ),
    ],
  ),
  Question(
    id: "q.support_person.q7",
    category: AssessmentCategory.supportPerson,
    promptKey: "questions.support_person.q7",
    options: [
      QuestionOption(
        id: "q.support_person.q7_yes",
        labelKey: "questions.support_person.q7_yes",
        rank: 1,
      ),
      QuestionOption(
        id: "q.support_person.q7_no",
        labelKey: "questions.support_person.q7_no",
        rank: 3,
      ),
      QuestionOption(
        id: "q.support_person.q7_not_sure",
        labelKey: "questions.support_person.q7_not_sure",
        rank: 2,
      ),
    ],
  ),
  Question(
    id: "q.support_person.q8",
    category: AssessmentCategory.supportPerson,
    promptKey: "questions.support_person.q8",
    options: [
      QuestionOption(
        id: "q.support_person.q8_yes",
        labelKey: "questions.support_person.q8_yes",
        rank: 1,
      ),
      QuestionOption(
        id: "q.support_person.q8_no",
        labelKey: "questions.support_person.q8_no",
        rank: 3,
      ),
      QuestionOption(
        id: "q.support_person.q8_partially",
        labelKey: "questions.support_person.q8_partially",
        rank: 2,
      ),
    ],
  ),
  Question(
    id: "q.support_person.q9",
    category: AssessmentCategory.supportPerson,
    promptKey: "questions.support_person.q9",
    options: [
      QuestionOption(
        id: "q.support_person.q9_yes",
        labelKey: "questions.support_person.q9_yes",
        rank: 1,
      ),
      QuestionOption(
        id: "q.support_person.q9_no",
        labelKey: "questions.support_person.q9_no",
        rank: 2,
      ),
    ],
  ),
  Question(
    id: "q.support_person.q10",
    category: AssessmentCategory.supportPerson,
    promptKey: "questions.support_person.q10",
    options: [
      QuestionOption(
        id: "q.support_person.q10_yes",
        labelKey: "questions.support_person.q10_yes",
        rank: 1,
      ),
      QuestionOption(
        id: "q.support_person.q10_no",
        labelKey: "questions.support_person.q10_no",
        rank: 3,
      ),
      QuestionOption(
        id: "q.support_person.q10_sometimes",
        labelKey: "questions.support_person.q10_sometimes",
        rank: 2,
      ),
    ],
  ),
];

/// DANGER SIGNS — 10 screener questions (never scored).
///
/// Source oddities, copied verbatim and deliberately NOT corrected:
/// * The page introducing this section also carries a stray author note,
///   'follw up ko nalang po yung references', above the heading. It is not
///   question content and is not copied.
/// * The screener's own result text ('DANGER SIGN DETECTED' / 'NO IMMEDIATE
///   DANGER SIGNS REPORTED') is deliberately NOT copied here — that belongs
///   to the future result/alert screen, not to the data layer.
const List<Question> dangerSignQuestions = [
  Question(
    id: "q.danger_signs.q1",
    category: null,
    promptKey: "questions.danger_signs.q1",
    options: [
      QuestionOption(
        id: "q.danger_signs.q1_a",
        labelKey: "questions.danger_signs.q1_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.danger_signs.q1_b",
        labelKey: "questions.danger_signs.q1_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.danger_signs.q1_c",
        labelKey: "questions.danger_signs.q1_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.danger_signs.q1_d",
        labelKey: "questions.danger_signs.q1_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.danger_signs.q2",
    category: null,
    promptKey: "questions.danger_signs.q2",
    options: [
      QuestionOption(
        id: "q.danger_signs.q2_a",
        labelKey: "questions.danger_signs.q2_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.danger_signs.q2_b",
        labelKey: "questions.danger_signs.q2_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.danger_signs.q2_c",
        labelKey: "questions.danger_signs.q2_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.danger_signs.q2_d",
        labelKey: "questions.danger_signs.q2_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.danger_signs.q3",
    category: null,
    promptKey: "questions.danger_signs.q3",
    options: [
      QuestionOption(
        id: "q.danger_signs.q3_a",
        labelKey: "questions.danger_signs.q3_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.danger_signs.q3_b",
        labelKey: "questions.danger_signs.q3_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.danger_signs.q3_c",
        labelKey: "questions.danger_signs.q3_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.danger_signs.q3_d",
        labelKey: "questions.danger_signs.q3_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.danger_signs.q4",
    category: null,
    promptKey: "questions.danger_signs.q4",
    options: [
      QuestionOption(
        id: "q.danger_signs.q4_a",
        labelKey: "questions.danger_signs.q4_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.danger_signs.q4_b",
        labelKey: "questions.danger_signs.q4_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.danger_signs.q4_c",
        labelKey: "questions.danger_signs.q4_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.danger_signs.q4_d",
        labelKey: "questions.danger_signs.q4_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.danger_signs.q5",
    category: null,
    promptKey: "questions.danger_signs.q5",
    options: [
      QuestionOption(
        id: "q.danger_signs.q5_a",
        labelKey: "questions.danger_signs.q5_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.danger_signs.q5_b",
        labelKey: "questions.danger_signs.q5_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.danger_signs.q5_c",
        labelKey: "questions.danger_signs.q5_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.danger_signs.q5_d",
        labelKey: "questions.danger_signs.q5_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.danger_signs.q6",
    category: null,
    promptKey: "questions.danger_signs.q6",
    options: [
      QuestionOption(
        id: "q.danger_signs.q6_a",
        labelKey: "questions.danger_signs.q6_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.danger_signs.q6_b",
        labelKey: "questions.danger_signs.q6_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.danger_signs.q6_c",
        labelKey: "questions.danger_signs.q6_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.danger_signs.q6_d",
        labelKey: "questions.danger_signs.q6_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.danger_signs.q7",
    category: null,
    promptKey: "questions.danger_signs.q7",
    options: [
      QuestionOption(
        id: "q.danger_signs.q7_a",
        labelKey: "questions.danger_signs.q7_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.danger_signs.q7_b",
        labelKey: "questions.danger_signs.q7_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.danger_signs.q7_c",
        labelKey: "questions.danger_signs.q7_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.danger_signs.q7_d",
        labelKey: "questions.danger_signs.q7_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.danger_signs.q8",
    category: null,
    promptKey: "questions.danger_signs.q8",
    options: [
      QuestionOption(
        id: "q.danger_signs.q8_a",
        labelKey: "questions.danger_signs.q8_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.danger_signs.q8_b",
        labelKey: "questions.danger_signs.q8_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.danger_signs.q8_c",
        labelKey: "questions.danger_signs.q8_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.danger_signs.q8_d",
        labelKey: "questions.danger_signs.q8_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.danger_signs.q9",
    category: null,
    promptKey: "questions.danger_signs.q9",
    options: [
      QuestionOption(
        id: "q.danger_signs.q9_a",
        labelKey: "questions.danger_signs.q9_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.danger_signs.q9_b",
        labelKey: "questions.danger_signs.q9_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.danger_signs.q9_c",
        labelKey: "questions.danger_signs.q9_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.danger_signs.q9_d",
        labelKey: "questions.danger_signs.q9_d",
        rank: 4,
      ),
    ],
  ),
  Question(
    id: "q.danger_signs.q10",
    category: null,
    promptKey: "questions.danger_signs.q10",
    options: [
      QuestionOption(
        id: "q.danger_signs.q10_a",
        labelKey: "questions.danger_signs.q10_a",
        rank: 1,
      ),
      QuestionOption(
        id: "q.danger_signs.q10_b",
        labelKey: "questions.danger_signs.q10_b",
        rank: 2,
      ),
      QuestionOption(
        id: "q.danger_signs.q10_c",
        labelKey: "questions.danger_signs.q10_c",
        rank: 3,
      ),
      QuestionOption(
        id: "q.danger_signs.q10_d",
        labelKey: "questions.danger_signs.q10_d",
        rank: 4,
      ),
    ],
  ),
];

/// Every scored question, in the source's category order. Danger Signs is
/// deliberately absent: it is screened, never scored (AGENTS.md §4).
const List<Question> scoredQuestions = [
  ...deliveryPlanQuestions,
  ...hospitalBagQuestions,
  ...emergencyPlanQuestions,
  ...selfPreparednessQuestions,
  ...supportPersonQuestions,
];
