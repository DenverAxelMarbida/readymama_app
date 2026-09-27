// lib/features/assessment/data/sample_questions.dart
import 'package:readymama_app/core/database/app_database.dart';
import 'package:readymama_app/features/assessment/domain/models/question.dart';
import 'package:readymama_app/features/assessment/domain/models/question_option.dart';

/// SAMPLE DATA ONLY — two representative questions per scored category plus
/// two Danger Signs screener questions, transcribed verbatim from
/// ReadyMama_Contents.pdf (the master content source; AGENTS.md §1).
///
/// The full 10-question per-category bank (50 scored + 10 danger signs) is a
/// separate, deliberate follow-up task. These samples are enough to exercise
/// the scoring engine, the danger-signs screener, and the bilingual Assess
/// flow end to end, and their prompt/option text is exactly what pilots will
/// see before the full bank lands.
///
/// i18n: every promptKey / labelKey resolves via AppI18n.t() to keys under
/// "sample_questions" in BOTH assets/i18n/en.json and assets/i18n/fil.json.
///
/// Rank meaning: 1 = most prepared per AGENTS.md §6, EXCEPT that options with
/// ['danger'] == true in [sampleDangerSignQuestions] carry rank 1 to mark the
/// option that IS the danger sign (the screener's inverted semantics).

