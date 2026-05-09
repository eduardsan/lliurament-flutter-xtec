// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PokemonCardsTable extends PokemonCards
    with TableInfo<$PokemonCardsTable, PokemonCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonCardsTable(this.attachedDatabase, [this._alias]);
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, type, imageUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonCard> instance, {
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
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonCard(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
    );
  }

  @override
  $PokemonCardsTable createAlias(String alias) {
    return $PokemonCardsTable(attachedDatabase, alias);
  }
}

class PokemonCard extends DataClass implements Insertable<PokemonCard> {
  final int id;
  final String name;
  final String type;
  final String imageUrl;
  const PokemonCard({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['image_url'] = Variable<String>(imageUrl);
    return map;
  }

  PokemonCardsCompanion toCompanion(bool nullToAbsent) {
    return PokemonCardsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      imageUrl: Value(imageUrl),
    );
  }

  factory PokemonCard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonCard(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'imageUrl': serializer.toJson<String>(imageUrl),
    };
  }

  PokemonCard copyWith({
    int? id,
    String? name,
    String? type,
    String? imageUrl,
  }) => PokemonCard(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    imageUrl: imageUrl ?? this.imageUrl,
  );
  PokemonCard copyWithCompanion(PokemonCardsCompanion data) {
    return PokemonCard(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonCard(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, imageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonCard &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.imageUrl == this.imageUrl);
}

class PokemonCardsCompanion extends UpdateCompanion<PokemonCard> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> imageUrl;
  const PokemonCardsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.imageUrl = const Value.absent(),
  });
  PokemonCardsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String type,
    required String imageUrl,
  }) : name = Value(name),
       type = Value(type),
       imageUrl = Value(imageUrl);
  static Insertable<PokemonCard> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? imageUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (imageUrl != null) 'image_url': imageUrl,
    });
  }

  PokemonCardsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? type,
    Value<String>? imageUrl,
  }) {
    return PokemonCardsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
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
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonCardsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PokemonCardsTable pokemonCards = $PokemonCardsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [pokemonCards];
}

typedef $$PokemonCardsTableCreateCompanionBuilder =
    PokemonCardsCompanion Function({
      Value<int> id,
      required String name,
      required String type,
      required String imageUrl,
    });
typedef $$PokemonCardsTableUpdateCompanionBuilder =
    PokemonCardsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> type,
      Value<String> imageUrl,
    });

class $$PokemonCardsTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonCardsTable> {
  $$PokemonCardsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PokemonCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonCardsTable> {
  $$PokemonCardsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonCardsTable> {
  $$PokemonCardsTableAnnotationComposer({
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);
}

class $$PokemonCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonCardsTable,
          PokemonCard,
          $$PokemonCardsTableFilterComposer,
          $$PokemonCardsTableOrderingComposer,
          $$PokemonCardsTableAnnotationComposer,
          $$PokemonCardsTableCreateCompanionBuilder,
          $$PokemonCardsTableUpdateCompanionBuilder,
          (
            PokemonCard,
            BaseReferences<_$AppDatabase, $PokemonCardsTable, PokemonCard>,
          ),
          PokemonCard,
          PrefetchHooks Function()
        > {
  $$PokemonCardsTableTableManager(_$AppDatabase db, $PokemonCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
              }) => PokemonCardsCompanion(
                id: id,
                name: name,
                type: type,
                imageUrl: imageUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String type,
                required String imageUrl,
              }) => PokemonCardsCompanion.insert(
                id: id,
                name: name,
                type: type,
                imageUrl: imageUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PokemonCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonCardsTable,
      PokemonCard,
      $$PokemonCardsTableFilterComposer,
      $$PokemonCardsTableOrderingComposer,
      $$PokemonCardsTableAnnotationComposer,
      $$PokemonCardsTableCreateCompanionBuilder,
      $$PokemonCardsTableUpdateCompanionBuilder,
      (
        PokemonCard,
        BaseReferences<_$AppDatabase, $PokemonCardsTable, PokemonCard>,
      ),
      PokemonCard,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PokemonCardsTableTableManager get pokemonCards =>
      $$PokemonCardsTableTableManager(_db, _db.pokemonCards);
}
