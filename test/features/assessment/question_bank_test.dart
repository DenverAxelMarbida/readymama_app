// test/features/assessment/question_bank_test.dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:readymama_app/core/database/app_database.dart';
import 'package:readymama_app/features/assessment/data/question_bank.dart';
import 'package:readymama_app/features/assessment/domain/models/question.dart';
import 'package:readymama_app/features/assessment/domain/models/question_response.dart';
import 'package:readymama_app/features/assessment/domain/scoring/danger_signs_screener.dart';
import 'package:readymama_app/features/assessment/domain/scoring/scoring_engine.dart';

/// The scored banks, in the source's category order. Danger Signs is absent
/// by design (AGENTS.md §4).
const Map<AssessmentCategory, List<Question>> scoredBanks = {
  AssessmentCategory.deliveryPlan: deliveryPlanQuestions,
  AssessmentCategory.hospitalBag: hospitalBagQuestions,
  AssessmentCategory.emergencyPlan: emergencyPlanQuestions,
  AssessmentCategory.selfPreparedness: selfPreparednessQuestions,
  AssessmentCategory.supportPerson: supportPersonQuestions,
};

const Map<String, List<Question>> banks = {
  'delivery_plan': deliveryPlanQuestions,
  'hospital_bag': hospitalBagQuestions,
  'emergency_plan': emergencyPlanQuestions,
  'self_preparedness': selfPreparednessQuestions,
  'support_person': supportPersonQuestions,
  'danger_signs': dangerSignQuestions,
};

