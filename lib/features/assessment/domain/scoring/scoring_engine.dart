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

/// Each category: N questions × max 5 = N × 5 raw points → 0–100%
/// (AGENTS.md §6). How many points a given rank is worth depends on how many
/// options that particular question has — the source questionnaires mix 2-,
/// 3- and 4-option questions, and their tier scales differ, so the mapping
/// lives in the explicit [_pointsByOptionCount] table rather than being
/// derived arithmetically.
///
/// The floor is always 1, never 0, even for the worst answer: the app
/// measures degree of readiness, not pass/fail.
CategoryResult scoreCategory(
  AssessmentCategory category,
  List<Question> questions,
  List<QuestionResponse> responses,
) {
  // Every question must belong to this category. A null-category Danger Signs
  // question passed in here would be scored with INVERTED rank semantics (rank
  // 1 means "this is the danger sign", not "most prepared") and would silently
  // inflate the score. Fail loudly in debug instead.
  assert(
    questions.every((q) => q.category == category),
    'scoreCategory($category) received a question belonging to a '
    'different category (or a null-category Danger Signs question): '
    '${questions.firstWhere((q) => q.category != category).id}',
  );

  if (questions.isEmpty) {
    return CategoryResult(
      category: category,
      rawScore: 0,
      maxPossible: 0,
      percentage: 0,
      statusTier: PreparednessStatus.needsImprovement,
    );
  }

  // Structural validity of every question is checked up front — before any
  // response is looked at — so a malformed question is caught even if the
  // user never reached it.
  for (final question in questions) {
    _validateQuestionStructure(question);
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

/// Points awarded for each rank, indexed by how many options the question
/// offers. Index 0 of each list is rank 1 (the best answer).
///
/// The 4-tier scale (5/3/2/1) is Hospital Bag's own published weighting —
/// "A = 5 Well Prepared, B = 3 Prepared, C = 2 Slightly Prepared,
/// D = 1 Not Prepared" — extended to the other categories (AGENTS.md §6).
/// 3-tier questions (Support Person's Yes / Not sure / No) skip the "2" tier
/// entirely: 5/3/1. 2-tier questions (Yes / No) are 5/1.
const Map<int, List<int>> _pointsByOptionCount = {
  2: <int>[5, 1],
  3: <int>[5, 3, 1],
  4: <int>[5, 3, 2, 1],
};

/// Fails loudly in debug on a structurally invalid question: an unsupported
/// option count, or ranks that are not exactly 1..N with no gaps and no
/// duplicates. A duplicated or missing rank would otherwise score silently
/// wrong, and a question with, say, 5 options has no defined weighting.
void _validateQuestionStructure(Question question) {
  final optionCount = question.options.length;
  assert(
    optionCount >= 2 && optionCount <= 4,
    'Question ${question.id} has $optionCount options; the scoring table is '
    'only defined for 2, 3 and 4 options.',
  );

  final ranks = question.options.map((o) => o.rank);
  final distinct = ranks.toSet();
  assert(
    distinct.length == optionCount &&
        distinct.containsAll(List<int>.generate(optionCount, (i) => i + 1)),
    'Question ${question.id} must carry ranks 1..$optionCount exactly once '
    'each, with no gaps or duplicates; got ${ranks.toList()}.',
  );
}

int _pointsForRank(int rank, int optionCount) {
  final tiers = _pointsByOptionCount[optionCount];
  if (tiers == null) {
    throw ArgumentError.value(
      optionCount,
      'optionCount',
      'No scoring table for this option count; expected 2, 3 or 4',
    );
  }
  if (rank < 1 || rank > tiers.length) {
    throw RangeError.range(rank, 1, tiers.length, 'rank');
  }
  return tiers[rank - 1];
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