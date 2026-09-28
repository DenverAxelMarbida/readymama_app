// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AssessmentScoresTable extends AssessmentScores
    with TableInfo<$AssessmentScoresTable, AssessmentScoreEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssessmentScoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AssessmentCategory, String>
  category =
      GeneratedColumn<String>(
        'category',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AssessmentCategory>(
        $AssessmentScoresTable.$convertercategory,
      );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxScoreMeta = const VerificationMeta(
    'maxScore',
  );
  @override
  late final GeneratedColumn<int> maxScore = GeneratedColumn<int>(
    'max_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PreparednessStatus, String>
  status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<PreparednessStatus>($AssessmentScoresTable.$converterstatus);
  static const VerificationMeta _feedbackMeta = const VerificationMeta(
    'feedback',
  );
  @override
  late final GeneratedColumn<String> feedback = GeneratedColumn<String>(
    'feedback',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    category,
    score,
    maxScore,
    status,
    feedback,
    completedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assessment_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<AssessmentScoreEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('max_score')) {
      context.handle(
        _maxScoreMeta,
        maxScore.isAcceptableOrUnknown(data['max_score']!, _maxScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_maxScoreMeta);
    }
    if (data.containsKey('feedback')) {
      context.handle(
        _feedbackMeta,
        feedback.isAcceptableOrUnknown(data['feedback']!, _feedbackMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {category},
  ];
  @override
  AssessmentScoreEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssessmentScoreEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      category: $AssessmentScoresTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      maxScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_score'],
      )!,
      status: $AssessmentScoresTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      feedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feedback'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AssessmentScoresTable createAlias(String alias) {
    return $AssessmentScoresTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AssessmentCategory, String, String>
  $convertercategory = const EnumNameConverter<AssessmentCategory>(
    AssessmentCategory.values,
  );
  static JsonTypeConverter2<PreparednessStatus, String, String>
  $converterstatus = const EnumNameConverter<PreparednessStatus>(
    PreparednessStatus.values,
  );
}

class AssessmentScoreEntry extends DataClass
    implements Insertable<AssessmentScoreEntry> {
  final int id;

  /// Stored as the enum's name (e.g. "deliveryPlan") for readability in
  /// raw SQL / DB inspection.
  final AssessmentCategory category;

  /// Raw points earned in this category.
  final int score;

  /// Max points possible for this category.
  final int maxScore;
  final PreparednessStatus status;

  /// Free-text personalized feedback shown on the results breakdown,
  /// e.g. "You have a primary transport plan, but no backup identified."
  final String feedback;
  final DateTime completedAt;
  final DateTime updatedAt;
  const AssessmentScoreEntry({
    required this.id,
    required this.category,
    required this.score,
    required this.maxScore,
    required this.status,
    required this.feedback,
    required this.completedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['category'] = Variable<String>(
        $AssessmentScoresTable.$convertercategory.toSql(category),
      );
    }
    map['score'] = Variable<int>(score);
    map['max_score'] = Variable<int>(maxScore);
    {
      map['status'] = Variable<String>(
        $AssessmentScoresTable.$converterstatus.toSql(status),
      );
    }
    map['feedback'] = Variable<String>(feedback);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AssessmentScoresCompanion toCompanion(bool nullToAbsent) {
    return AssessmentScoresCompanion(
      id: Value(id),
      category: Value(category),
      score: Value(score),
      maxScore: Value(maxScore),
      status: Value(status),
      feedback: Value(feedback),
      completedAt: Value(completedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AssessmentScoreEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssessmentScoreEntry(
      id: serializer.fromJson<int>(json['id']),
      category: $AssessmentScoresTable.$convertercategory.fromJson(
        serializer.fromJson<String>(json['category']),
      ),
      score: serializer.fromJson<int>(json['score']),
      maxScore: serializer.fromJson<int>(json['maxScore']),
      status: $AssessmentScoresTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      feedback: serializer.fromJson<String>(json['feedback']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(
        $AssessmentScoresTable.$convertercategory.toJson(category),
      ),
      'score': serializer.toJson<int>(score),
      'maxScore': serializer.toJson<int>(maxScore),
      'status': serializer.toJson<String>(
        $AssessmentScoresTable.$converterstatus.toJson(status),
      ),
      'feedback': serializer.toJson<String>(feedback),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AssessmentScoreEntry copyWith({
    int? id,
    AssessmentCategory? category,
    int? score,
    int? maxScore,
    PreparednessStatus? status,
    String? feedback,
    DateTime? completedAt,
    DateTime? updatedAt,
  }) => AssessmentScoreEntry(
    id: id ?? this.id,
    category: category ?? this.category,
    score: score ?? this.score,
    maxScore: maxScore ?? this.maxScore,
    status: status ?? this.status,
    feedback: feedback ?? this.feedback,
    completedAt: completedAt ?? this.completedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AssessmentScoreEntry copyWithCompanion(AssessmentScoresCompanion data) {
    return AssessmentScoreEntry(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      score: data.score.present ? data.score.value : this.score,
      maxScore: data.maxScore.present ? data.maxScore.value : this.maxScore,
      status: data.status.present ? data.status.value : this.status,
      feedback: data.feedback.present ? data.feedback.value : this.feedback,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssessmentScoreEntry(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('score: $score, ')
          ..write('maxScore: $maxScore, ')
          ..write('status: $status, ')
          ..write('feedback: $feedback, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    category,
    score,
    maxScore,
    status,
    feedback,
    completedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssessmentScoreEntry &&
          other.id == this.id &&
          other.category == this.category &&
          other.score == this.score &&
          other.maxScore == this.maxScore &&
          other.status == this.status &&
          other.feedback == this.feedback &&
          other.completedAt == this.completedAt &&
          other.updatedAt == this.updatedAt);
}

class AssessmentScoresCompanion extends UpdateCompanion<AssessmentScoreEntry> {
  final Value<int> id;
  final Value<AssessmentCategory> category;
  final Value<int> score;
  final Value<int> maxScore;
  final Value<PreparednessStatus> status;
  final Value<String> feedback;
  final Value<DateTime> completedAt;
  final Value<DateTime> updatedAt;
  const AssessmentScoresCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.score = const Value.absent(),
    this.maxScore = const Value.absent(),
    this.status = const Value.absent(),
    this.feedback = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AssessmentScoresCompanion.insert({
    this.id = const Value.absent(),
    required AssessmentCategory category,
    required int score,
    required int maxScore,
    required PreparednessStatus status,
    this.feedback = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : category = Value(category),
       score = Value(score),
       maxScore = Value(maxScore),
       status = Value(status);
  static Insertable<AssessmentScoreEntry> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<int>? score,
    Expression<int>? maxScore,
    Expression<String>? status,
    Expression<String>? feedback,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (score != null) 'score': score,
      if (maxScore != null) 'max_score': maxScore,
      if (status != null) 'status': status,
      if (feedback != null) 'feedback': feedback,
      if (completedAt != null) 'completed_at': completedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AssessmentScoresCompanion copyWith({
    Value<int>? id,
    Value<AssessmentCategory>? category,
    Value<int>? score,
    Value<int>? maxScore,
    Value<PreparednessStatus>? status,
    Value<String>? feedback,
    Value<DateTime>? completedAt,
    Value<DateTime>? updatedAt,
  }) {
    return AssessmentScoresCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      score: score ?? this.score,
      maxScore: maxScore ?? this.maxScore,
      status: status ?? this.status,
      feedback: feedback ?? this.feedback,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $AssessmentScoresTable.$convertercategory.toSql(category.value),
      );
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (maxScore.present) {
      map['max_score'] = Variable<int>(maxScore.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $AssessmentScoresTable.$converterstatus.toSql(status.value),
      );
    }
    if (feedback.present) {
      map['feedback'] = Variable<String>(feedback.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssessmentScoresCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('score: $score, ')
          ..write('maxScore: $maxScore, ')
          ..write('status: $status, ')
          ..write('feedback: $feedback, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChecklistItemsTable extends ChecklistItems
    with TableInfo<$ChecklistItemsTable, ChecklistItemEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ChecklistOwner, String> owner =
      GeneratedColumn<String>(
        'owner',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ChecklistOwner>($ChecklistItemsTable.$converterowner);
  @override
  late final GeneratedColumnWithTypeConverter<DeliveryMode, String>
  deliveryMode = GeneratedColumn<String>(
    'delivery_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('both'),
  ).withConverter<DeliveryMode>($ChecklistItemsTable.$converterdeliveryMode);
  static const VerificationMeta _isCheckedMeta = const VerificationMeta(
    'isChecked',
  );
  @override
  late final GeneratedColumn<bool> isChecked = GeneratedColumn<bool>(
    'is_checked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_checked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isCustomMeta = const VerificationMeta(
    'isCustom',
  );
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
    'is_custom',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_custom" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    owner,
    deliveryMode,
    isChecked,
    isCustom,
    iconKey,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecklistItemEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_checked')) {
      context.handle(
        _isCheckedMeta,
        isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta),
      );
    }
    if (data.containsKey('is_custom')) {
      context.handle(
        _isCustomMeta,
        isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta),
      );
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistItemEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistItemEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      owner: $ChecklistItemsTable.$converterowner.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}owner'],
        )!,
      ),
      deliveryMode: $ChecklistItemsTable.$converterdeliveryMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}delivery_mode'],
        )!,
      ),
      isChecked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_checked'],
      )!,
      isCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_custom'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ChecklistItemsTable createAlias(String alias) {
    return $ChecklistItemsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ChecklistOwner, String, String> $converterowner =
      const EnumNameConverter<ChecklistOwner>(ChecklistOwner.values);
  static JsonTypeConverter2<DeliveryMode, String, String>
  $converterdeliveryMode = const EnumNameConverter<DeliveryMode>(
    DeliveryMode.values,
  );
}

class ChecklistItemEntry extends DataClass
    implements Insertable<ChecklistItemEntry> {
  final int id;
  final String name;
  final ChecklistOwner owner;
  final DeliveryMode deliveryMode;
  final bool isChecked;

  /// True if the user added this item via the "add custom item" modal,
  /// false if it came from the default seeded checklist.
  final bool isCustom;

  /// Optional icon/asset key so the UI can pair text with a visual
  /// (low-literacy accessibility requirement).
  final String? iconKey;
  final int sortOrder;
  final DateTime createdAt;
  const ChecklistItemEntry({
    required this.id,
    required this.name,
    required this.owner,
    required this.deliveryMode,
    required this.isChecked,
    required this.isCustom,
    this.iconKey,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['owner'] = Variable<String>(
        $ChecklistItemsTable.$converterowner.toSql(owner),
      );
    }
    {
      map['delivery_mode'] = Variable<String>(
        $ChecklistItemsTable.$converterdeliveryMode.toSql(deliveryMode),
      );
    }
    map['is_checked'] = Variable<bool>(isChecked);
    map['is_custom'] = Variable<bool>(isCustom);
    if (!nullToAbsent || iconKey != null) {
      map['icon_key'] = Variable<String>(iconKey);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ChecklistItemsCompanion toCompanion(bool nullToAbsent) {
    return ChecklistItemsCompanion(
      id: Value(id),
      name: Value(name),
      owner: Value(owner),
      deliveryMode: Value(deliveryMode),
      isChecked: Value(isChecked),
      isCustom: Value(isCustom),
      iconKey: iconKey == null && nullToAbsent
          ? const Value.absent()
          : Value(iconKey),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory ChecklistItemEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistItemEntry(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      owner: $ChecklistItemsTable.$converterowner.fromJson(
        serializer.fromJson<String>(json['owner']),
      ),
      deliveryMode: $ChecklistItemsTable.$converterdeliveryMode.fromJson(
        serializer.fromJson<String>(json['deliveryMode']),
      ),
      isChecked: serializer.fromJson<bool>(json['isChecked']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      iconKey: serializer.fromJson<String?>(json['iconKey']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'owner': serializer.toJson<String>(
        $ChecklistItemsTable.$converterowner.toJson(owner),
      ),
      'deliveryMode': serializer.toJson<String>(
        $ChecklistItemsTable.$converterdeliveryMode.toJson(deliveryMode),
      ),
      'isChecked': serializer.toJson<bool>(isChecked),
      'isCustom': serializer.toJson<bool>(isCustom),
      'iconKey': serializer.toJson<String?>(iconKey),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ChecklistItemEntry copyWith({
    int? id,
    String? name,
    ChecklistOwner? owner,
    DeliveryMode? deliveryMode,
    bool? isChecked,
    bool? isCustom,
    Value<String?> iconKey = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
  }) => ChecklistItemEntry(
    id: id ?? this.id,
    name: name ?? this.name,
    owner: owner ?? this.owner,
    deliveryMode: deliveryMode ?? this.deliveryMode,
    isChecked: isChecked ?? this.isChecked,
    isCustom: isCustom ?? this.isCustom,
    iconKey: iconKey.present ? iconKey.value : this.iconKey,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  ChecklistItemEntry copyWithCompanion(ChecklistItemsCompanion data) {
    return ChecklistItemEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      owner: data.owner.present ? data.owner.value : this.owner,
      deliveryMode: data.deliveryMode.present
          ? data.deliveryMode.value
          : this.deliveryMode,
      isChecked: data.isChecked.present ? data.isChecked.value : this.isChecked,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistItemEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('owner: $owner, ')
          ..write('deliveryMode: $deliveryMode, ')
          ..write('isChecked: $isChecked, ')
          ..write('isCustom: $isCustom, ')
          ..write('iconKey: $iconKey, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    owner,
    deliveryMode,
    isChecked,
    isCustom,
    iconKey,
    sortOrder,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistItemEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.owner == this.owner &&
          other.deliveryMode == this.deliveryMode &&
          other.isChecked == this.isChecked &&
          other.isCustom == this.isCustom &&
          other.iconKey == this.iconKey &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class ChecklistItemsCompanion extends UpdateCompanion<ChecklistItemEntry> {
  final Value<int> id;
  final Value<String> name;
  final Value<ChecklistOwner> owner;
  final Value<DeliveryMode> deliveryMode;
  final Value<bool> isChecked;
  final Value<bool> isCustom;
  final Value<String?> iconKey;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const ChecklistItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.owner = const Value.absent(),
    this.deliveryMode = const Value.absent(),
    this.isChecked = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ChecklistItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required ChecklistOwner owner,
    this.deliveryMode = const Value.absent(),
    this.isChecked = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       owner = Value(owner);
  static Insertable<ChecklistItemEntry> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? owner,
    Expression<String>? deliveryMode,
    Expression<bool>? isChecked,
    Expression<bool>? isCustom,
    Expression<String>? iconKey,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (owner != null) 'owner': owner,
      if (deliveryMode != null) 'delivery_mode': deliveryMode,
      if (isChecked != null) 'is_checked': isChecked,
      if (isCustom != null) 'is_custom': isCustom,
      if (iconKey != null) 'icon_key': iconKey,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ChecklistItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<ChecklistOwner>? owner,
    Value<DeliveryMode>? deliveryMode,
    Value<bool>? isChecked,
    Value<bool>? isCustom,
    Value<String?>? iconKey,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return ChecklistItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      owner: owner ?? this.owner,
      deliveryMode: deliveryMode ?? this.deliveryMode,
      isChecked: isChecked ?? this.isChecked,
      isCustom: isCustom ?? this.isCustom,
      iconKey: iconKey ?? this.iconKey,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String>(
        $ChecklistItemsTable.$converterowner.toSql(owner.value),
      );
    }
    if (deliveryMode.present) {
      map['delivery_mode'] = Variable<String>(
        $ChecklistItemsTable.$converterdeliveryMode.toSql(deliveryMode.value),
      );
    }
    if (isChecked.present) {
      map['is_checked'] = Variable<bool>(isChecked.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('owner: $owner, ')
          ..write('deliveryMode: $deliveryMode, ')
          ..write('isChecked: $isChecked, ')
          ..write('isCustom: $isCustom, ')
          ..write('iconKey: $iconKey, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DangerSignsScreeningsTable extends DangerSignsScreenings
    with TableInfo<$DangerSignsScreeningsTable, DangerSignsScreeningEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DangerSignsScreeningsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _isDangerDetectedMeta = const VerificationMeta(
    'isDangerDetected',
  );
  @override
  late final GeneratedColumn<bool> isDangerDetected = GeneratedColumn<bool>(
    'is_danger_detected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_danger_detected" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _triggeringQuestionIdsMeta =
      const VerificationMeta('triggeringQuestionIds');
  @override
  late final GeneratedColumn<String> triggeringQuestionIds =
      GeneratedColumn<String>(
        'triggering_question_ids',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    isDangerDetected,
    triggeringQuestionIds,
    completedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'danger_signs_screenings';
  @override
  VerificationContext validateIntegrity(
    Insertable<DangerSignsScreeningEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_danger_detected')) {
      context.handle(
        _isDangerDetectedMeta,
        isDangerDetected.isAcceptableOrUnknown(
          data['is_danger_detected']!,
          _isDangerDetectedMeta,
        ),
      );
    }
    if (data.containsKey('triggering_question_ids')) {
      context.handle(
        _triggeringQuestionIdsMeta,
        triggeringQuestionIds.isAcceptableOrUnknown(
          data['triggering_question_ids']!,
          _triggeringQuestionIdsMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DangerSignsScreeningEntry map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DangerSignsScreeningEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      isDangerDetected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_danger_detected'],
      )!,
      triggeringQuestionIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}triggering_question_ids'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DangerSignsScreeningsTable createAlias(String alias) {
    return $DangerSignsScreeningsTable(attachedDatabase, alias);
  }
}

class DangerSignsScreeningEntry extends DataClass
    implements Insertable<DangerSignsScreeningEntry> {
  final int id;
  final bool isDangerDetected;

  /// Question ids of the danger-sign questions whose danger option (rank 1)
  /// was selected. Stored as a single comma-separated text column: a proper
  /// join table would be overkill for one boolean screener result, and this
  /// keeps the row trivially inspectable in raw SQL.
  final String? triggeringQuestionIds;
  final DateTime completedAt;
  final DateTime updatedAt;
  const DangerSignsScreeningEntry({
    required this.id,
    required this.isDangerDetected,
    this.triggeringQuestionIds,
    required this.completedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_danger_detected'] = Variable<bool>(isDangerDetected);
    if (!nullToAbsent || triggeringQuestionIds != null) {
      map['triggering_question_ids'] = Variable<String>(triggeringQuestionIds);
    }
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DangerSignsScreeningsCompanion toCompanion(bool nullToAbsent) {
    return DangerSignsScreeningsCompanion(
      id: Value(id),
      isDangerDetected: Value(isDangerDetected),
      triggeringQuestionIds: triggeringQuestionIds == null && nullToAbsent
          ? const Value.absent()
          : Value(triggeringQuestionIds),
      completedAt: Value(completedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DangerSignsScreeningEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DangerSignsScreeningEntry(
      id: serializer.fromJson<int>(json['id']),
      isDangerDetected: serializer.fromJson<bool>(json['isDangerDetected']),
      triggeringQuestionIds: serializer.fromJson<String?>(
        json['triggeringQuestionIds'],
      ),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isDangerDetected': serializer.toJson<bool>(isDangerDetected),
      'triggeringQuestionIds': serializer.toJson<String?>(
        triggeringQuestionIds,
      ),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DangerSignsScreeningEntry copyWith({
    int? id,
    bool? isDangerDetected,
    Value<String?> triggeringQuestionIds = const Value.absent(),
    DateTime? completedAt,
    DateTime? updatedAt,
  }) => DangerSignsScreeningEntry(
    id: id ?? this.id,
    isDangerDetected: isDangerDetected ?? this.isDangerDetected,
    triggeringQuestionIds: triggeringQuestionIds.present
        ? triggeringQuestionIds.value
        : this.triggeringQuestionIds,
    completedAt: completedAt ?? this.completedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DangerSignsScreeningEntry copyWithCompanion(
    DangerSignsScreeningsCompanion data,
  ) {
    return DangerSignsScreeningEntry(
      id: data.id.present ? data.id.value : this.id,
      isDangerDetected: data.isDangerDetected.present
          ? data.isDangerDetected.value
          : this.isDangerDetected,
      triggeringQuestionIds: data.triggeringQuestionIds.present
          ? data.triggeringQuestionIds.value
          : this.triggeringQuestionIds,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DangerSignsScreeningEntry(')
          ..write('id: $id, ')
          ..write('isDangerDetected: $isDangerDetected, ')
          ..write('triggeringQuestionIds: $triggeringQuestionIds, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    isDangerDetected,
    triggeringQuestionIds,
    completedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DangerSignsScreeningEntry &&
          other.id == this.id &&
          other.isDangerDetected == this.isDangerDetected &&
          other.triggeringQuestionIds == this.triggeringQuestionIds &&
          other.completedAt == this.completedAt &&
          other.updatedAt == this.updatedAt);
}

class DangerSignsScreeningsCompanion
    extends UpdateCompanion<DangerSignsScreeningEntry> {
  final Value<int> id;
  final Value<bool> isDangerDetected;
  final Value<String?> triggeringQuestionIds;
  final Value<DateTime> completedAt;
  final Value<DateTime> updatedAt;
  const DangerSignsScreeningsCompanion({
    this.id = const Value.absent(),
    this.isDangerDetected = const Value.absent(),
    this.triggeringQuestionIds = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DangerSignsScreeningsCompanion.insert({
    this.id = const Value.absent(),
    this.isDangerDetected = const Value.absent(),
    this.triggeringQuestionIds = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<DangerSignsScreeningEntry> custom({
    Expression<int>? id,
    Expression<bool>? isDangerDetected,
    Expression<String>? triggeringQuestionIds,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isDangerDetected != null) 'is_danger_detected': isDangerDetected,
      if (triggeringQuestionIds != null)
        'triggering_question_ids': triggeringQuestionIds,
      if (completedAt != null) 'completed_at': completedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DangerSignsScreeningsCompanion copyWith({
    Value<int>? id,
    Value<bool>? isDangerDetected,
    Value<String?>? triggeringQuestionIds,
    Value<DateTime>? completedAt,
    Value<DateTime>? updatedAt,
  }) {
    return DangerSignsScreeningsCompanion(
      id: id ?? this.id,
      isDangerDetected: isDangerDetected ?? this.isDangerDetected,
      triggeringQuestionIds:
          triggeringQuestionIds ?? this.triggeringQuestionIds,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isDangerDetected.present) {
      map['is_danger_detected'] = Variable<bool>(isDangerDetected.value);
    }
    if (triggeringQuestionIds.present) {
      map['triggering_question_ids'] = Variable<String>(
        triggeringQuestionIds.value,
      );
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DangerSignsScreeningsCompanion(')
          ..write('id: $id, ')
          ..write('isDangerDetected: $isDangerDetected, ')
          ..write('triggeringQuestionIds: $triggeringQuestionIds, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DeliveryPlanRecordsTable extends DeliveryPlanRecords
    with TableInfo<$DeliveryPlanRecordsTable, DeliveryPlanRecordEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeliveryPlanRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _preferredFacilityMeta = const VerificationMeta(
    'preferredFacility',
  );
  @override
  late final GeneratedColumn<String> preferredFacility =
      GeneratedColumn<String>(
        'preferred_facility',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _primaryTransportMeta = const VerificationMeta(
    'primaryTransport',
  );
  @override
  late final GeneratedColumn<String> primaryTransport = GeneratedColumn<String>(
    'primary_transport',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accompaniedByMeta = const VerificationMeta(
    'accompaniedBy',
  );
  @override
  late final GeneratedColumn<String> accompaniedBy = GeneratedColumn<String>(
    'accompanied_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _discussedWithSupportPersonMeta =
      const VerificationMeta('discussedWithSupportPerson');
  @override
  late final GeneratedColumn<bool> discussedWithSupportPerson =
      GeneratedColumn<bool>(
        'discussed_with_support_person',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("discussed_with_support_person" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _backupPlanNotesMeta = const VerificationMeta(
    'backupPlanNotes',
  );
  @override
  late final GeneratedColumn<String> backupPlanNotes = GeneratedColumn<String>(
    'backup_plan_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    preferredFacility,
    primaryTransport,
    accompaniedBy,
    discussedWithSupportPerson,
    backupPlanNotes,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'delivery_plan_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeliveryPlanRecordEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('preferred_facility')) {
      context.handle(
        _preferredFacilityMeta,
        preferredFacility.isAcceptableOrUnknown(
          data['preferred_facility']!,
          _preferredFacilityMeta,
        ),
      );
    }
    if (data.containsKey('primary_transport')) {
      context.handle(
        _primaryTransportMeta,
        primaryTransport.isAcceptableOrUnknown(
          data['primary_transport']!,
          _primaryTransportMeta,
        ),
      );
    }
    if (data.containsKey('accompanied_by')) {
      context.handle(
        _accompaniedByMeta,
        accompaniedBy.isAcceptableOrUnknown(
          data['accompanied_by']!,
          _accompaniedByMeta,
        ),
      );
    }
    if (data.containsKey('discussed_with_support_person')) {
      context.handle(
        _discussedWithSupportPersonMeta,
        discussedWithSupportPerson.isAcceptableOrUnknown(
          data['discussed_with_support_person']!,
          _discussedWithSupportPersonMeta,
        ),
      );
    }
    if (data.containsKey('backup_plan_notes')) {
      context.handle(
        _backupPlanNotesMeta,
        backupPlanNotes.isAcceptableOrUnknown(
          data['backup_plan_notes']!,
          _backupPlanNotesMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeliveryPlanRecordEntry map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeliveryPlanRecordEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      preferredFacility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_facility'],
      ),
      primaryTransport: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_transport'],
      ),
      accompaniedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accompanied_by'],
      ),
      discussedWithSupportPerson: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}discussed_with_support_person'],
      )!,
      backupPlanNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backup_plan_notes'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DeliveryPlanRecordsTable createAlias(String alias) {
    return $DeliveryPlanRecordsTable(attachedDatabase, alias);
  }
}

class DeliveryPlanRecordEntry extends DataClass
    implements Insertable<DeliveryPlanRecordEntry> {
  final int id;
  final String? preferredFacility;
  final String? primaryTransport;
  final String? accompaniedBy;
  final bool discussedWithSupportPerson;
  final String? backupPlanNotes;
  final DateTime updatedAt;
  const DeliveryPlanRecordEntry({
    required this.id,
    this.preferredFacility,
    this.primaryTransport,
    this.accompaniedBy,
    required this.discussedWithSupportPerson,
    this.backupPlanNotes,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || preferredFacility != null) {
      map['preferred_facility'] = Variable<String>(preferredFacility);
    }
    if (!nullToAbsent || primaryTransport != null) {
      map['primary_transport'] = Variable<String>(primaryTransport);
    }
    if (!nullToAbsent || accompaniedBy != null) {
      map['accompanied_by'] = Variable<String>(accompaniedBy);
    }
    map['discussed_with_support_person'] = Variable<bool>(
      discussedWithSupportPerson,
    );
    if (!nullToAbsent || backupPlanNotes != null) {
      map['backup_plan_notes'] = Variable<String>(backupPlanNotes);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DeliveryPlanRecordsCompanion toCompanion(bool nullToAbsent) {
    return DeliveryPlanRecordsCompanion(
      id: Value(id),
      preferredFacility: preferredFacility == null && nullToAbsent
          ? const Value.absent()
          : Value(preferredFacility),
      primaryTransport: primaryTransport == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryTransport),
      accompaniedBy: accompaniedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(accompaniedBy),
      discussedWithSupportPerson: Value(discussedWithSupportPerson),
      backupPlanNotes: backupPlanNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(backupPlanNotes),
      updatedAt: Value(updatedAt),
    );
  }

  factory DeliveryPlanRecordEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeliveryPlanRecordEntry(
      id: serializer.fromJson<int>(json['id']),
      preferredFacility: serializer.fromJson<String?>(
        json['preferredFacility'],
      ),
      primaryTransport: serializer.fromJson<String?>(json['primaryTransport']),
      accompaniedBy: serializer.fromJson<String?>(json['accompaniedBy']),
      discussedWithSupportPerson: serializer.fromJson<bool>(
        json['discussedWithSupportPerson'],
      ),
      backupPlanNotes: serializer.fromJson<String?>(json['backupPlanNotes']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'preferredFacility': serializer.toJson<String?>(preferredFacility),
      'primaryTransport': serializer.toJson<String?>(primaryTransport),
      'accompaniedBy': serializer.toJson<String?>(accompaniedBy),
      'discussedWithSupportPerson': serializer.toJson<bool>(
        discussedWithSupportPerson,
      ),
      'backupPlanNotes': serializer.toJson<String?>(backupPlanNotes),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DeliveryPlanRecordEntry copyWith({
    int? id,
    Value<String?> preferredFacility = const Value.absent(),
    Value<String?> primaryTransport = const Value.absent(),
    Value<String?> accompaniedBy = const Value.absent(),
    bool? discussedWithSupportPerson,
    Value<String?> backupPlanNotes = const Value.absent(),
    DateTime? updatedAt,
  }) => DeliveryPlanRecordEntry(
    id: id ?? this.id,
    preferredFacility: preferredFacility.present
        ? preferredFacility.value
        : this.preferredFacility,
    primaryTransport: primaryTransport.present
        ? primaryTransport.value
        : this.primaryTransport,
    accompaniedBy: accompaniedBy.present
        ? accompaniedBy.value
        : this.accompaniedBy,
    discussedWithSupportPerson:
        discussedWithSupportPerson ?? this.discussedWithSupportPerson,
    backupPlanNotes: backupPlanNotes.present
        ? backupPlanNotes.value
        : this.backupPlanNotes,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DeliveryPlanRecordEntry copyWithCompanion(DeliveryPlanRecordsCompanion data) {
    return DeliveryPlanRecordEntry(
      id: data.id.present ? data.id.value : this.id,
      preferredFacility: data.preferredFacility.present
          ? data.preferredFacility.value
          : this.preferredFacility,
      primaryTransport: data.primaryTransport.present
          ? data.primaryTransport.value
          : this.primaryTransport,
      accompaniedBy: data.accompaniedBy.present
          ? data.accompaniedBy.value
          : this.accompaniedBy,
      discussedWithSupportPerson: data.discussedWithSupportPerson.present
          ? data.discussedWithSupportPerson.value
          : this.discussedWithSupportPerson,
      backupPlanNotes: data.backupPlanNotes.present
          ? data.backupPlanNotes.value
          : this.backupPlanNotes,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryPlanRecordEntry(')
          ..write('id: $id, ')
          ..write('preferredFacility: $preferredFacility, ')
          ..write('primaryTransport: $primaryTransport, ')
          ..write('accompaniedBy: $accompaniedBy, ')
          ..write('discussedWithSupportPerson: $discussedWithSupportPerson, ')
          ..write('backupPlanNotes: $backupPlanNotes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    preferredFacility,
    primaryTransport,
    accompaniedBy,
    discussedWithSupportPerson,
    backupPlanNotes,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeliveryPlanRecordEntry &&
          other.id == this.id &&
          other.preferredFacility == this.preferredFacility &&
          other.primaryTransport == this.primaryTransport &&
          other.accompaniedBy == this.accompaniedBy &&
          other.discussedWithSupportPerson == this.discussedWithSupportPerson &&
          other.backupPlanNotes == this.backupPlanNotes &&
          other.updatedAt == this.updatedAt);
}

class DeliveryPlanRecordsCompanion
    extends UpdateCompanion<DeliveryPlanRecordEntry> {
  final Value<int> id;
  final Value<String?> preferredFacility;
  final Value<String?> primaryTransport;
  final Value<String?> accompaniedBy;
  final Value<bool> discussedWithSupportPerson;
  final Value<String?> backupPlanNotes;
  final Value<DateTime> updatedAt;
  const DeliveryPlanRecordsCompanion({
    this.id = const Value.absent(),
    this.preferredFacility = const Value.absent(),
    this.primaryTransport = const Value.absent(),
    this.accompaniedBy = const Value.absent(),
    this.discussedWithSupportPerson = const Value.absent(),
    this.backupPlanNotes = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DeliveryPlanRecordsCompanion.insert({
    this.id = const Value.absent(),
    this.preferredFacility = const Value.absent(),
    this.primaryTransport = const Value.absent(),
    this.accompaniedBy = const Value.absent(),
    this.discussedWithSupportPerson = const Value.absent(),
    this.backupPlanNotes = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<DeliveryPlanRecordEntry> custom({
    Expression<int>? id,
    Expression<String>? preferredFacility,
    Expression<String>? primaryTransport,
    Expression<String>? accompaniedBy,
    Expression<bool>? discussedWithSupportPerson,
    Expression<String>? backupPlanNotes,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (preferredFacility != null) 'preferred_facility': preferredFacility,
      if (primaryTransport != null) 'primary_transport': primaryTransport,
      if (accompaniedBy != null) 'accompanied_by': accompaniedBy,
      if (discussedWithSupportPerson != null)
        'discussed_with_support_person': discussedWithSupportPerson,
      if (backupPlanNotes != null) 'backup_plan_notes': backupPlanNotes,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DeliveryPlanRecordsCompanion copyWith({
    Value<int>? id,
    Value<String?>? preferredFacility,
    Value<String?>? primaryTransport,
    Value<String?>? accompaniedBy,
    Value<bool>? discussedWithSupportPerson,
    Value<String?>? backupPlanNotes,
    Value<DateTime>? updatedAt,
  }) {
    return DeliveryPlanRecordsCompanion(
      id: id ?? this.id,
      preferredFacility: preferredFacility ?? this.preferredFacility,
      primaryTransport: primaryTransport ?? this.primaryTransport,
      accompaniedBy: accompaniedBy ?? this.accompaniedBy,
      discussedWithSupportPerson:
          discussedWithSupportPerson ?? this.discussedWithSupportPerson,
      backupPlanNotes: backupPlanNotes ?? this.backupPlanNotes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (preferredFacility.present) {
      map['preferred_facility'] = Variable<String>(preferredFacility.value);
    }
    if (primaryTransport.present) {
      map['primary_transport'] = Variable<String>(primaryTransport.value);
    }
    if (accompaniedBy.present) {
      map['accompanied_by'] = Variable<String>(accompaniedBy.value);
    }
    if (discussedWithSupportPerson.present) {
      map['discussed_with_support_person'] = Variable<bool>(
        discussedWithSupportPerson.value,
      );
    }
    if (backupPlanNotes.present) {
      map['backup_plan_notes'] = Variable<String>(backupPlanNotes.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryPlanRecordsCompanion(')
          ..write('id: $id, ')
          ..write('preferredFacility: $preferredFacility, ')
          ..write('primaryTransport: $primaryTransport, ')
          ..write('accompaniedBy: $accompaniedBy, ')
          ..write('discussedWithSupportPerson: $discussedWithSupportPerson, ')
          ..write('backupPlanNotes: $backupPlanNotes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SupportPersonRecordsTable extends SupportPersonRecords
    with TableInfo<$SupportPersonRecordsTable, SupportPersonRecordEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupportPersonRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relationshipMeta = const VerificationMeta(
    'relationship',
  );
  @override
  late final GeneratedColumn<String> relationship = GeneratedColumn<String>(
    'relationship',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactNumberMeta = const VerificationMeta(
    'contactNumber',
  );
  @override
  late final GeneratedColumn<String> contactNumber = GeneratedColumn<String>(
    'contact_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alternateContactNameMeta =
      const VerificationMeta('alternateContactName');
  @override
  late final GeneratedColumn<String> alternateContactName =
      GeneratedColumn<String>(
        'alternate_contact_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _alternateContactNumberMeta =
      const VerificationMeta('alternateContactNumber');
  @override
  late final GeneratedColumn<String> alternateContactNumber =
      GeneratedColumn<String>(
        'alternate_contact_number',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fullName,
    relationship,
    contactNumber,
    address,
    alternateContactName,
    alternateContactNumber,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'support_person_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupportPersonRecordEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    }
    if (data.containsKey('relationship')) {
      context.handle(
        _relationshipMeta,
        relationship.isAcceptableOrUnknown(
          data['relationship']!,
          _relationshipMeta,
        ),
      );
    }
    if (data.containsKey('contact_number')) {
      context.handle(
        _contactNumberMeta,
        contactNumber.isAcceptableOrUnknown(
          data['contact_number']!,
          _contactNumberMeta,
        ),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('alternate_contact_name')) {
      context.handle(
        _alternateContactNameMeta,
        alternateContactName.isAcceptableOrUnknown(
          data['alternate_contact_name']!,
          _alternateContactNameMeta,
        ),
      );
    }
    if (data.containsKey('alternate_contact_number')) {
      context.handle(
        _alternateContactNumberMeta,
        alternateContactNumber.isAcceptableOrUnknown(
          data['alternate_contact_number']!,
          _alternateContactNumberMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupportPersonRecordEntry map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupportPersonRecordEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      ),
      relationship: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relationship'],
      ),
      contactNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_number'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      alternateContactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alternate_contact_name'],
      ),
      alternateContactNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alternate_contact_number'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SupportPersonRecordsTable createAlias(String alias) {
    return $SupportPersonRecordsTable(attachedDatabase, alias);
  }
}

class SupportPersonRecordEntry extends DataClass
    implements Insertable<SupportPersonRecordEntry> {
  final int id;
  final String? fullName;
  final String? relationship;
  final String? contactNumber;
  final String? address;
  final String? alternateContactName;
  final String? alternateContactNumber;
  final DateTime updatedAt;
  const SupportPersonRecordEntry({
    required this.id,
    this.fullName,
    this.relationship,
    this.contactNumber,
    this.address,
    this.alternateContactName,
    this.alternateContactNumber,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || fullName != null) {
      map['full_name'] = Variable<String>(fullName);
    }
    if (!nullToAbsent || relationship != null) {
      map['relationship'] = Variable<String>(relationship);
    }
    if (!nullToAbsent || contactNumber != null) {
      map['contact_number'] = Variable<String>(contactNumber);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || alternateContactName != null) {
      map['alternate_contact_name'] = Variable<String>(alternateContactName);
    }
    if (!nullToAbsent || alternateContactNumber != null) {
      map['alternate_contact_number'] = Variable<String>(
        alternateContactNumber,
      );
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SupportPersonRecordsCompanion toCompanion(bool nullToAbsent) {
    return SupportPersonRecordsCompanion(
      id: Value(id),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      relationship: relationship == null && nullToAbsent
          ? const Value.absent()
          : Value(relationship),
      contactNumber: contactNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(contactNumber),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      alternateContactName: alternateContactName == null && nullToAbsent
          ? const Value.absent()
          : Value(alternateContactName),
      alternateContactNumber: alternateContactNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(alternateContactNumber),
      updatedAt: Value(updatedAt),
    );
  }

  factory SupportPersonRecordEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupportPersonRecordEntry(
      id: serializer.fromJson<int>(json['id']),
      fullName: serializer.fromJson<String?>(json['fullName']),
      relationship: serializer.fromJson<String?>(json['relationship']),
      contactNumber: serializer.fromJson<String?>(json['contactNumber']),
      address: serializer.fromJson<String?>(json['address']),
      alternateContactName: serializer.fromJson<String?>(
        json['alternateContactName'],
      ),
      alternateContactNumber: serializer.fromJson<String?>(
        json['alternateContactNumber'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fullName': serializer.toJson<String?>(fullName),
      'relationship': serializer.toJson<String?>(relationship),
      'contactNumber': serializer.toJson<String?>(contactNumber),
      'address': serializer.toJson<String?>(address),
      'alternateContactName': serializer.toJson<String?>(alternateContactName),
      'alternateContactNumber': serializer.toJson<String?>(
        alternateContactNumber,
      ),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SupportPersonRecordEntry copyWith({
    int? id,
    Value<String?> fullName = const Value.absent(),
    Value<String?> relationship = const Value.absent(),
    Value<String?> contactNumber = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> alternateContactName = const Value.absent(),
    Value<String?> alternateContactNumber = const Value.absent(),
    DateTime? updatedAt,
  }) => SupportPersonRecordEntry(
    id: id ?? this.id,
    fullName: fullName.present ? fullName.value : this.fullName,
    relationship: relationship.present ? relationship.value : this.relationship,
    contactNumber: contactNumber.present
        ? contactNumber.value
        : this.contactNumber,
    address: address.present ? address.value : this.address,
    alternateContactName: alternateContactName.present
        ? alternateContactName.value
        : this.alternateContactName,
    alternateContactNumber: alternateContactNumber.present
        ? alternateContactNumber.value
        : this.alternateContactNumber,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SupportPersonRecordEntry copyWithCompanion(
    SupportPersonRecordsCompanion data,
  ) {
    return SupportPersonRecordEntry(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      relationship: data.relationship.present
          ? data.relationship.value
          : this.relationship,
      contactNumber: data.contactNumber.present
          ? data.contactNumber.value
          : this.contactNumber,
      address: data.address.present ? data.address.value : this.address,
      alternateContactName: data.alternateContactName.present
          ? data.alternateContactName.value
          : this.alternateContactName,
      alternateContactNumber: data.alternateContactNumber.present
          ? data.alternateContactNumber.value
          : this.alternateContactNumber,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupportPersonRecordEntry(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('relationship: $relationship, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('address: $address, ')
          ..write('alternateContactName: $alternateContactName, ')
          ..write('alternateContactNumber: $alternateContactNumber, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fullName,
    relationship,
    contactNumber,
    address,
    alternateContactName,
    alternateContactNumber,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupportPersonRecordEntry &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.relationship == this.relationship &&
          other.contactNumber == this.contactNumber &&
          other.address == this.address &&
          other.alternateContactName == this.alternateContactName &&
          other.alternateContactNumber == this.alternateContactNumber &&
          other.updatedAt == this.updatedAt);
}

class SupportPersonRecordsCompanion
    extends UpdateCompanion<SupportPersonRecordEntry> {
  final Value<int> id;
  final Value<String?> fullName;
  final Value<String?> relationship;
  final Value<String?> contactNumber;
  final Value<String?> address;
  final Value<String?> alternateContactName;
  final Value<String?> alternateContactNumber;
  final Value<DateTime> updatedAt;
  const SupportPersonRecordsCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.relationship = const Value.absent(),
    this.contactNumber = const Value.absent(),
    this.address = const Value.absent(),
    this.alternateContactName = const Value.absent(),
    this.alternateContactNumber = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SupportPersonRecordsCompanion.insert({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.relationship = const Value.absent(),
    this.contactNumber = const Value.absent(),
    this.address = const Value.absent(),
    this.alternateContactName = const Value.absent(),
    this.alternateContactNumber = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<SupportPersonRecordEntry> custom({
    Expression<int>? id,
    Expression<String>? fullName,
    Expression<String>? relationship,
    Expression<String>? contactNumber,
    Expression<String>? address,
    Expression<String>? alternateContactName,
    Expression<String>? alternateContactNumber,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (relationship != null) 'relationship': relationship,
      if (contactNumber != null) 'contact_number': contactNumber,
      if (address != null) 'address': address,
      if (alternateContactName != null)
        'alternate_contact_name': alternateContactName,
      if (alternateContactNumber != null)
        'alternate_contact_number': alternateContactNumber,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SupportPersonRecordsCompanion copyWith({
    Value<int>? id,
    Value<String?>? fullName,
    Value<String?>? relationship,
    Value<String?>? contactNumber,
    Value<String?>? address,
    Value<String?>? alternateContactName,
    Value<String?>? alternateContactNumber,
    Value<DateTime>? updatedAt,
  }) {
    return SupportPersonRecordsCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      relationship: relationship ?? this.relationship,
      contactNumber: contactNumber ?? this.contactNumber,
      address: address ?? this.address,
      alternateContactName: alternateContactName ?? this.alternateContactName,
      alternateContactNumber:
          alternateContactNumber ?? this.alternateContactNumber,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (relationship.present) {
      map['relationship'] = Variable<String>(relationship.value);
    }
    if (contactNumber.present) {
      map['contact_number'] = Variable<String>(contactNumber.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (alternateContactName.present) {
      map['alternate_contact_name'] = Variable<String>(
        alternateContactName.value,
      );
    }
    if (alternateContactNumber.present) {
      map['alternate_contact_number'] = Variable<String>(
        alternateContactNumber.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupportPersonRecordsCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('relationship: $relationship, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('address: $address, ')
          ..write('alternateContactName: $alternateContactName, ')
          ..write('alternateContactNumber: $alternateContactNumber, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EmergencyPlanRecordsTable extends EmergencyPlanRecords
    with TableInfo<$EmergencyPlanRecordsTable, EmergencyPlanRecordEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmergencyPlanRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _primaryHospitalMeta = const VerificationMeta(
    'primaryHospital',
  );
  @override
  late final GeneratedColumn<String> primaryHospital = GeneratedColumn<String>(
    'primary_hospital',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _backupHospitalMeta = const VerificationMeta(
    'backupHospital',
  );
  @override
  late final GeneratedColumn<String> backupHospital = GeneratedColumn<String>(
    'backup_hospital',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _primaryTransportMeta = const VerificationMeta(
    'primaryTransport',
  );
  @override
  late final GeneratedColumn<String> primaryTransport = GeneratedColumn<String>(
    'primary_transport',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alternateTransportMeta =
      const VerificationMeta('alternateTransport');
  @override
  late final GeneratedColumn<String> alternateTransport =
      GeneratedColumn<String>(
        'alternate_transport',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _primaryRouteMeta = const VerificationMeta(
    'primaryRoute',
  );
  @override
  late final GeneratedColumn<String> primaryRoute = GeneratedColumn<String>(
    'primary_route',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alternateRouteMeta = const VerificationMeta(
    'alternateRoute',
  );
  @override
  late final GeneratedColumn<String> alternateRoute = GeneratedColumn<String>(
    'alternate_route',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _secondaryContactNameMeta =
      const VerificationMeta('secondaryContactName');
  @override
  late final GeneratedColumn<String> secondaryContactName =
      GeneratedColumn<String>(
        'secondary_contact_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _secondaryContactNumberMeta =
      const VerificationMeta('secondaryContactNumber');
  @override
  late final GeneratedColumn<String> secondaryContactNumber =
      GeneratedColumn<String>(
        'secondary_contact_number',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    primaryHospital,
    backupHospital,
    primaryTransport,
    alternateTransport,
    primaryRoute,
    alternateRoute,
    secondaryContactName,
    secondaryContactNumber,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emergency_plan_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmergencyPlanRecordEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('primary_hospital')) {
      context.handle(
        _primaryHospitalMeta,
        primaryHospital.isAcceptableOrUnknown(
          data['primary_hospital']!,
          _primaryHospitalMeta,
        ),
      );
    }
    if (data.containsKey('backup_hospital')) {
      context.handle(
        _backupHospitalMeta,
        backupHospital.isAcceptableOrUnknown(
          data['backup_hospital']!,
          _backupHospitalMeta,
        ),
      );
    }
    if (data.containsKey('primary_transport')) {
      context.handle(
        _primaryTransportMeta,
        primaryTransport.isAcceptableOrUnknown(
          data['primary_transport']!,
          _primaryTransportMeta,
        ),
      );
    }
    if (data.containsKey('alternate_transport')) {
      context.handle(
        _alternateTransportMeta,
        alternateTransport.isAcceptableOrUnknown(
          data['alternate_transport']!,
          _alternateTransportMeta,
        ),
      );
    }
    if (data.containsKey('primary_route')) {
      context.handle(
        _primaryRouteMeta,
        primaryRoute.isAcceptableOrUnknown(
          data['primary_route']!,
          _primaryRouteMeta,
        ),
      );
    }
    if (data.containsKey('alternate_route')) {
      context.handle(
        _alternateRouteMeta,
        alternateRoute.isAcceptableOrUnknown(
          data['alternate_route']!,
          _alternateRouteMeta,
        ),
      );
    }
    if (data.containsKey('secondary_contact_name')) {
      context.handle(
        _secondaryContactNameMeta,
        secondaryContactName.isAcceptableOrUnknown(
          data['secondary_contact_name']!,
          _secondaryContactNameMeta,
        ),
      );
    }
    if (data.containsKey('secondary_contact_number')) {
      context.handle(
        _secondaryContactNumberMeta,
        secondaryContactNumber.isAcceptableOrUnknown(
          data['secondary_contact_number']!,
          _secondaryContactNumberMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmergencyPlanRecordEntry map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmergencyPlanRecordEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      primaryHospital: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_hospital'],
      ),
      backupHospital: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backup_hospital'],
      ),
      primaryTransport: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_transport'],
      ),
      alternateTransport: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alternate_transport'],
      ),
      primaryRoute: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_route'],
      ),
      alternateRoute: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alternate_route'],
      ),
      secondaryContactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_contact_name'],
      ),
      secondaryContactNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_contact_number'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EmergencyPlanRecordsTable createAlias(String alias) {
    return $EmergencyPlanRecordsTable(attachedDatabase, alias);
  }
}

class EmergencyPlanRecordEntry extends DataClass
    implements Insertable<EmergencyPlanRecordEntry> {
  final int id;
  final String? primaryHospital;
  final String? backupHospital;
  final String? primaryTransport;
  final String? alternateTransport;
  final String? primaryRoute;
  final String? alternateRoute;
  final String? secondaryContactName;
  final String? secondaryContactNumber;
  final DateTime updatedAt;
  const EmergencyPlanRecordEntry({
    required this.id,
    this.primaryHospital,
    this.backupHospital,
    this.primaryTransport,
    this.alternateTransport,
    this.primaryRoute,
    this.alternateRoute,
    this.secondaryContactName,
    this.secondaryContactNumber,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || primaryHospital != null) {
      map['primary_hospital'] = Variable<String>(primaryHospital);
    }
    if (!nullToAbsent || backupHospital != null) {
      map['backup_hospital'] = Variable<String>(backupHospital);
    }
    if (!nullToAbsent || primaryTransport != null) {
      map['primary_transport'] = Variable<String>(primaryTransport);
    }
    if (!nullToAbsent || alternateTransport != null) {
      map['alternate_transport'] = Variable<String>(alternateTransport);
    }
    if (!nullToAbsent || primaryRoute != null) {
      map['primary_route'] = Variable<String>(primaryRoute);
    }
    if (!nullToAbsent || alternateRoute != null) {
      map['alternate_route'] = Variable<String>(alternateRoute);
    }
    if (!nullToAbsent || secondaryContactName != null) {
      map['secondary_contact_name'] = Variable<String>(secondaryContactName);
    }
    if (!nullToAbsent || secondaryContactNumber != null) {
      map['secondary_contact_number'] = Variable<String>(
        secondaryContactNumber,
      );
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EmergencyPlanRecordsCompanion toCompanion(bool nullToAbsent) {
    return EmergencyPlanRecordsCompanion(
      id: Value(id),
      primaryHospital: primaryHospital == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryHospital),
      backupHospital: backupHospital == null && nullToAbsent
          ? const Value.absent()
          : Value(backupHospital),
      primaryTransport: primaryTransport == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryTransport),
      alternateTransport: alternateTransport == null && nullToAbsent
          ? const Value.absent()
          : Value(alternateTransport),
      primaryRoute: primaryRoute == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryRoute),
      alternateRoute: alternateRoute == null && nullToAbsent
          ? const Value.absent()
          : Value(alternateRoute),
      secondaryContactName: secondaryContactName == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryContactName),
      secondaryContactNumber: secondaryContactNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryContactNumber),
      updatedAt: Value(updatedAt),
    );
  }

  factory EmergencyPlanRecordEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmergencyPlanRecordEntry(
      id: serializer.fromJson<int>(json['id']),
      primaryHospital: serializer.fromJson<String?>(json['primaryHospital']),
      backupHospital: serializer.fromJson<String?>(json['backupHospital']),
      primaryTransport: serializer.fromJson<String?>(json['primaryTransport']),
      alternateTransport: serializer.fromJson<String?>(
        json['alternateTransport'],
      ),
      primaryRoute: serializer.fromJson<String?>(json['primaryRoute']),
      alternateRoute: serializer.fromJson<String?>(json['alternateRoute']),
      secondaryContactName: serializer.fromJson<String?>(
        json['secondaryContactName'],
      ),
      secondaryContactNumber: serializer.fromJson<String?>(
        json['secondaryContactNumber'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'primaryHospital': serializer.toJson<String?>(primaryHospital),
      'backupHospital': serializer.toJson<String?>(backupHospital),
      'primaryTransport': serializer.toJson<String?>(primaryTransport),
      'alternateTransport': serializer.toJson<String?>(alternateTransport),
      'primaryRoute': serializer.toJson<String?>(primaryRoute),
      'alternateRoute': serializer.toJson<String?>(alternateRoute),
      'secondaryContactName': serializer.toJson<String?>(secondaryContactName),
      'secondaryContactNumber': serializer.toJson<String?>(
        secondaryContactNumber,
      ),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EmergencyPlanRecordEntry copyWith({
    int? id,
    Value<String?> primaryHospital = const Value.absent(),
    Value<String?> backupHospital = const Value.absent(),
    Value<String?> primaryTransport = const Value.absent(),
    Value<String?> alternateTransport = const Value.absent(),
    Value<String?> primaryRoute = const Value.absent(),
    Value<String?> alternateRoute = const Value.absent(),
    Value<String?> secondaryContactName = const Value.absent(),
    Value<String?> secondaryContactNumber = const Value.absent(),
    DateTime? updatedAt,
  }) => EmergencyPlanRecordEntry(
    id: id ?? this.id,
    primaryHospital: primaryHospital.present
        ? primaryHospital.value
        : this.primaryHospital,
    backupHospital: backupHospital.present
        ? backupHospital.value
        : this.backupHospital,
    primaryTransport: primaryTransport.present
        ? primaryTransport.value
        : this.primaryTransport,
    alternateTransport: alternateTransport.present
        ? alternateTransport.value
        : this.alternateTransport,
    primaryRoute: primaryRoute.present ? primaryRoute.value : this.primaryRoute,
    alternateRoute: alternateRoute.present
        ? alternateRoute.value
        : this.alternateRoute,
    secondaryContactName: secondaryContactName.present
        ? secondaryContactName.value
        : this.secondaryContactName,
    secondaryContactNumber: secondaryContactNumber.present
        ? secondaryContactNumber.value
        : this.secondaryContactNumber,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EmergencyPlanRecordEntry copyWithCompanion(
    EmergencyPlanRecordsCompanion data,
  ) {
    return EmergencyPlanRecordEntry(
      id: data.id.present ? data.id.value : this.id,
      primaryHospital: data.primaryHospital.present
          ? data.primaryHospital.value
          : this.primaryHospital,
      backupHospital: data.backupHospital.present
          ? data.backupHospital.value
          : this.backupHospital,
      primaryTransport: data.primaryTransport.present
          ? data.primaryTransport.value
          : this.primaryTransport,
      alternateTransport: data.alternateTransport.present
          ? data.alternateTransport.value
          : this.alternateTransport,
      primaryRoute: data.primaryRoute.present
          ? data.primaryRoute.value
          : this.primaryRoute,
      alternateRoute: data.alternateRoute.present
          ? data.alternateRoute.value
          : this.alternateRoute,
      secondaryContactName: data.secondaryContactName.present
          ? data.secondaryContactName.value
          : this.secondaryContactName,
      secondaryContactNumber: data.secondaryContactNumber.present
          ? data.secondaryContactNumber.value
          : this.secondaryContactNumber,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyPlanRecordEntry(')
          ..write('id: $id, ')
          ..write('primaryHospital: $primaryHospital, ')
          ..write('backupHospital: $backupHospital, ')
          ..write('primaryTransport: $primaryTransport, ')
          ..write('alternateTransport: $alternateTransport, ')
          ..write('primaryRoute: $primaryRoute, ')
          ..write('alternateRoute: $alternateRoute, ')
          ..write('secondaryContactName: $secondaryContactName, ')
          ..write('secondaryContactNumber: $secondaryContactNumber, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    primaryHospital,
    backupHospital,
    primaryTransport,
    alternateTransport,
    primaryRoute,
    alternateRoute,
    secondaryContactName,
    secondaryContactNumber,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmergencyPlanRecordEntry &&
          other.id == this.id &&
          other.primaryHospital == this.primaryHospital &&
          other.backupHospital == this.backupHospital &&
          other.primaryTransport == this.primaryTransport &&
          other.alternateTransport == this.alternateTransport &&
          other.primaryRoute == this.primaryRoute &&
          other.alternateRoute == this.alternateRoute &&
          other.secondaryContactName == this.secondaryContactName &&
          other.secondaryContactNumber == this.secondaryContactNumber &&
          other.updatedAt == this.updatedAt);
}

class EmergencyPlanRecordsCompanion
    extends UpdateCompanion<EmergencyPlanRecordEntry> {
  final Value<int> id;
  final Value<String?> primaryHospital;
  final Value<String?> backupHospital;
  final Value<String?> primaryTransport;
  final Value<String?> alternateTransport;
  final Value<String?> primaryRoute;
  final Value<String?> alternateRoute;
  final Value<String?> secondaryContactName;
  final Value<String?> secondaryContactNumber;
  final Value<DateTime> updatedAt;
  const EmergencyPlanRecordsCompanion({
    this.id = const Value.absent(),
    this.primaryHospital = const Value.absent(),
    this.backupHospital = const Value.absent(),
    this.primaryTransport = const Value.absent(),
    this.alternateTransport = const Value.absent(),
    this.primaryRoute = const Value.absent(),
    this.alternateRoute = const Value.absent(),
    this.secondaryContactName = const Value.absent(),
    this.secondaryContactNumber = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EmergencyPlanRecordsCompanion.insert({
    this.id = const Value.absent(),
    this.primaryHospital = const Value.absent(),
    this.backupHospital = const Value.absent(),
    this.primaryTransport = const Value.absent(),
    this.alternateTransport = const Value.absent(),
    this.primaryRoute = const Value.absent(),
    this.alternateRoute = const Value.absent(),
    this.secondaryContactName = const Value.absent(),
    this.secondaryContactNumber = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<EmergencyPlanRecordEntry> custom({
    Expression<int>? id,
    Expression<String>? primaryHospital,
    Expression<String>? backupHospital,
    Expression<String>? primaryTransport,
    Expression<String>? alternateTransport,
    Expression<String>? primaryRoute,
    Expression<String>? alternateRoute,
    Expression<String>? secondaryContactName,
    Expression<String>? secondaryContactNumber,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (primaryHospital != null) 'primary_hospital': primaryHospital,
      if (backupHospital != null) 'backup_hospital': backupHospital,
      if (primaryTransport != null) 'primary_transport': primaryTransport,
      if (alternateTransport != null) 'alternate_transport': alternateTransport,
      if (primaryRoute != null) 'primary_route': primaryRoute,
      if (alternateRoute != null) 'alternate_route': alternateRoute,
      if (secondaryContactName != null)
        'secondary_contact_name': secondaryContactName,
      if (secondaryContactNumber != null)
        'secondary_contact_number': secondaryContactNumber,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EmergencyPlanRecordsCompanion copyWith({
    Value<int>? id,
    Value<String?>? primaryHospital,
    Value<String?>? backupHospital,
    Value<String?>? primaryTransport,
    Value<String?>? alternateTransport,
    Value<String?>? primaryRoute,
    Value<String?>? alternateRoute,
    Value<String?>? secondaryContactName,
    Value<String?>? secondaryContactNumber,
    Value<DateTime>? updatedAt,
  }) {
    return EmergencyPlanRecordsCompanion(
      id: id ?? this.id,
      primaryHospital: primaryHospital ?? this.primaryHospital,
      backupHospital: backupHospital ?? this.backupHospital,
      primaryTransport: primaryTransport ?? this.primaryTransport,
      alternateTransport: alternateTransport ?? this.alternateTransport,
      primaryRoute: primaryRoute ?? this.primaryRoute,
      alternateRoute: alternateRoute ?? this.alternateRoute,
      secondaryContactName: secondaryContactName ?? this.secondaryContactName,
      secondaryContactNumber:
          secondaryContactNumber ?? this.secondaryContactNumber,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (primaryHospital.present) {
      map['primary_hospital'] = Variable<String>(primaryHospital.value);
    }
    if (backupHospital.present) {
      map['backup_hospital'] = Variable<String>(backupHospital.value);
    }
    if (primaryTransport.present) {
      map['primary_transport'] = Variable<String>(primaryTransport.value);
    }
    if (alternateTransport.present) {
      map['alternate_transport'] = Variable<String>(alternateTransport.value);
    }
    if (primaryRoute.present) {
      map['primary_route'] = Variable<String>(primaryRoute.value);
    }
    if (alternateRoute.present) {
      map['alternate_route'] = Variable<String>(alternateRoute.value);
    }
    if (secondaryContactName.present) {
      map['secondary_contact_name'] = Variable<String>(
        secondaryContactName.value,
      );
    }
    if (secondaryContactNumber.present) {
      map['secondary_contact_number'] = Variable<String>(
        secondaryContactNumber.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyPlanRecordsCompanion(')
          ..write('id: $id, ')
          ..write('primaryHospital: $primaryHospital, ')
          ..write('backupHospital: $backupHospital, ')
          ..write('primaryTransport: $primaryTransport, ')
          ..write('alternateTransport: $alternateTransport, ')
          ..write('primaryRoute: $primaryRoute, ')
          ..write('alternateRoute: $alternateRoute, ')
          ..write('secondaryContactName: $secondaryContactName, ')
          ..write('secondaryContactNumber: $secondaryContactNumber, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AssessmentScoresTable assessmentScores = $AssessmentScoresTable(
    this,
  );
  late final $ChecklistItemsTable checklistItems = $ChecklistItemsTable(this);
  late final $DangerSignsScreeningsTable dangerSignsScreenings =
      $DangerSignsScreeningsTable(this);
  late final $DeliveryPlanRecordsTable deliveryPlanRecords =
      $DeliveryPlanRecordsTable(this);
  late final $SupportPersonRecordsTable supportPersonRecords =
      $SupportPersonRecordsTable(this);
  late final $EmergencyPlanRecordsTable emergencyPlanRecords =
      $EmergencyPlanRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    assessmentScores,
    checklistItems,
    dangerSignsScreenings,
    deliveryPlanRecords,
    supportPersonRecords,
    emergencyPlanRecords,
  ];
}

typedef $$AssessmentScoresTableCreateCompanionBuilder =
    AssessmentScoresCompanion Function({
      Value<int> id,
      required AssessmentCategory category,
      required int score,
      required int maxScore,
      required PreparednessStatus status,
      Value<String> feedback,
      Value<DateTime> completedAt,
      Value<DateTime> updatedAt,
    });
typedef $$AssessmentScoresTableUpdateCompanionBuilder =
    AssessmentScoresCompanion Function({
      Value<int> id,
      Value<AssessmentCategory> category,
      Value<int> score,
      Value<int> maxScore,
      Value<PreparednessStatus> status,
      Value<String> feedback,
      Value<DateTime> completedAt,
      Value<DateTime> updatedAt,
    });

class $$AssessmentScoresTableFilterComposer
    extends Composer<_$AppDatabase, $AssessmentScoresTable> {
  $$AssessmentScoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AssessmentCategory, AssessmentCategory, String>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxScore => $composableBuilder(
    column: $table.maxScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PreparednessStatus, PreparednessStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get feedback => $composableBuilder(
    column: $table.feedback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AssessmentScoresTableOrderingComposer
    extends Composer<_$AppDatabase, $AssessmentScoresTable> {
  $$AssessmentScoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxScore => $composableBuilder(
    column: $table.maxScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedback => $composableBuilder(
    column: $table.feedback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AssessmentScoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssessmentScoresTable> {
  $$AssessmentScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AssessmentCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get maxScore =>
      $composableBuilder(column: $table.maxScore, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PreparednessStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get feedback =>
      $composableBuilder(column: $table.feedback, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AssessmentScoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssessmentScoresTable,
          AssessmentScoreEntry,
          $$AssessmentScoresTableFilterComposer,
          $$AssessmentScoresTableOrderingComposer,
          $$AssessmentScoresTableAnnotationComposer,
          $$AssessmentScoresTableCreateCompanionBuilder,
          $$AssessmentScoresTableUpdateCompanionBuilder,
          (
            AssessmentScoreEntry,
            BaseReferences<
              _$AppDatabase,
              $AssessmentScoresTable,
              AssessmentScoreEntry
            >,
          ),
          AssessmentScoreEntry,
          PrefetchHooks Function()
        > {
  $$AssessmentScoresTableTableManager(
    _$AppDatabase db,
    $AssessmentScoresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssessmentScoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssessmentScoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssessmentScoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<AssessmentCategory> category = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> maxScore = const Value.absent(),
                Value<PreparednessStatus> status = const Value.absent(),
                Value<String> feedback = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AssessmentScoresCompanion(
                id: id,
                category: category,
                score: score,
                maxScore: maxScore,
                status: status,
                feedback: feedback,
                completedAt: completedAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required AssessmentCategory category,
                required int score,
                required int maxScore,
                required PreparednessStatus status,
                Value<String> feedback = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AssessmentScoresCompanion.insert(
                id: id,
                category: category,
                score: score,
                maxScore: maxScore,
                status: status,
                feedback: feedback,
                completedAt: completedAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AssessmentScoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssessmentScoresTable,
      AssessmentScoreEntry,
      $$AssessmentScoresTableFilterComposer,
      $$AssessmentScoresTableOrderingComposer,
      $$AssessmentScoresTableAnnotationComposer,
      $$AssessmentScoresTableCreateCompanionBuilder,
      $$AssessmentScoresTableUpdateCompanionBuilder,
      (
        AssessmentScoreEntry,
        BaseReferences<
          _$AppDatabase,
          $AssessmentScoresTable,
          AssessmentScoreEntry
        >,
      ),
      AssessmentScoreEntry,
      PrefetchHooks Function()
    >;
typedef $$ChecklistItemsTableCreateCompanionBuilder =
    ChecklistItemsCompanion Function({
      Value<int> id,
      required String name,
      required ChecklistOwner owner,
      Value<DeliveryMode> deliveryMode,
      Value<bool> isChecked,
      Value<bool> isCustom,
      Value<String?> iconKey,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });
typedef $$ChecklistItemsTableUpdateCompanionBuilder =
    ChecklistItemsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<ChecklistOwner> owner,
      Value<DeliveryMode> deliveryMode,
      Value<bool> isChecked,
      Value<bool> isCustom,
      Value<String?> iconKey,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });

class $$ChecklistItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ChecklistItemsTable> {
  $$ChecklistItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ChecklistOwner, ChecklistOwner, String>
  get owner => $composableBuilder(
    column: $table.owner,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<DeliveryMode, DeliveryMode, String>
  get deliveryMode => $composableBuilder(
    column: $table.deliveryMode,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isChecked => $composableBuilder(
    column: $table.isChecked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChecklistItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChecklistItemsTable> {
  $$ChecklistItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get owner => $composableBuilder(
    column: $table.owner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deliveryMode => $composableBuilder(
    column: $table.deliveryMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isChecked => $composableBuilder(
    column: $table.isChecked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChecklistItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChecklistItemsTable> {
  $$ChecklistItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ChecklistOwner, String> get owner =>
      $composableBuilder(column: $table.owner, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DeliveryMode, String> get deliveryMode =>
      $composableBuilder(
        column: $table.deliveryMode,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get isChecked =>
      $composableBuilder(column: $table.isChecked, builder: (column) => column);

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ChecklistItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChecklistItemsTable,
          ChecklistItemEntry,
          $$ChecklistItemsTableFilterComposer,
          $$ChecklistItemsTableOrderingComposer,
          $$ChecklistItemsTableAnnotationComposer,
          $$ChecklistItemsTableCreateCompanionBuilder,
          $$ChecklistItemsTableUpdateCompanionBuilder,
          (
            ChecklistItemEntry,
            BaseReferences<
              _$AppDatabase,
              $ChecklistItemsTable,
              ChecklistItemEntry
            >,
          ),
          ChecklistItemEntry,
          PrefetchHooks Function()
        > {
  $$ChecklistItemsTableTableManager(
    _$AppDatabase db,
    $ChecklistItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChecklistItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChecklistItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<ChecklistOwner> owner = const Value.absent(),
                Value<DeliveryMode> deliveryMode = const Value.absent(),
                Value<bool> isChecked = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<String?> iconKey = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ChecklistItemsCompanion(
                id: id,
                name: name,
                owner: owner,
                deliveryMode: deliveryMode,
                isChecked: isChecked,
                isCustom: isCustom,
                iconKey: iconKey,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required ChecklistOwner owner,
                Value<DeliveryMode> deliveryMode = const Value.absent(),
                Value<bool> isChecked = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<String?> iconKey = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ChecklistItemsCompanion.insert(
                id: id,
                name: name,
                owner: owner,
                deliveryMode: deliveryMode,
                isChecked: isChecked,
                isCustom: isCustom,
                iconKey: iconKey,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChecklistItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChecklistItemsTable,
      ChecklistItemEntry,
      $$ChecklistItemsTableFilterComposer,
      $$ChecklistItemsTableOrderingComposer,
      $$ChecklistItemsTableAnnotationComposer,
      $$ChecklistItemsTableCreateCompanionBuilder,
      $$ChecklistItemsTableUpdateCompanionBuilder,
      (
        ChecklistItemEntry,
        BaseReferences<_$AppDatabase, $ChecklistItemsTable, ChecklistItemEntry>,
      ),
      ChecklistItemEntry,
      PrefetchHooks Function()
    >;
typedef $$DangerSignsScreeningsTableCreateCompanionBuilder =
    DangerSignsScreeningsCompanion Function({
      Value<int> id,
      Value<bool> isDangerDetected,
      Value<String?> triggeringQuestionIds,
      Value<DateTime> completedAt,
      Value<DateTime> updatedAt,
    });
typedef $$DangerSignsScreeningsTableUpdateCompanionBuilder =
    DangerSignsScreeningsCompanion Function({
      Value<int> id,
      Value<bool> isDangerDetected,
      Value<String?> triggeringQuestionIds,
      Value<DateTime> completedAt,
      Value<DateTime> updatedAt,
    });

class $$DangerSignsScreeningsTableFilterComposer
    extends Composer<_$AppDatabase, $DangerSignsScreeningsTable> {
  $$DangerSignsScreeningsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDangerDetected => $composableBuilder(
    column: $table.isDangerDetected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get triggeringQuestionIds => $composableBuilder(
    column: $table.triggeringQuestionIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DangerSignsScreeningsTableOrderingComposer
    extends Composer<_$AppDatabase, $DangerSignsScreeningsTable> {
  $$DangerSignsScreeningsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDangerDetected => $composableBuilder(
    column: $table.isDangerDetected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get triggeringQuestionIds => $composableBuilder(
    column: $table.triggeringQuestionIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DangerSignsScreeningsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DangerSignsScreeningsTable> {
  $$DangerSignsScreeningsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isDangerDetected => $composableBuilder(
    column: $table.isDangerDetected,
    builder: (column) => column,
  );

  GeneratedColumn<String> get triggeringQuestionIds => $composableBuilder(
    column: $table.triggeringQuestionIds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DangerSignsScreeningsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DangerSignsScreeningsTable,
          DangerSignsScreeningEntry,
          $$DangerSignsScreeningsTableFilterComposer,
          $$DangerSignsScreeningsTableOrderingComposer,
          $$DangerSignsScreeningsTableAnnotationComposer,
          $$DangerSignsScreeningsTableCreateCompanionBuilder,
          $$DangerSignsScreeningsTableUpdateCompanionBuilder,
          (
            DangerSignsScreeningEntry,
            BaseReferences<
              _$AppDatabase,
              $DangerSignsScreeningsTable,
              DangerSignsScreeningEntry
            >,
          ),
          DangerSignsScreeningEntry,
          PrefetchHooks Function()
        > {
  $$DangerSignsScreeningsTableTableManager(
    _$AppDatabase db,
    $DangerSignsScreeningsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DangerSignsScreeningsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DangerSignsScreeningsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DangerSignsScreeningsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> isDangerDetected = const Value.absent(),
                Value<String?> triggeringQuestionIds = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DangerSignsScreeningsCompanion(
                id: id,
                isDangerDetected: isDangerDetected,
                triggeringQuestionIds: triggeringQuestionIds,
                completedAt: completedAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> isDangerDetected = const Value.absent(),
                Value<String?> triggeringQuestionIds = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DangerSignsScreeningsCompanion.insert(
                id: id,
                isDangerDetected: isDangerDetected,
                triggeringQuestionIds: triggeringQuestionIds,
                completedAt: completedAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DangerSignsScreeningsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DangerSignsScreeningsTable,
      DangerSignsScreeningEntry,
      $$DangerSignsScreeningsTableFilterComposer,
      $$DangerSignsScreeningsTableOrderingComposer,
      $$DangerSignsScreeningsTableAnnotationComposer,
      $$DangerSignsScreeningsTableCreateCompanionBuilder,
      $$DangerSignsScreeningsTableUpdateCompanionBuilder,
      (
        DangerSignsScreeningEntry,
        BaseReferences<
          _$AppDatabase,
          $DangerSignsScreeningsTable,
          DangerSignsScreeningEntry
        >,
      ),
      DangerSignsScreeningEntry,
      PrefetchHooks Function()
    >;
typedef $$DeliveryPlanRecordsTableCreateCompanionBuilder =
    DeliveryPlanRecordsCompanion Function({
      Value<int> id,
      Value<String?> preferredFacility,
      Value<String?> primaryTransport,
      Value<String?> accompaniedBy,
      Value<bool> discussedWithSupportPerson,
      Value<String?> backupPlanNotes,
      Value<DateTime> updatedAt,
    });
typedef $$DeliveryPlanRecordsTableUpdateCompanionBuilder =
    DeliveryPlanRecordsCompanion Function({
      Value<int> id,
      Value<String?> preferredFacility,
      Value<String?> primaryTransport,
      Value<String?> accompaniedBy,
      Value<bool> discussedWithSupportPerson,
      Value<String?> backupPlanNotes,
      Value<DateTime> updatedAt,
    });

class $$DeliveryPlanRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $DeliveryPlanRecordsTable> {
  $$DeliveryPlanRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredFacility => $composableBuilder(
    column: $table.preferredFacility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryTransport => $composableBuilder(
    column: $table.primaryTransport,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accompaniedBy => $composableBuilder(
    column: $table.accompaniedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get discussedWithSupportPerson => $composableBuilder(
    column: $table.discussedWithSupportPerson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backupPlanNotes => $composableBuilder(
    column: $table.backupPlanNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeliveryPlanRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $DeliveryPlanRecordsTable> {
  $$DeliveryPlanRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredFacility => $composableBuilder(
    column: $table.preferredFacility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryTransport => $composableBuilder(
    column: $table.primaryTransport,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accompaniedBy => $composableBuilder(
    column: $table.accompaniedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get discussedWithSupportPerson => $composableBuilder(
    column: $table.discussedWithSupportPerson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backupPlanNotes => $composableBuilder(
    column: $table.backupPlanNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeliveryPlanRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeliveryPlanRecordsTable> {
  $$DeliveryPlanRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get preferredFacility => $composableBuilder(
    column: $table.preferredFacility,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryTransport => $composableBuilder(
    column: $table.primaryTransport,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accompaniedBy => $composableBuilder(
    column: $table.accompaniedBy,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get discussedWithSupportPerson => $composableBuilder(
    column: $table.discussedWithSupportPerson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backupPlanNotes => $composableBuilder(
    column: $table.backupPlanNotes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DeliveryPlanRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeliveryPlanRecordsTable,
          DeliveryPlanRecordEntry,
          $$DeliveryPlanRecordsTableFilterComposer,
          $$DeliveryPlanRecordsTableOrderingComposer,
          $$DeliveryPlanRecordsTableAnnotationComposer,
          $$DeliveryPlanRecordsTableCreateCompanionBuilder,
          $$DeliveryPlanRecordsTableUpdateCompanionBuilder,
          (
            DeliveryPlanRecordEntry,
            BaseReferences<
              _$AppDatabase,
              $DeliveryPlanRecordsTable,
              DeliveryPlanRecordEntry
            >,
          ),
          DeliveryPlanRecordEntry,
          PrefetchHooks Function()
        > {
  $$DeliveryPlanRecordsTableTableManager(
    _$AppDatabase db,
    $DeliveryPlanRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeliveryPlanRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeliveryPlanRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DeliveryPlanRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> preferredFacility = const Value.absent(),
                Value<String?> primaryTransport = const Value.absent(),
                Value<String?> accompaniedBy = const Value.absent(),
                Value<bool> discussedWithSupportPerson = const Value.absent(),
                Value<String?> backupPlanNotes = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DeliveryPlanRecordsCompanion(
                id: id,
                preferredFacility: preferredFacility,
                primaryTransport: primaryTransport,
                accompaniedBy: accompaniedBy,
                discussedWithSupportPerson: discussedWithSupportPerson,
                backupPlanNotes: backupPlanNotes,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> preferredFacility = const Value.absent(),
                Value<String?> primaryTransport = const Value.absent(),
                Value<String?> accompaniedBy = const Value.absent(),
                Value<bool> discussedWithSupportPerson = const Value.absent(),
                Value<String?> backupPlanNotes = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DeliveryPlanRecordsCompanion.insert(
                id: id,
                preferredFacility: preferredFacility,
                primaryTransport: primaryTransport,
                accompaniedBy: accompaniedBy,
                discussedWithSupportPerson: discussedWithSupportPerson,
                backupPlanNotes: backupPlanNotes,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeliveryPlanRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeliveryPlanRecordsTable,
      DeliveryPlanRecordEntry,
      $$DeliveryPlanRecordsTableFilterComposer,
      $$DeliveryPlanRecordsTableOrderingComposer,
      $$DeliveryPlanRecordsTableAnnotationComposer,
      $$DeliveryPlanRecordsTableCreateCompanionBuilder,
      $$DeliveryPlanRecordsTableUpdateCompanionBuilder,
      (
        DeliveryPlanRecordEntry,
        BaseReferences<
          _$AppDatabase,
          $DeliveryPlanRecordsTable,
          DeliveryPlanRecordEntry
        >,
      ),
      DeliveryPlanRecordEntry,
      PrefetchHooks Function()
    >;
typedef $$SupportPersonRecordsTableCreateCompanionBuilder =
    SupportPersonRecordsCompanion Function({
      Value<int> id,
      Value<String?> fullName,
      Value<String?> relationship,
      Value<String?> contactNumber,
      Value<String?> address,
      Value<String?> alternateContactName,
      Value<String?> alternateContactNumber,
      Value<DateTime> updatedAt,
    });
typedef $$SupportPersonRecordsTableUpdateCompanionBuilder =
    SupportPersonRecordsCompanion Function({
      Value<int> id,
      Value<String?> fullName,
      Value<String?> relationship,
      Value<String?> contactNumber,
      Value<String?> address,
      Value<String?> alternateContactName,
      Value<String?> alternateContactNumber,
      Value<DateTime> updatedAt,
    });

class $$SupportPersonRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $SupportPersonRecordsTable> {
  $$SupportPersonRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alternateContactName => $composableBuilder(
    column: $table.alternateContactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alternateContactNumber => $composableBuilder(
    column: $table.alternateContactNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SupportPersonRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $SupportPersonRecordsTable> {
  $$SupportPersonRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alternateContactName => $composableBuilder(
    column: $table.alternateContactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alternateContactNumber => $composableBuilder(
    column: $table.alternateContactNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SupportPersonRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupportPersonRecordsTable> {
  $$SupportPersonRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get alternateContactName => $composableBuilder(
    column: $table.alternateContactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get alternateContactNumber => $composableBuilder(
    column: $table.alternateContactNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SupportPersonRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupportPersonRecordsTable,
          SupportPersonRecordEntry,
          $$SupportPersonRecordsTableFilterComposer,
          $$SupportPersonRecordsTableOrderingComposer,
          $$SupportPersonRecordsTableAnnotationComposer,
          $$SupportPersonRecordsTableCreateCompanionBuilder,
          $$SupportPersonRecordsTableUpdateCompanionBuilder,
          (
            SupportPersonRecordEntry,
            BaseReferences<
              _$AppDatabase,
              $SupportPersonRecordsTable,
              SupportPersonRecordEntry
            >,
          ),
          SupportPersonRecordEntry,
          PrefetchHooks Function()
        > {
  $$SupportPersonRecordsTableTableManager(
    _$AppDatabase db,
    $SupportPersonRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupportPersonRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SupportPersonRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SupportPersonRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> fullName = const Value.absent(),
                Value<String?> relationship = const Value.absent(),
                Value<String?> contactNumber = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> alternateContactName = const Value.absent(),
                Value<String?> alternateContactNumber = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SupportPersonRecordsCompanion(
                id: id,
                fullName: fullName,
                relationship: relationship,
                contactNumber: contactNumber,
                address: address,
                alternateContactName: alternateContactName,
                alternateContactNumber: alternateContactNumber,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> fullName = const Value.absent(),
                Value<String?> relationship = const Value.absent(),
                Value<String?> contactNumber = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> alternateContactName = const Value.absent(),
                Value<String?> alternateContactNumber = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SupportPersonRecordsCompanion.insert(
                id: id,
                fullName: fullName,
                relationship: relationship,
                contactNumber: contactNumber,
                address: address,
                alternateContactName: alternateContactName,
                alternateContactNumber: alternateContactNumber,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SupportPersonRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupportPersonRecordsTable,
      SupportPersonRecordEntry,
      $$SupportPersonRecordsTableFilterComposer,
      $$SupportPersonRecordsTableOrderingComposer,
      $$SupportPersonRecordsTableAnnotationComposer,
      $$SupportPersonRecordsTableCreateCompanionBuilder,
      $$SupportPersonRecordsTableUpdateCompanionBuilder,
      (
        SupportPersonRecordEntry,
        BaseReferences<
          _$AppDatabase,
          $SupportPersonRecordsTable,
          SupportPersonRecordEntry
        >,
      ),
      SupportPersonRecordEntry,
      PrefetchHooks Function()
    >;
typedef $$EmergencyPlanRecordsTableCreateCompanionBuilder =
    EmergencyPlanRecordsCompanion Function({
      Value<int> id,
      Value<String?> primaryHospital,
      Value<String?> backupHospital,
      Value<String?> primaryTransport,
      Value<String?> alternateTransport,
      Value<String?> primaryRoute,
      Value<String?> alternateRoute,
      Value<String?> secondaryContactName,
      Value<String?> secondaryContactNumber,
      Value<DateTime> updatedAt,
    });
typedef $$EmergencyPlanRecordsTableUpdateCompanionBuilder =
    EmergencyPlanRecordsCompanion Function({
      Value<int> id,
      Value<String?> primaryHospital,
      Value<String?> backupHospital,
      Value<String?> primaryTransport,
      Value<String?> alternateTransport,
      Value<String?> primaryRoute,
      Value<String?> alternateRoute,
      Value<String?> secondaryContactName,
      Value<String?> secondaryContactNumber,
      Value<DateTime> updatedAt,
    });

class $$EmergencyPlanRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $EmergencyPlanRecordsTable> {
  $$EmergencyPlanRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryHospital => $composableBuilder(
    column: $table.primaryHospital,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backupHospital => $composableBuilder(
    column: $table.backupHospital,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryTransport => $composableBuilder(
    column: $table.primaryTransport,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alternateTransport => $composableBuilder(
    column: $table.alternateTransport,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryRoute => $composableBuilder(
    column: $table.primaryRoute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alternateRoute => $composableBuilder(
    column: $table.alternateRoute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryContactName => $composableBuilder(
    column: $table.secondaryContactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryContactNumber => $composableBuilder(
    column: $table.secondaryContactNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmergencyPlanRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $EmergencyPlanRecordsTable> {
  $$EmergencyPlanRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryHospital => $composableBuilder(
    column: $table.primaryHospital,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backupHospital => $composableBuilder(
    column: $table.backupHospital,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryTransport => $composableBuilder(
    column: $table.primaryTransport,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alternateTransport => $composableBuilder(
    column: $table.alternateTransport,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryRoute => $composableBuilder(
    column: $table.primaryRoute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alternateRoute => $composableBuilder(
    column: $table.alternateRoute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryContactName => $composableBuilder(
    column: $table.secondaryContactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryContactNumber => $composableBuilder(
    column: $table.secondaryContactNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmergencyPlanRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmergencyPlanRecordsTable> {
  $$EmergencyPlanRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get primaryHospital => $composableBuilder(
    column: $table.primaryHospital,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backupHospital => $composableBuilder(
    column: $table.backupHospital,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryTransport => $composableBuilder(
    column: $table.primaryTransport,
    builder: (column) => column,
  );

  GeneratedColumn<String> get alternateTransport => $composableBuilder(
    column: $table.alternateTransport,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryRoute => $composableBuilder(
    column: $table.primaryRoute,
    builder: (column) => column,
  );

  GeneratedColumn<String> get alternateRoute => $composableBuilder(
    column: $table.alternateRoute,
    builder: (column) => column,
  );

  GeneratedColumn<String> get secondaryContactName => $composableBuilder(
    column: $table.secondaryContactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get secondaryContactNumber => $composableBuilder(
    column: $table.secondaryContactNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EmergencyPlanRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmergencyPlanRecordsTable,
          EmergencyPlanRecordEntry,
          $$EmergencyPlanRecordsTableFilterComposer,
          $$EmergencyPlanRecordsTableOrderingComposer,
          $$EmergencyPlanRecordsTableAnnotationComposer,
          $$EmergencyPlanRecordsTableCreateCompanionBuilder,
          $$EmergencyPlanRecordsTableUpdateCompanionBuilder,
          (
            EmergencyPlanRecordEntry,
            BaseReferences<
              _$AppDatabase,
              $EmergencyPlanRecordsTable,
              EmergencyPlanRecordEntry
            >,
          ),
          EmergencyPlanRecordEntry,
          PrefetchHooks Function()
        > {
  $$EmergencyPlanRecordsTableTableManager(
    _$AppDatabase db,
    $EmergencyPlanRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmergencyPlanRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmergencyPlanRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EmergencyPlanRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> primaryHospital = const Value.absent(),
                Value<String?> backupHospital = const Value.absent(),
                Value<String?> primaryTransport = const Value.absent(),
                Value<String?> alternateTransport = const Value.absent(),
                Value<String?> primaryRoute = const Value.absent(),
                Value<String?> alternateRoute = const Value.absent(),
                Value<String?> secondaryContactName = const Value.absent(),
                Value<String?> secondaryContactNumber = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => EmergencyPlanRecordsCompanion(
                id: id,
                primaryHospital: primaryHospital,
                backupHospital: backupHospital,
                primaryTransport: primaryTransport,
                alternateTransport: alternateTransport,
                primaryRoute: primaryRoute,
                alternateRoute: alternateRoute,
                secondaryContactName: secondaryContactName,
                secondaryContactNumber: secondaryContactNumber,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> primaryHospital = const Value.absent(),
                Value<String?> backupHospital = const Value.absent(),
                Value<String?> primaryTransport = const Value.absent(),
                Value<String?> alternateTransport = const Value.absent(),
                Value<String?> primaryRoute = const Value.absent(),
                Value<String?> alternateRoute = const Value.absent(),
                Value<String?> secondaryContactName = const Value.absent(),
                Value<String?> secondaryContactNumber = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => EmergencyPlanRecordsCompanion.insert(
                id: id,
                primaryHospital: primaryHospital,
                backupHospital: backupHospital,
                primaryTransport: primaryTransport,
                alternateTransport: alternateTransport,
                primaryRoute: primaryRoute,
                alternateRoute: alternateRoute,
                secondaryContactName: secondaryContactName,
                secondaryContactNumber: secondaryContactNumber,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmergencyPlanRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmergencyPlanRecordsTable,
      EmergencyPlanRecordEntry,
      $$EmergencyPlanRecordsTableFilterComposer,
      $$EmergencyPlanRecordsTableOrderingComposer,
      $$EmergencyPlanRecordsTableAnnotationComposer,
      $$EmergencyPlanRecordsTableCreateCompanionBuilder,
      $$EmergencyPlanRecordsTableUpdateCompanionBuilder,
      (
        EmergencyPlanRecordEntry,
        BaseReferences<
          _$AppDatabase,
          $EmergencyPlanRecordsTable,
          EmergencyPlanRecordEntry
        >,
      ),
      EmergencyPlanRecordEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AssessmentScoresTableTableManager get assessmentScores =>
      $$AssessmentScoresTableTableManager(_db, _db.assessmentScores);
  $$ChecklistItemsTableTableManager get checklistItems =>
      $$ChecklistItemsTableTableManager(_db, _db.checklistItems);
  $$DangerSignsScreeningsTableTableManager get dangerSignsScreenings =>
      $$DangerSignsScreeningsTableTableManager(_db, _db.dangerSignsScreenings);
  $$DeliveryPlanRecordsTableTableManager get deliveryPlanRecords =>
      $$DeliveryPlanRecordsTableTableManager(_db, _db.deliveryPlanRecords);
  $$SupportPersonRecordsTableTableManager get supportPersonRecords =>
      $$SupportPersonRecordsTableTableManager(_db, _db.supportPersonRecords);
  $$EmergencyPlanRecordsTableTableManager get emergencyPlanRecords =>
      $$EmergencyPlanRecordsTableTableManager(_db, _db.emergencyPlanRecords);
}
