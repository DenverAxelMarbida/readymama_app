// lib/core/database/app_database.dart
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Maps directly to the 7 core assessment categories defined in the
/// Smart Birth Preparedness spec.
enum AssessmentCategory {
  deliveryPlan,
  transportationPlan,
  emergencyFund,
  hospitalBag,
  supportPerson,
  emergencyPlan,
  dangerSignKnowledge,
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

  /// Raw points earned in this category.
  IntColumn get score => integer()();

  /// Max points possible for this category (contributes to the 80-pt total).
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

@DriftDatabase(tables: [AssessmentScores, ChecklistItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Bump this and add a MigrationStrategy step whenever you alter a table
  // after the app has shipped to real users.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Add stepwise migrations here as schemaVersion increases.
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

  Future<int> upsertScore(AssessmentScoresCompanion entry) {
    return into(assessmentScores).insertOnConflictUpdate(entry);
  }

  /// Sum of `score` across all categories, out of the 80-point raw scale.
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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'readymama.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}