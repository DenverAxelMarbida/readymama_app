// lib/features/assessment/domain/models/question_option.dart

/// One selectable option of an assessment [Question].
///
/// [rank] is the option's ordinal degree of readiness — 1 (best/most
/// prepared) up to how many tiers the question has (4 for most, 3 for
/// Yes/Not sure/No questions). It is NOT the A/B/C/D letter position:
/// e.g. Delivery Plan Q2's best answer per the source key is B, so B's
/// option carries rank 1.
///
/// DANGER SIGNS EXCEPTION: for questions passed to the danger-signs
/// screener, rank 1 is INVERTED — it marks the option that IS the danger
/// sign. See `lib/features/assessment/domain/scoring/danger_signs_screener.dart`.
class QuestionOption {
  /// Stable identifier, unique within its question's option list.
  final String id;

  /// i18n key resolving the option label via `AppI18n.t()`.
  final String labelKey;

  /// 1 = most prepared (or, for danger-sign questions, the danger option).
  final int rank;

  const QuestionOption({
    required this.id,
    required this.labelKey,
    required this.rank,
  });
}