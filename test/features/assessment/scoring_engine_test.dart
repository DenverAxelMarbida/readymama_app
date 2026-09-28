// test/features/assessment/scoring_engine_test.dart
import 'package:flutter_test/flutter_test.dart';

import 'package:readymama_app/core/database/app_database.dart';
import 'package:readymama_app/features/assessment/domain/models/question.dart';
import 'package:readymama_app/features/assessment/domain/models/question_option.dart';
import 'package:readymama_app/features/assessment/domain/models/question_response.dart';
import 'package:readymama_app/features/assessment/domain/scoring/danger_signs_screener.dart';
import 'package:readymama_app/features/assessment/domain/scoring/scoring_engine.dart';

void main() {
  group('scoreCategory', () {
    test('scores 100% when every answer is rank 1', () {
      final questions = _questions(10, category: AssessmentCategory.deliveryPlan);
      final responses = _responses(List.filled(10, 1));

      final result = scoreCategory(
        AssessmentCategory.deliveryPlan,
        questions,
        responses,
      );

      expect(result.rawScore, 50);
      expect(result.maxPossible, 50);
      expect(result.percentage, closeTo(100.0, 0.001));
      expect(result.statusTier, PreparednessStatus.ready);
      expect(result.category, AssessmentCategory.deliveryPlan);
    });

    test('maps a mix of ranks to the expected percentage', () {
      // ranks: 1,2,3,4 -> points 5,3,2,1 => 5+3+2+1+5+3+2+1+5+5 = 32 / 50.
      final questions = _questions(10, category: AssessmentCategory.hospitalBag);
      final responses =
          _responses(const [1, 2, 3, 4, 1, 2, 3, 4, 1, 1]);

      final result = scoreCategory(
        AssessmentCategory.hospitalBag,
        questions,
        responses,
      );

      expect(result.rawScore, 32);
      expect(result.percentage, closeTo(64.0, 0.001));
      expect(result.statusTier, PreparednessStatus.needsPreparation);
    });

    test('skips the "2" points tier for 3-option (Yes/Not sure/No) questions',
        () {
      // Support Person 3-tier: rank 1 = 5, rank 2 = 3, rank 3 = 1. A rank-3
      // answer must earn 1 point, not 2 — so raw = 5 + 3 + 1 = 9 of 15.
      final questions = _questions(
        3,
        category: AssessmentCategory.supportPerson,
        optionCount: 3,
      );
      final responses = _responses(const [1, 2, 3]);

      final result = scoreCategory(
        AssessmentCategory.supportPerson,
        questions,
        responses,
      );

      expect(result.rawScore, 9);
      expect(result.maxPossible, 15);
      expect(result.percentage, closeTo(60.0, 0.001));
      expect(result.statusTier, PreparednessStatus.needsPreparation);
    });

    test('treats unanswered questions as 0 points without shrinking max', () {
      final questions = _questions(2, category: AssessmentCategory.deliveryPlan);
      final responses = _responses(const [1]); // q1 answered, q2 unanswered

      final result = scoreCategory(
        AssessmentCategory.deliveryPlan,
        questions,
        responses,
      );

      expect(result.rawScore, 5);
      expect(result.maxPossible, 10);
      expect(result.percentage, closeTo(50.0, 0.001));
      expect(result.statusTier, PreparednessStatus.notYetReady);
    });

    test('status-tier boundaries: ready at exactly 80%', () {
      // 15 × rank1 (75) + 5 × rank4 (5) = 80 / 100.
      final result = _scoreAt(AssessmentCategory.deliveryPlan,
          const [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 4, 4, 4, 4]);
      expect(result.percentage, closeTo(80.0, 0.001));
      expect(result.statusTier, PreparednessStatus.ready);
    });

    test('status-tier boundaries: needs_preparation just below 80%', () {
      // 13 × rank1 (65) + 7 × rank3 (14) = 79 / 100.
      final result = _scoreAt(AssessmentCategory.deliveryPlan,
          const [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3]);
      expect(result.percentage, closeTo(79.0, 0.001));
      expect(result.statusTier, PreparednessStatus.needsPreparation);
    });

    test('status-tier boundaries: needs_preparation at exactly 60%', () {
      // 10 × rank1 (50) + 10 × rank4 (10) = 60 / 100.
      final result = _scoreAt(AssessmentCategory.emergencyPlan,
          const [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]);
      expect(result.percentage, closeTo(60.0, 0.001));
      expect(result.statusTier, PreparednessStatus.needsPreparation);
    });

    test('status-tier boundaries: not_yet_ready just below 60%', () {
      // 9 × rank1 (45) + 3 × rank3 (6) + 8 × rank4 (8) = 59 / 100.
      final result = _scoreAt(AssessmentCategory.emergencyPlan,
          const [1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4]);
      expect(result.percentage, closeTo(59.0, 0.001));
      expect(result.statusTier, PreparednessStatus.notYetReady);
    });

    test('status-tier boundaries: not_yet_ready at exactly 40%', () {
      // 5 × rank1 (25) + 15 × rank4 (15) = 40 / 100.
      final result = _scoreAt(AssessmentCategory.selfPreparedness,
          const [1, 1, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]);
      expect(result.percentage, closeTo(40.0, 0.001));
      expect(result.statusTier, PreparednessStatus.notYetReady);
    });

    test('status-tier boundaries: needs_improvement just below 40%', () {
      // 4 × rank1 (20) + 3 × rank3 (6) + 13 × rank4 (13) = 39 / 100.
      final result = _scoreAt(AssessmentCategory.selfPreparedness,
          const [1, 1, 1, 1, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]);
      expect(result.percentage, closeTo(39.0, 0.001));
      expect(result.statusTier, PreparednessStatus.needsImprovement);
    });

    test('throws an AssertionError when given a null-category question', () {
      // A Danger Signs question has inverted rank semantics (rank 1 = the
      // danger sign). Scoring it here would silently inflate the result, so
      // the guard must fail loudly in debug mode.
      final dangerSignQuestion = _questions(
        1,
        category: null,
        optionCount: 4,
      ).single;
      final scoredQuestion = _questions(
        1,
        category: AssessmentCategory.deliveryPlan,
      ).single;

      expect(
        () => scoreCategory(
          AssessmentCategory.deliveryPlan,
          [scoredQuestion, dangerSignQuestion],
          const [],
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('scoring table (2-, 3- and 4-option questions)', () {
    // The source questionnaires mix option counts, and the scale is not
    // derived arithmetically — it is an explicit table (AGENTS.md §6):
    // 2 options 5/1 · 3 options 5/3/1 · 4 options 5/3/2/1.
    const expected = {
      2: [5, 1],
      3: [5, 3, 1],
      4: [5, 3, 2, 1],
    };

    for (final entry in expected.entries) {
      final optionCount = entry.key;
      final tiers = entry.value;

      for (var rank = 1; rank <= optionCount; rank++) {
        test('$optionCount options, rank $rank earns ${tiers[rank - 1]} points',
            () {
          final questions = _questions(
            1,
            category: AssessmentCategory.supportPerson,
            optionCount: optionCount,
          );
          final responses = _responses([rank]);

          final result = scoreCategory(
            AssessmentCategory.supportPerson,
            questions,
            responses,
          );

          // One question, max 5, so points map straight onto the percentage.
          expect(result.rawScore, tiers[rank - 1]);
          expect(result.maxPossible, 5);
          expect(result.percentage, closeTo(tiers[rank - 1] / 5 * 100, 0.001));
        });
      }
    }

    test('a 2-option (Yes/No) question scores 100% / 20%', () {
      // Support Person Q1, Q5 and Q9 are the only 2-option scored questions.
      final questions = _questions(
        5,
        category: AssessmentCategory.supportPerson,
        optionCount: 2,
      );
      final best = scoreCategory(
        AssessmentCategory.supportPerson,
        questions,
        _responses(const [1, 1, 1, 1, 1]),
      );
      final worst = scoreCategory(
        AssessmentCategory.supportPerson,
        questions,
        _responses(const [2, 2, 2, 2, 2]),
      );

      expect(best.rawScore, 25);
      expect(best.percentage, closeTo(100.0, 0.001));
      expect(best.statusTier, PreparednessStatus.ready);

      // The floor is 1, never 0 (AGENTS.md §6): all-No still earns 5 of 25.
      expect(worst.rawScore, 5);
      expect(worst.percentage, closeTo(20.0, 0.001));
      expect(worst.statusTier, PreparednessStatus.needsImprovement);
    });
  });

  group('structural validation', () {
    test('rejects a question with an unsupported option count', () {
      // The table is only defined for 2, 3 and 4 options; a 5-option question
      // (Support Person Q2's 7 relationship categories was excluded for
      // exactly this reason) has no defined weighting.
      final five = _questions(
        1,
        category: AssessmentCategory.supportPerson,
        optionCount: 5,
      );

      expect(
        () => scoreCategory(AssessmentCategory.supportPerson, five, const []),
        throwsA(isA<AssertionError>()),
      );
    });

    test('rejects a single-option question', () {
      final one = _questions(
        1,
        category: AssessmentCategory.supportPerson,
        optionCount: 1,
      );

      expect(
        () => scoreCategory(AssessmentCategory.supportPerson, one, const []),
        throwsA(isA<AssertionError>()),
      );
    });

    test('rejects a duplicated rank', () {
      final bad = Question(
        id: 'q_dup',
        category: AssessmentCategory.hospitalBag,
        promptKey: 'prompt',
        options: const [
          QuestionOption(id: 'a', labelKey: 'l', rank: 1),
          QuestionOption(id: 'b', labelKey: 'l', rank: 2),
          QuestionOption(id: 'c', labelKey: 'l', rank: 3),
          QuestionOption(id: 'd', labelKey: 'l', rank: 3),
        ],
      );

      expect(
        () => scoreCategory(AssessmentCategory.hospitalBag, [bad], const []),
        throwsA(isA<AssertionError>()),
      );
    });

    test('rejects a gap in the ranks', () {
      // 1,2,4,5: rank 3 is missing and 5 is out of range for a 4-option
      // question, so the question can never be scored correctly.
      final bad = Question(
        id: 'q_gap',
        category: AssessmentCategory.hospitalBag,
        promptKey: 'prompt',
        options: const [
          QuestionOption(id: 'a', labelKey: 'l', rank: 1),
          QuestionOption(id: 'b', labelKey: 'l', rank: 2),
          QuestionOption(id: 'c', labelKey: 'l', rank: 4),
          QuestionOption(id: 'd', labelKey: 'l', rank: 5),
        ],
      );

      expect(
        () => scoreCategory(AssessmentCategory.hospitalBag, [bad], const []),
        throwsA(isA<AssertionError>()),
      );
    });

    test('accepts non-monotonic ranks (rank is not the display order)', () {
      // Delivery Plan Q1's real ranking is A=1, B=2, C=4, D=3 — a valid
      // permutation, so it must NOT trip the validator.
      final question = Question(
        id: 'q_perm',
        category: AssessmentCategory.deliveryPlan,
        promptKey: 'prompt',
        options: const [
          QuestionOption(id: 'a', labelKey: 'l', rank: 1),
          QuestionOption(id: 'b', labelKey: 'l', rank: 2),
          QuestionOption(id: 'c', labelKey: 'l', rank: 4),
          QuestionOption(id: 'd', labelKey: 'l', rank: 3),
        ],
      );

      final result = scoreCategory(
        AssessmentCategory.deliveryPlan,
        [question],
        const [QuestionResponse(questionId: 'q_perm', selectedOptionId: 'c')],
      );

      // rank 4 of a 4-option question is worth 1 point.
      expect(result.rawScore, 1);
      expect(result.percentage, closeTo(20.0, 0.001));
    });

    test('validates every question even when the user never answered it', () {
      final bad = Question(
        id: 'q_unreached',
        category: AssessmentCategory.emergencyPlan,
        promptKey: 'prompt',
        options: const [
          QuestionOption(id: 'a', labelKey: 'l', rank: 1),
          QuestionOption(id: 'b', labelKey: 'l', rank: 2),
          QuestionOption(id: 'c', labelKey: 'l', rank: 2),
        ],
      );

      expect(
        () => scoreCategory(AssessmentCategory.emergencyPlan, [bad], const []),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('aggregateScores', () {
    test('averages the 5 categories percentages and rounds to nearest int', () {
      final results = [
        _scoreAt(AssessmentCategory.deliveryPlan, List.filled(20, 1)), // 100
        _scoreAt(AssessmentCategory.hospitalBag,
            const [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 4, 4, 4, 4]), // 80
        _scoreAt(AssessmentCategory.emergencyPlan,
            const [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]), // 60
        _scoreAt(AssessmentCategory.selfPreparedness,
            const [1, 1, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]), // 40
        _scoreAt(AssessmentCategory.supportPerson, List.filled(20, 4)), // 20
      ];

      final score = aggregateScores(results);

      // (100 + 80 + 60 + 40 + 20) / 5 = 60.
      expect(score.overallScore, 60);
      expect(score.statusTier, PreparednessStatus.needsPreparation);
      expect(score.results, hasLength(5));
    });

    test('returns 0 / needs_improvement for an empty result set', () {
      final score = aggregateScores(const []);
      expect(score.overallScore, 0);
      expect(score.statusTier, PreparednessStatus.needsImprovement);
    });
  });

  group('screenDangerSigns', () {
    test('detects danger when one of nine good answers selects rank 1', () {
      final questions = _questions(10, category: null, optionCount: 4);

      // Question index 3 selects the danger option (rank 1); the rest pick
      // ranked-2-to-4 (non-danger) options.
      final responses = _responses(const [2, 3, 4, 1, 2, 3, 4, 2, 3, 4]);

      final result = screenDangerSigns(
        dangerSignQuestions: questions,
        responses: responses,
      );

      expect(result.isDangerDetected, isTrue);
      expect(result.triggeringQuestionIds, ['q3']);
    });

    test('does not trigger when zero danger options are selected', () {
      final questions = _questions(10, category: null, optionCount: 4);
      final responses = _responses(const [2, 3, 4, 2, 3, 4, 2, 3, 4, 3]);

      final result = screenDangerSigns(
        dangerSignQuestions: questions,
        responses: responses,
      );

      expect(result.isDangerDetected, isFalse);
      expect(result.triggeringQuestionIds, isEmpty);
    });

    test('ignores questions the user did not answer', () {
      final questions = _questions(2, category: null, optionCount: 4);
      // Only the second question answered, safely (rank 4).
      final responses = _responses(const [4]);

      final result = screenDangerSigns(
        dangerSignQuestions: questions,
        responses: responses,
      );

      expect(result.isDangerDetected, isFalse);
      expect(result.triggeringQuestionIds, isEmpty);
    });

    test('throws an AssertionError when given a scored (non-null category) '
        'question', () {
      // Scored questions carry NORMAL rank semantics (rank 1 = most prepared),
      // so screening one here would invert the meaning and report a danger
      // sign for the best possible answer. The guard must fail loudly.
      final scoredQuestion = _questions(
        1,
        category: AssessmentCategory.emergencyPlan,
        optionCount: 4,
      ).single;

      expect(
        () => screenDangerSigns(
          dangerSignQuestions: [scoredQuestion],
          responses: const [],
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}

/// Builds `count` questions for a category (nullable for danger-sign
/// screens), each with `optionCount` options where option at index j has
/// rank j + 1.
List<Question> _questions(
  int count, {
  required AssessmentCategory? category,
  int optionCount = 4,
}) =>
    List.generate(
      count,
      (i) => Question(
        id: 'q$i',
        category: category,
        promptKey: 'prompt_$i',
        options: List.generate(
          optionCount,
          (j) => QuestionOption(
            id: 'q${i}_o$j',
            labelKey: 'option_$j',
            rank: j + 1,
          ),
        ),
      ),
    );

/// Builds responses whose nth element picks the option with rank `ranks[n]`.
List<QuestionResponse> _responses(List<int> ranks) => [
      for (var i = 0; i < ranks.length; i++)
        QuestionResponse(
          questionId: 'q$i',
          selectedOptionId: 'q${i}_o${ranks[i] - 1}',
        ),
    ];

/// Scores a 20-question category (max 100) from an explicit rank list.
CategoryResult _scoreAt(AssessmentCategory category, List<int> ranks) {
  final questions = _questions(20, category: category);
  return scoreCategory(category, questions, _responses(ranks));
}