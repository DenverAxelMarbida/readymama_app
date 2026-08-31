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

  /// Max points possible for this category (contributes to the 80-pt total).
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AssessmentScoresTable assessmentScores = $AssessmentScoresTable(
    this,
  );
  late final $ChecklistItemsTable checklistItems = $ChecklistItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    assessmentScores,
    checklistItems,
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AssessmentScoresTableTableManager get assessmentScores =>
      $$AssessmentScoresTableTableManager(_db, _db.assessmentScores);
  $$ChecklistItemsTableTableManager get checklistItems =>
      $$ChecklistItemsTableTableManager(_db, _db.checklistItems);
}