List<Question> get sampleScoredQuestions {
  final keyPrefix = 'sample_questions.';
  return [
    // ---------------------------------------------------------- deliveryPlan
    Question(
      id: 'sample.delivery_plan.q1',
      category: AssessmentCategory.deliveryPlan,
      promptKey: '${keyPrefix}delivery_plan.q1',
      options: const [
        QuestionOption(
          id: 'sample.delivery_plan.q1_a',
          labelKey: 'sample_questions.delivery_plan.q1_a',
          rank: 1,
        ),
        QuestionOption(
          id: 'sample.delivery_plan.q1_b',
          labelKey: 'sample_questions.delivery_plan.q1_b',
          rank: 2,
        ),
        QuestionOption(
          id: 'sample.delivery_plan.q1_d',
          labelKey: 'sample_questions.delivery_plan.q1_d',
          rank: 3,
        ),
        QuestionOption(
          id: 'sample.delivery_plan.q1_c',
          labelKey: 'sample_questions.delivery_plan.q1_c',
          rank: 4,
        ),
      ],
    ),
    Question(
      id: 'sample.delivery_plan.q2',
      category: AssessmentCategory.deliveryPlan,
      promptKey: '${keyPrefix}delivery_plan.q2',
      options: const [
        QuestionOption(
          id: 'sample.delivery_plan.q2_b',
          labelKey: 'sample_questions.delivery_plan.q2_b',
          rank: 1,
        ),
        QuestionOption(
          id: 'sample.delivery_plan.q2_a',
          labelKey: 'sample_questions.delivery_plan.q2_a',
          rank: 2,
        ),
        QuestionOption(
          id: 'sample.delivery_plan.q2_c',
          labelKey: 'sample_questions.delivery_plan.q2_c',
          rank: 3,
        ),
        QuestionOption(
          id: 'sample.delivery_plan.q2_d',
          labelKey: 'sample_questions.delivery_plan.q2_d',
          rank: 4,
        ),
      ],
    ),

    // ------------------------------------------------------------ hospitalBag
    Question(
      id: 'sample.hospital_bag.q1',
      category: AssessmentCategory.hospitalBag,
      promptKey: '${keyPrefix}hospital_bag.q1',
      options: const [
        QuestionOption(
          id: 'sample.hospital_bag.q1_a',
          labelKey: 'sample_questions.hospital_bag.q1_a',
          rank: 1,
        ),
        QuestionOption(
          id: 'sample.hospital_bag.q1_b',
          labelKey: 'sample_questions.hospital_bag.q1_b',
          rank: 2,
        ),
        QuestionOption(
          id: 'sample.hospital_bag.q1_c',
          labelKey: 'sample_questions.hospital_bag.q1_c',
          rank: 3,
        ),
        QuestionOption(
          id: 'sample.hospital_bag.q1_d',
          labelKey: 'sample_questions.hospital_bag.q1_d',
          rank: 4,
        ),
      ],
    ),
    Question(
      id: 'sample.hospital_bag.q2',
      category: AssessmentCategory.hospitalBag,
      promptKey: '${keyPrefix}hospital_bag.q2',
      options: const [
        QuestionOption(
          id: 'sample.hospital_bag.q2_a',
          labelKey: 'sample_questions.hospital_bag.q2_a',
          rank: 1,
        ),
        QuestionOption(
          id: 'sample.hospital_bag.q2_b',
          labelKey: 'sample_questions.hospital_bag.q2_b',
          rank: 2,
        ),
        QuestionOption(
          id: 'sample.hospital_bag.q2_c',
          labelKey: 'sample_questions.hospital_bag.q2_c',
          rank: 3,
        ),
        QuestionOption(
          id: 'sample.hospital_bag.q2_d',
          labelKey: 'sample_questions.hospital_bag.q2_d',
          rank: 4,
        ),
      ],
    ),

    // ---------------------------------------------------------- emergencyPlan
    Question(
      id: 'sample.emergency_plan.q1',
      category: AssessmentCategory.emergencyPlan,
      promptKey: '${keyPrefix}emergency_plan.q1',
      options: const [
        QuestionOption(
          id: 'sample.emergency_plan.q1_b',
          labelKey: 'sample_questions.emergency_plan.q1_b',
          rank: 1,
        ),
        QuestionOption(
          id: 'sample.emergency_plan.q1_c',
          labelKey: 'sample_questions.emergency_plan.q1_c',
          rank: 3,
        ),
        QuestionOption(
          id: 'sample.emergency_plan.q1_a',
          labelKey: 'sample_questions.emergency_plan.q1_a',
          rank: 2,
        ),
        QuestionOption(
          id: 'sample.emergency_plan.q1_d',
          labelKey: 'sample_questions.emergency_plan.q1_d',
          rank: 4,
        ),
      ],
    ),
    Question(
      id: 'sample.emergency_plan.q5',
      category: AssessmentCategory.emergencyPlan,
      promptKey: '${keyPrefix}emergency_plan.q5',
      options: const [
        QuestionOption(
          id: 'sample.emergency_plan.q5_a',
          labelKey: 'sample_questions.emergency_plan.q5_a',
          rank: 1,
        ),
        QuestionOption(
          id: 'sample.emergency_plan.q5_b',
          labelKey: 'sample_questions.emergency_plan.q5_b',
          rank: 2,
        ),
        QuestionOption(
          id: 'sample.emergency_plan.q5_c',
          labelKey: 'sample_questions.emergency_plan.q5_c',
          rank: 3,
        ),
        QuestionOption(
          id: 'sample.emergency_plan.q5_d',
          labelKey: 'sample_questions.emergency_plan.q5_d',
          rank: 4,
        ),
      ],
    ),

    // ----------------------------------------------------- selfPreparedness
    Question(
      id: 'sample.self_preparedness.q1',
      category: AssessmentCategory.selfPreparedness,
      promptKey: '${keyPrefix}self_preparedness.q1',
      options: const [
        QuestionOption(
          id: 'sample.self_preparedness.q1_sa',
          labelKey: 'sample_questions.self_preparedness.q1_sa',
          rank: 1,
        ),
        QuestionOption(
          id: 'sample.self_preparedness.q1_a',
          labelKey: 'sample_questions.self_preparedness.q1_a',
          rank: 2,
        ),
        QuestionOption(
          id: 'sample.self_preparedness.q1_d',
          labelKey: 'sample_questions.self_preparedness.q1_d',
          rank: 3,
        ),
        QuestionOption(
          id: 'sample.self_preparedness.q1_sd',
          labelKey: 'sample_questions.self_preparedness.q1_sd',
          rank: 4,
        ),
      ],
    ),
    Question(
      id: 'sample.self_preparedness.q2',
      category: AssessmentCategory.selfPreparedness,
      promptKey: '${keyPrefix}self_preparedness.q2',
      options: const [
        QuestionOption(
          id: 'sample.self_preparedness.q2_sa',
          labelKey: 'sample_questions.self_preparedness.q2_sa',
          rank: 1,
        ),
        QuestionOption(
          id: 'sample.self_preparedness.q2_a',
          labelKey: 'sample_questions.self_preparedness.q2_a',
          rank: 2,
        ),
        QuestionOption(
          id: 'sample.self_preparedness.q2_d',
          labelKey: 'sample_questions.self_preparedness.q2_d',
          rank: 3,
        ),
        QuestionOption(
          id: 'sample.self_preparedness.q2_sd',
          labelKey: 'sample_questions.self_preparedness.q2_sd',
          rank: 4,
        ),
      ],
    ),

    // ---------------------------------------------------------- supportPerson
    // Items 1–10 are Yes / No / Not Sure (3-tier: 5/3/1 per AGENTS.md §6),
    // presented in that order to match the source questionnaire. Ranks are
    // attached to each option, not to its position: Yes = 1, Not Sure = 2,
    // No = 3.
    Question(
      id: 'sample.support_person.q3',
      category: AssessmentCategory.supportPerson,
      promptKey: '${keyPrefix}support_person.q3',
      options: const [
        QuestionOption(
          id: 'sample.support_person.q3_yes',
          labelKey: 'sample_questions.support_person.q3_yes',
          rank: 1,
        ),
        QuestionOption(
          id: 'sample.support_person.q3_no',
          labelKey: 'sample_questions.support_person.q3_no',
          rank: 3,
        ),
        QuestionOption(
          id: 'sample.support_person.q3_not_sure',
          labelKey: 'sample_questions.support_person.q3_not_sure',
          rank: 2,
        ),
      ],
    ),
    Question(
      id: 'sample.support_person.q7',
      category: AssessmentCategory.supportPerson,
      promptKey: '${keyPrefix}support_person.q7',
      options: const [
        QuestionOption(
          id: 'sample.support_person.q7_yes',
          labelKey: 'sample_questions.support_person.q7_yes',
          rank: 1,
        ),
        QuestionOption(
          id: 'sample.support_person.q7_no',
          labelKey: 'sample_questions.support_person.q7_no',
          rank: 3,
        ),
        QuestionOption(
          id: 'sample.support_person.q7_not_sure',
          labelKey: 'sample_questions.support_person.q7_not_sure',
          rank: 2,
        ),
      ],
    ),
  ];
}

