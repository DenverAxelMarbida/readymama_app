// lib/core/database/app_database.dart
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Maps to the 5 scored assessment categories defined in AGENTS.md §2.
///
/// Danger Signs is deliberately NOT here — it is a real-time binary screener
/// tracked in [DangerSignsScreenings], never scored into AssessmentScores.
enum AssessmentCategory {
  deliveryPlan,
  hospitalBag,
  emergencyPlan,
  selfPreparedness,
  supportPerson,
}

/// The 4 status tiers used across category cards and the results screen.
enum PreparednessStatus {
  ready,
  needsPreparation,
  notYetReady,
  needsImprovement,
}

/// Which delivery mode a checklist item applies to.
enum DeliveryMode { normalVaginal, cesarean, both }

/// Whether a checklist item belongs to the mother or the baby's bag.
enum ChecklistOwner { mother, baby }

@DataClassName('AssessmentScoreEntry')
class AssessmentScores extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Stored as the enum's name (e.g. "deliveryPlan") for readability in
  /// raw SQL / DB inspection.
  TextColumn get category =>
      textEnum<AssessmentCategory>()();

  /// One row per category — the app scores each category exactly once. This
  /// constrains the table so an upsert can never leave duplicate rows behind,
  /// and the v2 → v3 migration dedupes legacy databases first (see onUpgrade).
  @override
  List<Set<Column>> get uniqueKeys => [
        {category},
      ];

  /// Raw points earned in this category.
  IntColumn get score => integer()();

  /// Max points possible for this category.
  IntColumn get maxScore => integer()();

  TextColumn get status => textEnum<PreparednessStatus>()();

  /// Free-text personalized feedback shown on the results breakdown,
  /// e.g. "You have a primary transport plan, but no backup identified."
  TextColumn get feedback => text().withDefault(const Constant(''))();

  DateTimeColumn get completedAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('ChecklistItemEntry')
class ChecklistItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 120)();

  TextColumn get owner => textEnum<ChecklistOwner>()();

  TextColumn get deliveryMode =>
      textEnum<DeliveryMode>().withDefault(const Constant('both'))();

  BoolColumn get isChecked => boolean().withDefault(const Constant(false))();

  /// True if the user added this item via the "add custom item" modal,
  /// false if it came from the default seeded checklist.
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();

  /// Optional icon/asset key so the UI can pair text with a visual
  /// (low-literacy accessibility requirement).
  TextColumn get iconKey => text().nullable()();

  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// One binary Danger Signs screening result (AGENTS.md §4).
///
/// NOT part of [AssessmentCategory] — danger signs are never scored into the
/// Birth Preparedness percentage. A result with [isDangerDetected] true
/// should route straight to the Emergency tab / an emergency CTA.
@DataClassName('DangerSignsScreeningEntry')
class DangerSignsScreenings extends Table {
  IntColumn get id => integer().autoIncrement()();

  BoolColumn get isDangerDetected =>
      boolean().withDefault(const Constant(false))();

  /// Question ids of the danger-sign questions whose danger option (rank 1)
  /// was selected. Stored as a single comma-separated text column: a proper
  /// join table would be overkill for one boolean screener result, and this
  /// keeps the row trivially inspectable in raw SQL.
  TextColumn get triggeringQuestionIds => text().nullable()();

  DateTimeColumn get completedAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// The mother's Delivery Plan details, edited in My Plan (AGENTS.md §3).
///
/// Effectively-singleton row: the app models one mother's plan, so DAO
/// methods read/write row id = 1 (upsert) instead of multiplicity.
@DataClassName('DeliveryPlanRecordEntry')
class DeliveryPlanRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get preferredFacility => text().nullable()();

  TextColumn get primaryTransport => text().nullable()();

  TextColumn get accompaniedBy => text().nullable()();

  BoolColumn get discussedWithSupportPerson =>
      boolean().withDefault(const Constant(false))();

