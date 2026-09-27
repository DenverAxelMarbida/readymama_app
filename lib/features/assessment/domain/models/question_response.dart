// lib/features/assessment/domain/models/question_response.dart

/// The user's pick for one question: which option she selected.
///
/// Both fields are the stable string ids from [Question] / [QuestionOption]
/// so responses can be persisted and replayed against the question bank
/// without retaining whole question objects.
class QuestionResponse {
  final String questionId;
  final String selectedOptionId;

  const QuestionResponse({
    required this.questionId,
    required this.selectedOptionId,
  });
}