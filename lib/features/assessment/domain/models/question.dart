// lib/features/assessment/domain/models/question.dart
import '../../../../core/database/app_database.dart';
import 'question_option.dart';

/// A single assessment question, kept UI-free so it stays testable.
///
/// [category] is null for Danger Signs screener questions — they are never
/// scored into [AssessmentCategory] (AGENTS.md §4) and only feed the binary
/// screener in `danger_signs_screener.dart`.
class Question {
  final String id;

  /// Nullable: null marks a Danger Signs screener question (never scored).
  final AssessmentCategory? category;

  /// i18n key resolving the question prompt via `AppI18n.t()`.
  final String promptKey;

  final List<QuestionOption> options;

  const Question({
    required this.id,
    required this.category,
    required this.promptKey,
    required this.options,
  });
}