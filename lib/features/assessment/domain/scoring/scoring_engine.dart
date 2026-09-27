// lib/features/assessment/domain/scoring/scoring_engine.dart
import '../../../../core/database/app_database.dart';
import '../models/question.dart';
import '../models/question_response.dart';

/// Score for one [AssessmentCategory].
class CategoryResult {
  final AssessmentCategory category;

  /// Sum of points across the given questions (unanswered questions
  /// contribute 0).
  final int rawScore;

  /// Number of questions × 5, since the best option of every question is
  /// always worth 5 points.
  final int maxPossible;

  /// rawScore / maxPossible as a 0–100 double.
  final double percentage;

  /// Bucket of [percentage] into the existing 4 status tiers.
  final PreparednessStatus statusTier;

  const CategoryResult({
    required this.category,
    required this.rawScore,
    required this.maxPossible,
    required this.percentage,
    required this.statusTier,
  });
}

/// Rolled-up dashboard readiness, averaged across scored categories.
class DashboardScore {
  /// Average of the categories' percentages, rounded to nearest integer.
  final int overallScore;

  /// Then bucketed into the same 4 status tiers.
  final PreparednessStatus statusTier;

  final List<CategoryResult> results;

  const DashboardScore({
    required this.overallScore,
    required this.statusTier,
    required this.results,
  });
}

/// Each category: 10 questions × max 5 = 50 raw points → 0–100% (AGENTS.md
/// §6). Weights are derived from each question's option count:
///
/// * 4-tier questions: rank 1 = 5, rank 2 = 3, rank 3 = 2, rank 4 = 1.
/// * 3-tier questions (Support Person's Yes / Not Sure / No): rank 1 = 5,
///   rank 2 = 3, rank 3 = 1 — the "2" tier is skipped (AGENTS.md §6).
///
/// The floor is always 1, never 0, even for the worst answer.
CategoryResult scoreCategory(
  AssessmentCategory category,
  List<Question> questions,
  List<QuestionResponse> responses,
) {
  if (questions.isEmpty) {
    return CategoryResult(
      category: category,
      rawScore: 0,
      maxPossible: 0,
      percentage: 0,
      statusTier: PreparednessStatus.needsImprovement,
    );
  }

  var rawScore = 0;
  for (final question in questions) {
    // Unanswered questions earn 0 but still count toward maxPossible, so an
    // unfinished assessment visibly drags the percentage down.
    final response = _responseFor(question.id, responses);
    if (response == null) continue;

    final selectedOption =
        question.options.where((o) => o.id == response.selectedOptionId).firstOrNull;
    if (selectedOption == null) continue;

    rawScore += _pointsForRank(selectedOption.rank, question.options.length);
  }

  final maxPossible = questions.length * 5;
  final percentage = rawScore / maxPossible * 100;
  return CategoryResult(
    category: category,
    rawScore: rawScore,
    maxPossible: maxPossible,
    percentage: percentage,
    statusTier: _statusForpercentage(percentage),
  );
}

/// Simple average of the categories' percentages, rounded to the nearest
/// integer (AGENTS.md §6). Danger Signs results are never included here —
/// aggregate only __CategoryResult__s.
DashboardScore aggregateScores(List<CategoryResult> results) {
  if (results.isEmpty) {
    return const DashboardScore(
      overallScore: 0,
      statusTier: PreparednessStatus.needsImprovement,
      results: [],
    );
  }

  final average = results.fold<double>(0, (sum, r) => sum + r.percentage) /
      results.length;
  final overallScore = average.round();
  return DashboardScore(
    overallScore: overallScore,
    statusTier: _statusForpercentage(overallScore.toDouble()),
    results: results,
  );
}

int _pointsForRank(int rank, int optionCount) {
  if (optionCount <= 3) {
    return switch (rank) {
      1 => 5,
      2 => 3,
      _ => 1,
    };
  }
  return switch (rank) {
    1 => 5,
    2 => 3,
    3 => 2,
    _ => 1,
  };
}

/// Status-tier cutoffs (none are implied anywhere else in the repo):
/// ≥80% ready · 60–79% needs_preparation · 40–59% not_yet_ready · <40%
/// needs_improvement.
PreparednessStatus _statusForpercentage(double percentage) {
  if (percentage >= 80) return PreparednessStatus.ready;
  if (percentage >= 60) return PreparednessStatus.needsPreparation;
  if (percentage >= 40) return PreparednessStatus.notYetReady;
  return PreparednessStatus.needsImprovement;
}

QuestionResponse? _responseFor(String questionId, List<QuestionResponse> responses) {
  for (final response in responses) {
    if (response.questionId == questionId) return response;
  }
  return null;
}