  TextColumn get backupPlanNotes => text().nullable()();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// The Support Person contact record, edited in My Plan (AGENTS.md §3, §5).
///
/// Items 11+ of the source Support Person questionnaire (free-text data
/// fields — NOT the scored Yes/No/Not Sure items 1–10) belong here and feed
/// the Emergency Card's "Support Person" display.
@DataClassName('SupportPersonRecordEntry')
class SupportPersonRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get fullName => text().nullable()();

  TextColumn get relationship => text().nullable()();

  TextColumn get contactNumber => text().nullable()();

  TextColumn get address => text().nullable()();

  TextColumn get alternateContactName => text().nullable()();

  TextColumn get alternateContactNumber => text().nullable()();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// The Emergency Plan A / Plan B data, edited in My Plan (AGENTS.md §3).
@DataClassName('EmergencyPlanRecordEntry')
class EmergencyPlanRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get primaryHospital => text().nullable()();

  TextColumn get backupHospital => text().nullable()();

  TextColumn get primaryTransport => text().nullable()();

  TextColumn get alternateTransport => text().nullable()();

  TextColumn get primaryRoute => text().nullable()();

  TextColumn get alternateRoute => text().nullable()();

  TextColumn get secondaryContactName => text().nullable()();

  TextColumn get secondaryContactNumber => text().nullable()();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: [
    AssessmentScores,
    ChecklistItems,
    DangerSignsScreenings,
    DeliveryPlanRecords,
    SupportPersonRecords,
    EmergencyPlanRecords,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Test-only constructor that runs against an in-memory / injected
  /// [QueryExecutor] instead of the on-device SQLite file.
  AppDatabase.forTesting(super.executor);

  // Bump this and add a MigrationStrategy step whenever you alter a table
  // after the app has shipped to real users.
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            // v1 -> v2: AssessmentCategory dropped transportationPlan,
            // emergencyFund, and dangerSignKnowledge. textEnum stores values
            // by enum name, so any legacy rows would throw on deserialization.
            // Delete them BEFORE any query can read them back.
            await m.createAll();
            await customStatement(
              "DELETE FROM assessment_scores WHERE category NOT IN "
              "('deliveryPlan', 'hospitalBag', 'emergencyPlan', "
              "'selfPreparedness', 'supportPerson')",
            );
          }
          if (from < 3) {
            // v2 -> v3: AssessmentScores gains a UNIQUE constraint on
            // `category`, so a category can only ever hold one row. Older
            // databases may have accumulated duplicate rows (one per
            // upsert), which would now violate the constraint; keep the
            // newest row (MAX id) per category before rebuilding the table
            // with the new unique key.
            await customStatement(
              "DELETE FROM assessment_scores WHERE id NOT IN "
              "(SELECT MAX(id) FROM assessment_scores GROUP BY category)",
            );
            await m.alterTable(TableMigration(assessmentScores));
          }
        },
      );

  // ---- AssessmentScores DAO methods ----

  Future<List<AssessmentScoreEntry>> getAllScores() =>
      select(assessmentScores).get();

  Stream<List<AssessmentScoreEntry>> watchAllScores() =>
      select(assessmentScores).watch();

  Future<AssessmentScoreEntry?> getScoreForCategory(
    AssessmentCategory category,
  ) {
    return (select(assessmentScores)
          ..where((t) => t.category.equalsValue(category)))
        .getSingleOrNull();
  }

  /// Upserts one row per [AssessmentCategory] (`category` is UNIQUE). A
  /// conflict (category already scored) becomes an UPDATE instead of a new
  /// row, and [AssessmentScores.updatedAt] is refreshed so "last touched"
  /// stays truthful for an in-place overwrite.
  Future<int> upsertScore(AssessmentScoresCompanion entry) {
    final now = Value(DateTime.now());
    return into(assessmentScores).insert(
      entry.copyWith(updatedAt: now),
      onConflict: DoUpdate(
        (old) => entry.copyWith(updatedAt: now),
        target: [assessmentScores.category],
      ),
    );
  }

  /// Sum of `score` across all categories, out of the categories' combined
  /// max score.
  Future<int> getTotalRawScore() async {
    final scores = await getAllScores();
    return scores.fold<int>(0, (sum, e) => sum + e.score);
  }

  // ---- ChecklistItems DAO methods ----

  Stream<List<ChecklistItemEntry>> watchChecklistByOwner(
    ChecklistOwner owner,
  ) {
    return (select(checklistItems)
          ..where((t) => t.owner.equalsValue(owner))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<int> insertChecklistItem(ChecklistItemsCompanion item) =>
      into(checklistItems).insert(item);

  Future<bool> toggleChecklistItem(int id, bool isChecked) {
    return update(checklistItems).replace(
      ChecklistItemsCompanion(
        id: Value(id),
        isChecked: Value(isChecked),
      ),
    );
  }

  Future<int> deleteChecklistItem(int id) =>
      (delete(checklistItems)..where((t) => t.id.equals(id))).go();

  Future<(int checked, int total)> getProgressForOwner(
    ChecklistOwner owner,
  ) async {
    final items = await (select(checklistItems)
          ..where((t) => t.owner.equalsValue(owner)))
        .get();
    final checked = items.where((i) => i.isChecked).length;
    return (checked, items.length);
  }

  // ---- DangerSignsScreenings DAO methods ----

  Future<int> saveScreeningResult(DangerSignsScreeningsCompanion entry) =>
      into(dangerSignsScreenings).insert(entry);

  /// Most recent screening row by completion time, if one has run yet.
  Stream<DangerSignsScreeningEntry?> watchLatestScreening() {
    final query = select(dangerSignsScreenings)
      ..orderBy([(t) => OrderingTerm.desc(t.completedAt)])
      ..limit(1);
    return query.watchSingleOrNull();
  }

  // ---- My Plan record DAO methods (AGENTS.md §3) ----
  // Each record is an effectively-singleton row (id = 1): the app has one
  // mother's plan, not multiple. `saveXRecord` takes a Companion with
  // `id: const Value(1)` and upserts via insertOnConflictUpdate.

  Future<DeliveryPlanRecordEntry?> getDeliveryPlanRecord() =>
      (select(deliveryPlanRecords)..where((t) => t.id.equals(1)))
          .getSingleOrNull();

  Stream<DeliveryPlanRecordEntry?> watchDeliveryPlanRecord() =>
      (select(deliveryPlanRecords)..where((t) => t.id.equals(1)))
          .watchSingleOrNull();

  Future<int> saveDeliveryPlanRecord(DeliveryPlanRecordsCompanion entry) =>
      into(deliveryPlanRecords).insertOnConflictUpdate(entry);

  Future<SupportPersonRecordEntry?> getSupportPersonRecord() =>
      (select(supportPersonRecords)..where((t) => t.id.equals(1)))
          .getSingleOrNull();

  Stream<SupportPersonRecordEntry?> watchSupportPersonRecord() =>
      (select(supportPersonRecords)..where((t) => t.id.equals(1)))
          .watchSingleOrNull();

  Future<int> saveSupportPersonRecord(SupportPersonRecordsCompanion entry) =>
      into(supportPersonRecords).insertOnConflictUpdate(entry);

  Future<EmergencyPlanRecordEntry?> getEmergencyPlanRecord() =>
      (select(emergencyPlanRecords)..where((t) => t.id.equals(1)))
          .getSingleOrNull();

  Stream<EmergencyPlanRecordEntry?> watchEmergencyPlanRecord() =>
      (select(emergencyPlanRecords)..where((t) => t.id.equals(1)))
          .watchSingleOrNull();

  Future<int> saveEmergencyPlanRecord(EmergencyPlanRecordsCompanion entry) =>
      into(emergencyPlanRecords).insertOnConflictUpdate(entry);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'readymama.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}