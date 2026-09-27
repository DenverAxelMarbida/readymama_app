// lib/features/assessment/domain/scoring/danger_signs_screener.dart
import '../models/question.dart';
import '../models/question_response.dart';

/// Result of the binary Danger Signs screening (AGENTS.md §4) — never a
/// readiness score, never aggregated into [CategoryResult]/[DashboardScore].
class ScreeningResult {
  final bool isDangerDetected;

  /// Question ids where the danger option (rank 1) was selected.
  final List<String> triggeringQuestionIds;

  const ScreeningResult({
    required this.isDangerDetected,
    required this.triggeringQuestionIds,
  });
}

/// Screens the given danger-sign questions: if ANY response selected the
/// option with rank == 1, a danger sign is detected.
///
/// RANK MEANING IS INVERTED HERE vs. readiness scoring. In the questionnaire's
/// own answer key ("If Option A is selected for ANY question → DANGER SIGN
/// DETECTED"), rank 1 marks the option that IS the danger sign, not the most
/// prepared answer. Options B/C/D carry ranks 2/3/4 but their order is
/// irrelevant to detection. This result must NEVER be passed to
/// `scoreCategory()` / `aggregateScores()`.
ScreeningResult screenDangerSigns({
  required List<Question> dangerSignQuestions,
  required List<QuestionResponse> responses,
}) {
  final triggering = <String>[];

  for (final question in dangerSignQuestions) {
    final response = _responseFor(question.id, responses);
    if (response == null) continue;

    final selected =
        question.options.where((o) => o.id == response.selectedOptionId).firstOrNull;
    if (selected != null && selected.rank == 1) {
      triggering.add(question.id);
    }
  }

  return ScreeningResult(
    isDangerDetected: triggering.isNotEmpty,
    triggeringQuestionIds: triggering,
  );
}

QuestionResponse? _responseFor(String questionId, List<QuestionResponse> responses) {
  for (final response in responses) {
    if (response.questionId == questionId) return response;
  }
  return null;
}