/// Danger Signs screener questions. Do NOT add these to [sampleScoredQuestions].
///
/// Rank is INVERTED here: rank 1 marks the option that IS the danger sign
/// (always option A in the source questionnaire — "If Option A is selected
/// for ANY question → DANGER SIGN DETECTED"). The screener only looks at
/// rank == 1; ranks 2–4 just distinguish the non-danger options.
List<Question> get sampleDangerSignQuestions => [
      Question(
        id: 'sample.danger_signs.q1',
        category: null,
        promptKey: 'sample_questions.danger_signs.q1',
        options: const [
          QuestionOption(
            id: 'sample.danger_signs.q1_a',
            labelKey: 'sample_questions.danger_signs.q1_a',
            rank: 1,
          ),
          QuestionOption(
            id: 'sample.danger_signs.q1_b',
            labelKey: 'sample_questions.danger_signs.q1_b',
            rank: 2,
          ),
          QuestionOption(
            id: 'sample.danger_signs.q1_c',
            labelKey: 'sample_questions.danger_signs.q1_c',
            rank: 3,
          ),
          QuestionOption(
            id: 'sample.danger_signs.q1_d',
            labelKey: 'sample_questions.danger_signs.q1_d',
            rank: 4,
          ),
        ],
      ),
      Question(
        id: 'sample.danger_signs.q7',
        category: null,
        promptKey: 'sample_questions.danger_signs.q7',
        options: const [
          QuestionOption(
            id: 'sample.danger_signs.q7_a',
            labelKey: 'sample_questions.danger_signs.q7_a',
            rank: 1,
          ),
          QuestionOption(
            id: 'sample.danger_signs.q7_b',
            labelKey: 'sample_questions.danger_signs.q7_b',
            rank: 2,
          ),
          QuestionOption(
            id: 'sample.danger_signs.q7_c',
            labelKey: 'sample_questions.danger_signs.q7_c',
            rank: 3,
          ),
          QuestionOption(
            id: 'sample.danger_signs.q7_d',
            labelKey: 'sample_questions.danger_signs.q7_d',
            rank: 4,
          ),
        ],
      ),
    ];