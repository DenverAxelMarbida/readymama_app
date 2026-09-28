// test/core/database/app_database_test.dart
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readymama_app/core/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('upserting the same category twice keeps exactly one row', () async {
    await db.upsertScore(
      AssessmentScoresCompanion.insert(
        category: AssessmentCategory.deliveryPlan,
        score: 32,
        maxScore: 50,
        status: PreparednessStatus.ready,
      ),
    );

    await db.upsertScore(
      AssessmentScoresCompanion.insert(
        category: AssessmentCategory.deliveryPlan,
        score: 41,
        maxScore: 50,
        status: PreparednessStatus.ready,
      ),
    );

    final scores = await db.getAllScores();

    expect(scores, hasLength(1));
    expect(scores.single.category, AssessmentCategory.deliveryPlan);
    expect(scores.single.score, 41);
  });

  test('getScoreForCategory returns the row for a scored category', () async {
    await db.upsertScore(
      AssessmentScoresCompanion.insert(
        category: AssessmentCategory.emergencyPlan,
        score: 30,
        maxScore: 50,
        status: PreparednessStatus.needsPreparation,
      ),
    );

    final entry =
        await db.getScoreForCategory(AssessmentCategory.emergencyPlan);

    expect(entry, isA<AssessmentScoreEntry>());
    expect(entry!.score, 30);
    expect(entry.status, PreparednessStatus.needsPreparation);
  });

  test('upserting all five categories produces exactly five rows', () async {
    for (final category in AssessmentCategory.values) {
      await db.upsertScore(
        AssessmentScoresCompanion.insert(
          category: category,
          score: 25,
          maxScore: 50,
          status: PreparednessStatus.needsImprovement,
        ),
      );
    }

    final scores = await db.getAllScores();

    expect(scores, hasLength(AssessmentCategory.values.length));
  });

  test('v2 -> v3 migration dedupes legacy duplicate rows per category',
      () async {
    final legacyDb = sqlite3.openInMemory();

    legacyDb.execute('''
      CREATE TABLE assessment_scores (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        category TEXT NOT NULL,
        score INTEGER NOT NULL,
        max_score INTEGER NOT NULL,
        status TEXT NOT NULL,
        feedback TEXT NOT NULL DEFAULT '',
        completed_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    void insertDup(String category, int score) {
      legacyDb.execute(
        'INSERT INTO assessment_scores '
        '(category, score, max_score, status, feedback, completed_at, updated_at) '
        'VALUES (?, ?, 50, ?, ?, 1000, 1000)',
        [
          category,
          score,
          PreparednessStatus.ready.name,
          'legacy row',
        ],
      );
    }

    // Two legacy rows for the same category (the bug the v3 migration fixes),
    // interleaved with a row for another category so ordering is well-defined.
    insertDup('deliveryPlan', 30);
    insertDup('hospitalBag', 40);
    insertDup('deliveryPlan', 35);

    legacyDb.userVersion = 2;

    final migrated = AppDatabase.forTesting(NativeDatabase.opened(legacyDb));

    final scores = await migrated.getAllScores();
    final deliveryScores = scores
        .where((e) => e.category == AssessmentCategory.deliveryPlan)
        .toList();

    expect(deliveryScores, hasLength(1));
    // The surviving row is the newest one (highest id) per category.
    expect(deliveryScores.single.score, 35);
    expect(
      scores
          .where((e) => e.category == AssessmentCategory.hospitalBag)
          .single
          .score,
      40,
    );
    expect(scores, hasLength(2));

    await migrated.close();
  });

  test('v2 -> v3 migration leaves a UNIQUE constraint on category: a raw '
      'duplicate INSERT throws', () async {
    // The dedupe test above proves duplicates are COLLAPSED at migration
    // time, but not that the schema itself enforces uniqueness afterwards.
    // This test proves the actual UNIQUE key exists in the migrated table: a
    // second raw INSERT for the same category is rejected by SQLite.
    final legacyDb = sqlite3.openInMemory();

    legacyDb.execute('''
      CREATE TABLE assessment_scores (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        category TEXT NOT NULL,
        score INTEGER NOT NULL,
        max_score INTEGER NOT NULL,
        status TEXT NOT NULL,
        feedback TEXT NOT NULL DEFAULT '',
        completed_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    legacyDb.execute(
      'INSERT INTO assessment_scores '
      '(category, score, max_score, status, feedback, completed_at, updated_at) '
      'VALUES (?, ?, 50, ?, ?, 100, 100)',
      ['deliveryPlan', 30, 'ready', 'legacy row'],
    );

    legacyDb.userVersion = 2;

    final migrated = AppDatabase.forTesting(NativeDatabase.opened(legacyDb));

    // Force the migration to complete before attempting the conflicting raw
    // insert (drift runs migrations lazily on first access).
    final scores = await migrated.getAllScores();
    expect(scores, hasLength(1));

    expect(
      () => legacyDb.execute(
        'INSERT INTO assessment_scores '
        '(category, score, max_score, status, feedback, completed_at, updated_at) '
        'VALUES (?, ?, 50, ?, ?, 200, 200)',
        ['deliveryPlan', 41, 'ready', 'duplicate'],
      ),
      throwsA(isA<SqliteException>()),
    );

    // The table is untouched: still exactly one row for the category.
    final after = await migrated.getAllScores();
    expect(after, hasLength(1));
    expect(after.single.score, 30);

    await migrated.close();
  });
}