void main() {
  group('bank sizes', () {
    test('each bank holds the number of questions the source defines', () {
      expect(deliveryPlanQuestions, hasLength(10));
      expect(hospitalBagQuestions, hasLength(10));
      expect(emergencyPlanQuestions, hasLength(10));
      expect(selfPreparednessQuestions, hasLength(10));
      // Support Person's 9 scored questions; Q2 + Q11-Q16 are excluded.
      expect(supportPersonQuestions, hasLength(9));
      expect(dangerSignQuestions, hasLength(10));
    });

    test('the whole bank is 59 questions across 6 categories', () {
      final all = [
        ...deliveryPlanQuestions,
        ...hospitalBagQuestions,
        ...emergencyPlanQuestions,
        ...selfPreparednessQuestions,
        ...supportPersonQuestions,
        ...dangerSignQuestions,
      ];
      expect(all, hasLength(59));
      expect(banks, hasLength(6));
    });

    test('scoredQuestions holds the 49 scored questions and no Danger Signs',
        () {
      expect(scoredQuestions, hasLength(49));
      expect(
        scoredQuestions.every((q) => q.category != null),
        isTrue,
        reason: 'Danger Signs must never enter the scored set (AGENTS.md §4)',
      );
      expect(
        scoredQuestions.map((q) => q.id).toSet().length,
        49,
        reason: 'scoredQuestions must not duplicate questions',
      );
    });

    test('Support Person excludes Q2 and Q11-Q16, keeping source numbering',
        () {
      final numbers = supportPersonQuestions
          .map((q) => int.parse(q.id.split('.').last.substring(1)))
          .toList();
      expect(numbers, [1, 3, 4, 5, 6, 7, 8, 9, 10]);
      // Q2 is the 7-option relationship field; it belongs to My Plan.
      expect(
        supportPersonQuestions.any((q) => q.id.endsWith('q2')),
        isFalse,
        reason: 'Support Person Q2 is a relationship field, not a scored question',
      );
    });
  });

  group('ids and i18n keys', () {
    test('every question id and key follows the q./questions. namespace', () {
      for (final entry in banks.entries) {
        final category = entry.key;
        for (final question in entry.value) {
          final stem = question.id.split('.').last; // e.g. q1, q10
          expect(question.id, startsWith('q.$category.'));
          expect(question.promptKey, 'questions.$category.$stem');

          for (final option in question.options) {
            // Suffixes may themselves contain "_" (e.g. "not_sure"), so strip
            // the known question stem rather than splitting on the separator.
            expect(option.id, startsWith('${question.id}_'));
            final suffix = option.id.substring(question.id.length + 1);
            expect(suffix, isNotEmpty);
            expect(option.labelKey, '${question.promptKey}_$suffix');
          }
        }
      }
    });
    test('question and option ids are globally unique', () {
      final ids = <String>{};
      for (final question in [
        ...deliveryPlanQuestions,
        ...hospitalBagQuestions,
        ...emergencyPlanQuestions,
        ...selfPreparednessQuestions,
        ...supportPersonQuestions,
        ...dangerSignQuestions,
      ]) {
        expect(ids.add(question.id), isTrue, reason: 'duplicate ${question.id}');
        for (final option in question.options) {
          expect(ids.add(option.id), isTrue,
              reason: 'duplicate option ${option.id}');
        }
      }
      expect(ids, hasLength(59 + 225));
    });

    test('every prompt and option key resolves in BOTH locales', () {
      final en = _loadJson('assets/i18n/en.json');
      final fil = _loadJson('assets/i18n/fil.json');

      for (final question in [
        ...deliveryPlanQuestions,
        ...hospitalBagQuestions,
        ...emergencyPlanQuestions,
        ...selfPreparednessQuestions,
        ...supportPersonQuestions,
        ...dangerSignQuestions,
      ]) {
        for (final key in [
          question.promptKey,
          ...question.options.map((o) => o.labelKey),
        ]) {
          final enValue = _resolve(en, key);
          final filValue = _resolve(fil, key);
          expect(enValue, isNotNull, reason: 'en.json is missing $key');
          expect(filValue, isNotNull, reason: 'fil.json is missing $key');
          expect((enValue! as String).trim(), isNotEmpty, reason: '$key is blank');
          expect((filValue! as String).trim(), isNotEmpty,
              reason: '$key is blank in fil.json');
        }
      }
    });

    test('the questions namespace holds 59 prompts and 225 options per locale',
        () {
      for (final path in ['assets/i18n/en.json', 'assets/i18n/fil.json']) {
        final data = _loadJson(path);
        expect(data.containsKey('questions'), isTrue, reason: path);
        expect(data.containsKey('sample_questions'), isFalse,
            reason: '$path still has the retired sample_questions namespace');

        final questions = data['questions'] as Map<String, dynamic>;
        var prompts = 0;
        var options = 0;
        for (final bucket in questions.values) {
          for (final key in (bucket as Map<String, dynamic>).keys) {
            if (key.contains('_')) {
              options++;
            } else {
              prompts++;
            }
          }
        }
        expect(prompts, 59, reason: path);
        expect(options, 225, reason: path);
      }
    });

    test('en.json and fil.json expose an identical key set', () {
      final en = _loadJson('assets/i18n/en.json');
      final fil = _loadJson('assets/i18n/fil.json');
      final enKeys = _flattenKeys(en['questions'] as Map<String, dynamic>);
      final filKeys = _flattenKeys(fil['questions'] as Map<String, dynamic>);

      expect(enKeys.difference(filKeys), isEmpty,
          reason: 'keys present in en.json but missing from fil.json');
      expect(filKeys.difference(enKeys), isEmpty,
          reason: 'keys present in fil.json but missing from en.json');
      expect(enKeys, hasLength(284));
    });
  });

  group('rank structure', () {
    test('every question has exactly one rank-1 option', () {
      for (final entry in banks.entries) {
        for (final question in entry.value) {
          expect(
            question.options.where((o) => o.rank == 1),
            hasLength(1),
            reason: '${question.id} must have exactly one best answer',
          );
        }
      }
    });

    test('every question carries ranks 1..N with no gaps or duplicates', () {
      for (final entry in banks.entries) {
        for (final question in entry.value) {
          final ranks = question.options.map((o) => o.rank).toList()..sort();
          expect(ranks, List<int>.generate(question.options.length, (i) => i + 1),
              reason: '${question.id} has ranks $ranks');
        }
      }
    });

    test('every question offers between 2 and 4 options', () {
      for (final entry in banks.entries) {
        for (final question in entry.value) {
          expect(question.options.length, inInclusiveRange(2, 4),
              reason: '${question.id} has ${question.options.length} options');
        }
      }
    });

    test('Danger Signs rank 1 is always the FIRST option (source option A)', () {
      // The screener's contract is "option A means danger", so rank 1 must
      // stay pinned to display position 0 in every danger question.
      for (final question in dangerSignQuestions) {
        expect(question.options.first.rank, 1, reason: question.id);
      }
    });

    test('Hospital Bag is the source\'s own A=5 B=3 C=2 D=1 ordering', () {
      for (final question in hospitalBagQuestions) {
        final bySuffix = _ranksBySuffix(question);
        expect(bySuffix['a'], 1, reason: question.id);
        expect(bySuffix['b'], 2, reason: question.id);
        expect(bySuffix['c'], 3, reason: question.id);
        expect(bySuffix['d'], 4, reason: question.id);
      }
    });

    test('Self-Preparedness maps Strongly Agree to rank 1 and Strongly '
        'Disagree to rank 4', () {
      for (final question in selfPreparednessQuestions) {
        final bySuffix = _ranksBySuffix(question);
        expect(bySuffix['sa'], 1, reason: question.id);
        expect(bySuffix['a'], 2, reason: question.id);
        expect(bySuffix['d'], 3, reason: question.id);
        expect(bySuffix['sd'], 4, reason: question.id);
      }
    });

    test('Support Person rank table matches the stored source ordering', () {
      // Every scored Support Person question's rank is pinned here so a future
      // "helpful" re-rank fails the build. The table below is the shipped
      // rank map (id suffix -> rank) for each question, PLUS the display
      // order the options ship in (which is the order they appear in the
      // source, not the rank order — e.g. q4 ships anytime/sometimes/no/sure).
      const expectedRanks = <String, Map<String, int>>{
        'q1': {'yes': 1, 'no': 2},
        'q3': {'yes': 1, 'not_sure': 2, 'no': 3},
        'q4': {'yes_anytime': 1, 'sometimes': 2, 'not_sure': 3, 'no': 4},
        'q5': {'yes': 1, 'no': 2},
        'q6': {'yes': 1, 'not_sure': 2, 'no': 3},
        'q7': {'yes': 1, 'not_sure': 2, 'no': 3},
        'q8': {'yes': 1, 'partially': 2, 'no': 3},
        'q9': {'yes': 1, 'no': 2},
        'q10': {'yes': 1, 'sometimes': 2, 'no': 3},
      };
      const expectedOrder = <String, List<String>>{
        'q1': ['yes', 'no'],
        'q3': ['yes', 'no', 'not_sure'],
        'q4': ['yes_anytime', 'sometimes', 'no', 'not_sure'],
        'q5': ['yes', 'no'],
        'q6': ['yes', 'no', 'not_sure'],
        'q7': ['yes', 'no', 'not_sure'],
        'q8': ['yes', 'no', 'partially'],
        'q9': ['yes', 'no'],
        'q10': ['yes', 'no', 'sometimes'],
      };

      for (final entry in expectedRanks.entries) {
        final question =
            supportPersonQuestions.firstWhere((q) => q.id.endsWith(entry.key));
        final bySuffix = _ranksBySuffix(question);
        expect(bySuffix, entry.value, reason: entry.key);
        expect(
          question.options.map((o) => o.id.substring(question.id.length + 1)),
          expectedOrder[entry.key],
          reason: '${entry.key} display order',
        );
      }
    });

    test('Emergency Q4 ranks "ignore the pain" last and "take any medicine" '
        'third', () {
      // §11 flagged that Emergency Q1/Q6/Q10 all rank "ignore it" dead last
      // but Q4 ranked "Ignore the pain" at 3. Fixed: ignoring a severe symptom
      // is now as unsafe as Q1/Q6/Q10's ignore options (4), while
      // self-medicating is third-worst (3). b=2, c=1 unchanged.
      final question = emergencyPlanQuestions.firstWhere((q) => q.id.endsWith('q4'));
      final bySuffix = _ranksBySuffix(question);
      expect(bySuffix['a'], 4, reason: question.id);
      expect(bySuffix['b'], 2, reason: question.id);
      expect(bySuffix['c'], 1, reason: question.id);
      expect(bySuffix['d'], 3, reason: question.id);
    });

    test('rank 1 follows the source answer key, not letter position', () {
      // §4: "Rank 1 is not always option A." Each scored bank's best answer
      // is pinned to the suffix the source key chooses, so an accidental
      // re-sort that moved rank 1 to a different letter fails here.
      const rankOneSuffix = <String, List<String>>{
        'delivery_plan': ['q1_a', 'q2_b', 'q3_a', 'q4_a', 'q5_b', 'q6_a',
          'q7_a', 'q8_a', 'q9_a', 'q10_a'],
        'emergency_plan': ['q1_b', 'q2_c', 'q3_a', 'q4_c', 'q5_a', 'q6_b',
          'q7_c', 'q8_a', 'q9_b', 'q10_b'],
      };
      for (final entry in rankOneSuffix.entries) {
        final questions = banks[entry.key]!;
        expect(questions, hasLength(entry.value.length), reason: entry.key);
        for (var i = 0; i < questions.length; i++) {
          final expectSuffix = entry.value[i];
          final actual = questions[i].options
              .singleWhere((o) => o.rank == 1)
              .id
              .split('.')
              .last;
          expect(actual, expectSuffix,
              reason: '${entry.key} question ${i + 1} rank 1');
        }
      }
    });
  });

  group('category assignment', () {
    test('every scored question carries its bank\'s category', () {
      for (final entry in scoredBanks.entries) {
        for (final question in entry.value) {
          expect(question.category, entry.key, reason: question.id);
        }
      }
    });

    test('Danger Signs questions carry a null category', () {
      for (final question in dangerSignQuestions) {
        expect(question.category, isNull, reason: question.id);
      }
    });
  });

  group('the bank scores end to end', () {
    test('answering every question perfectly gives 100% in all 5 banks', () {
      for (final entry in scoredBanks.entries) {
        final result = scoreCategory(
          entry.key,
          entry.value,
          _allBestAnswers(entry.value),
        );
        expect(result.rawScore, entry.value.length * 5, reason: entry.key.name);
        expect(result.percentage, closeTo(100.0, 0.001), reason: entry.key.name);
        expect(result.statusTier, PreparednessStatus.ready);
      }
    });

    test('answering everything worst-case still earns the 1-point floor', () {
      for (final entry in scoredBanks.entries) {
        final responses = [
          for (final question in entry.value)
            QuestionResponse(
              questionId: question.id,
              selectedOptionId: question.options
                  .firstWhere((o) => o.rank == question.options.length)
                  .id,
            ),
        ];
        final result = scoreCategory(entry.key, entry.value, responses);
        // Every question contributes exactly 1 point.
        expect(result.rawScore, entry.value.length, reason: entry.key.name);
        expect(result.percentage, closeTo(20.0, 0.001), reason: entry.key.name);
        expect(result.statusTier, PreparednessStatus.needsImprovement);
      }
    });

    test('the dashboard score averages the 5 banks and excludes Danger Signs',
        () {
      final results = [
        for (final entry in scoredBanks.entries)
          scoreCategory(entry.key, entry.value, _allBestAnswers(entry.value)),
      ];
      expect(results, hasLength(5));

      final score = aggregateScores(results);
      expect(score.overallScore, 100);
      expect(score.statusTier, PreparednessStatus.ready);
      // Danger Signs is not an AssessmentCategory at all (AGENTS.md §4), so it
      // cannot appear in the rolled-up score.
      expect(score.results, hasLength(AssessmentCategory.values.length));
      expect(
        score.results.map((r) => r.category).toSet(),
        AssessmentCategory.values.toSet(),
      );
    });
  });

  group('danger signs screener', () {
    test('selecting the rank-1 option of any question detects danger', () {
      for (final question in dangerSignQuestions) {
        final single = screenDangerSigns(
          dangerSignQuestions: [question],
          responses: [
            QuestionResponse(
              questionId: question.id,
              selectedOptionId: question.options.first.id,
            ),
          ],
        );
        expect(single.isDangerDetected, isTrue, reason: question.id);
        expect(single.triggeringQuestionIds, [question.id], reason: question.id);
      }
    });

    test('all-danger answers report every question as triggering', () {
      final result = screenDangerSigns(
        dangerSignQuestions: dangerSignQuestions,
        responses: [
          for (final q in dangerSignQuestions)
            QuestionResponse(
              questionId: q.id,
              selectedOptionId: q.options
                  .firstWhere((o) => o.rank == 1)
                  .id,
            ),
        ],
      );
      expect(result.isDangerDetected, isTrue);
      expect(result.triggeringQuestionIds,
          dangerSignQuestions.map((q) => q.id).toList());
    });

    test('answering B/C/D everywhere reports no immediate danger', () {
      final responses = [
        for (final question in dangerSignQuestions)
          QuestionResponse(
            questionId: question.id,
            selectedOptionId:
                question.options.firstWhere((o) => o.rank >= 2).id,
          ),
      ];

      final result = screenDangerSigns(
        dangerSignQuestions: dangerSignQuestions,
        responses: responses,
      );

      expect(result.isDangerDetected, isFalse);
      expect(result.triggeringQuestionIds, isEmpty);
    });

    test('the screener rejects the scored banks', () {
      expect(
        () => screenDangerSigns(
          dangerSignQuestions: [emergencyPlanQuestions.first],
          responses: const [],
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('verbatim source content', () {
    // These guard the deliberate decision to copy the PDF's typos rather
    // than silently fix them. If a string is ever "cleaned up", these fail.
    test('Self-Preparedness Q10 keeps the missing leading "I"', () {
      final en = _loadJson('assets/i18n/en.json');
      final prompt =
          _resolve(en, 'questions.self_preparedness.q10')! as String;
      expect(prompt, startsWith('know how to recognize'));
    });

    test('Emergency Q3 keeps the Tagalog typo "Aling sintomas"', () {
      final fil = _loadJson('assets/i18n/fil.json');
      expect(
        _resolve(fil, 'questions.emergency_plan.q3'),
        'Aling sintomas habang buntis ang nangangailangan ng agarang medikal '
        'na atensyon?',
      );
    });

    test('the retired sample_questions namespace is gone', () {
      for (final path in ['assets/i18n/en.json', 'assets/i18n/fil.json']) {
        final data = _loadJson(path);
        expect(data.containsKey('sample_questions'), isFalse, reason: path);
      }
    });
  });
}

/// Maps an option's id suffix (e.g. "a", "not_sure", "sa") to its rank.
/// Suffixes can contain "_", so the question stem is stripped by length rather
/// than by splitting on "_".
Map<String, int> _ranksBySuffix(Question question) => {
      for (final option in question.options)
        option.id.substring(question.id.length + 1): option.rank,
    };

List<QuestionResponse> _allBestAnswers(List<Question> questions) => [
      for (final question in questions)
        QuestionResponse(
          questionId: question.id,
          selectedOptionId: question.options.firstWhere((o) => o.rank == 1).id,
        ),
    ];

Map<String, dynamic> _loadJson(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

/// Resolves a dotted `AppI18n.t()` key, mirroring the app's lookup.
Object? _resolve(Map<String, dynamic> data, String dottedKey) {
  Object? node = data;
  for (final part in dottedKey.split('.')) {
    if (node is! Map<String, dynamic>) return null;
    node = node[part];
  }
  return node;
}

Set<String> _flattenKeys(Map<String, dynamic> namespaces) => {
      for (final entry in namespaces.entries)
        for (final key in (entry.value as Map<String, dynamic>).keys)
          '${entry.key}.$key',
    };
