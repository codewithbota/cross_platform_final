// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ClothingItemsTable extends ClothingItems
    with TableInfo<$ClothingItemsTable, ClothingItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClothingItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _seasonMeta = const VerificationMeta('season');
  @override
  late final GeneratedColumn<String> season = GeneratedColumn<String>(
      'season', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
      'emoji', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('👕'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, category, color, season, imagePath, notes, emoji];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clothing_items';
  @override
  VerificationContext validateIntegrity(Insertable<ClothingItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('season')) {
      context.handle(_seasonMeta,
          season.isAcceptableOrUnknown(data['season']!, _seasonMeta));
    } else if (isInserting) {
      context.missing(_seasonMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('emoji')) {
      context.handle(
          _emojiMeta, emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClothingItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClothingItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      season: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}season'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      emoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}emoji'])!,
    );
  }

  @override
  $ClothingItemsTable createAlias(String alias) {
    return $ClothingItemsTable(attachedDatabase, alias);
  }
}

class ClothingItem extends DataClass implements Insertable<ClothingItem> {
  final String id;
  final String name;
  final String category;
  final String color;
  final String season;
  final String? imagePath;
  final String? notes;
  final String emoji;
  const ClothingItem(
      {required this.id,
      required this.name,
      required this.category,
      required this.color,
      required this.season,
      this.imagePath,
      this.notes,
      required this.emoji});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['color'] = Variable<String>(color);
    map['season'] = Variable<String>(season);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['emoji'] = Variable<String>(emoji);
    return map;
  }

  ClothingItemsCompanion toCompanion(bool nullToAbsent) {
    return ClothingItemsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      color: Value(color),
      season: Value(season),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      emoji: Value(emoji),
    );
  }

  factory ClothingItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClothingItem(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      color: serializer.fromJson<String>(json['color']),
      season: serializer.fromJson<String>(json['season']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      notes: serializer.fromJson<String?>(json['notes']),
      emoji: serializer.fromJson<String>(json['emoji']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'color': serializer.toJson<String>(color),
      'season': serializer.toJson<String>(season),
      'imagePath': serializer.toJson<String?>(imagePath),
      'notes': serializer.toJson<String?>(notes),
      'emoji': serializer.toJson<String>(emoji),
    };
  }

  ClothingItem copyWith(
          {String? id,
          String? name,
          String? category,
          String? color,
          String? season,
          Value<String?> imagePath = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          String? emoji}) =>
      ClothingItem(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        color: color ?? this.color,
        season: season ?? this.season,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        notes: notes.present ? notes.value : this.notes,
        emoji: emoji ?? this.emoji,
      );
  ClothingItem copyWithCompanion(ClothingItemsCompanion data) {
    return ClothingItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      color: data.color.present ? data.color.value : this.color,
      season: data.season.present ? data.season.value : this.season,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      notes: data.notes.present ? data.notes.value : this.notes,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClothingItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('color: $color, ')
          ..write('season: $season, ')
          ..write('imagePath: $imagePath, ')
          ..write('notes: $notes, ')
          ..write('emoji: $emoji')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, category, color, season, imagePath, notes, emoji);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClothingItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.color == this.color &&
          other.season == this.season &&
          other.imagePath == this.imagePath &&
          other.notes == this.notes &&
          other.emoji == this.emoji);
}

class ClothingItemsCompanion extends UpdateCompanion<ClothingItem> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> color;
  final Value<String> season;
  final Value<String?> imagePath;
  final Value<String?> notes;
  final Value<String> emoji;
  final Value<int> rowid;
  const ClothingItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.color = const Value.absent(),
    this.season = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.notes = const Value.absent(),
    this.emoji = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClothingItemsCompanion.insert({
    required String id,
    required String name,
    required String category,
    required String color,
    required String season,
    this.imagePath = const Value.absent(),
    this.notes = const Value.absent(),
    this.emoji = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        category = Value(category),
        color = Value(color),
        season = Value(season);
  static Insertable<ClothingItem> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? color,
    Expression<String>? season,
    Expression<String>? imagePath,
    Expression<String>? notes,
    Expression<String>? emoji,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (color != null) 'color': color,
      if (season != null) 'season': season,
      if (imagePath != null) 'image_path': imagePath,
      if (notes != null) 'notes': notes,
      if (emoji != null) 'emoji': emoji,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClothingItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? category,
      Value<String>? color,
      Value<String>? season,
      Value<String?>? imagePath,
      Value<String?>? notes,
      Value<String>? emoji,
      Value<int>? rowid}) {
    return ClothingItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      color: color ?? this.color,
      season: season ?? this.season,
      imagePath: imagePath ?? this.imagePath,
      notes: notes ?? this.notes,
      emoji: emoji ?? this.emoji,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (season.present) {
      map['season'] = Variable<String>(season.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClothingItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('color: $color, ')
          ..write('season: $season, ')
          ..write('imagePath: $imagePath, ')
          ..write('notes: $notes, ')
          ..write('emoji: $emoji, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutfitsTable extends Outfits with TableInfo<$OutfitsTable, Outfit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutfitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _topIdMeta = const VerificationMeta('topId');
  @override
  late final GeneratedColumn<String> topId = GeneratedColumn<String>(
      'top_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bottomIdMeta =
      const VerificationMeta('bottomId');
  @override
  late final GeneratedColumn<String> bottomId = GeneratedColumn<String>(
      'bottom_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shoesIdMeta =
      const VerificationMeta('shoesId');
  @override
  late final GeneratedColumn<String> shoesId = GeneratedColumn<String>(
      'shoes_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _accessoryIdMeta =
      const VerificationMeta('accessoryId');
  @override
  late final GeneratedColumn<String> accessoryId = GeneratedColumn<String>(
      'accessory_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _topNameMeta =
      const VerificationMeta('topName');
  @override
  late final GeneratedColumn<String> topName = GeneratedColumn<String>(
      'top_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _bottomNameMeta =
      const VerificationMeta('bottomName');
  @override
  late final GeneratedColumn<String> bottomName = GeneratedColumn<String>(
      'bottom_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _shoesNameMeta =
      const VerificationMeta('shoesName');
  @override
  late final GeneratedColumn<String> shoesName = GeneratedColumn<String>(
      'shoes_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _topEmojiMeta =
      const VerificationMeta('topEmoji');
  @override
  late final GeneratedColumn<String> topEmoji = GeneratedColumn<String>(
      'top_emoji', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('👕'));
  static const VerificationMeta _bottomEmojiMeta =
      const VerificationMeta('bottomEmoji');
  @override
  late final GeneratedColumn<String> bottomEmoji = GeneratedColumn<String>(
      'bottom_emoji', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('👖'));
  static const VerificationMeta _shoesEmojiMeta =
      const VerificationMeta('shoesEmoji');
  @override
  late final GeneratedColumn<String> shoesEmoji = GeneratedColumn<String>(
      'shoes_emoji', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('👟'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        topId,
        bottomId,
        shoesId,
        accessoryId,
        topName,
        bottomName,
        shoesName,
        topEmoji,
        bottomEmoji,
        shoesEmoji,
        createdAt,
        isFavorite
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outfits';
  @override
  VerificationContext validateIntegrity(Insertable<Outfit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('top_id')) {
      context.handle(
          _topIdMeta, topId.isAcceptableOrUnknown(data['top_id']!, _topIdMeta));
    } else if (isInserting) {
      context.missing(_topIdMeta);
    }
    if (data.containsKey('bottom_id')) {
      context.handle(_bottomIdMeta,
          bottomId.isAcceptableOrUnknown(data['bottom_id']!, _bottomIdMeta));
    } else if (isInserting) {
      context.missing(_bottomIdMeta);
    }
    if (data.containsKey('shoes_id')) {
      context.handle(_shoesIdMeta,
          shoesId.isAcceptableOrUnknown(data['shoes_id']!, _shoesIdMeta));
    } else if (isInserting) {
      context.missing(_shoesIdMeta);
    }
    if (data.containsKey('accessory_id')) {
      context.handle(
          _accessoryIdMeta,
          accessoryId.isAcceptableOrUnknown(
              data['accessory_id']!, _accessoryIdMeta));
    }
    if (data.containsKey('top_name')) {
      context.handle(_topNameMeta,
          topName.isAcceptableOrUnknown(data['top_name']!, _topNameMeta));
    }
    if (data.containsKey('bottom_name')) {
      context.handle(
          _bottomNameMeta,
          bottomName.isAcceptableOrUnknown(
              data['bottom_name']!, _bottomNameMeta));
    }
    if (data.containsKey('shoes_name')) {
      context.handle(_shoesNameMeta,
          shoesName.isAcceptableOrUnknown(data['shoes_name']!, _shoesNameMeta));
    }
    if (data.containsKey('top_emoji')) {
      context.handle(_topEmojiMeta,
          topEmoji.isAcceptableOrUnknown(data['top_emoji']!, _topEmojiMeta));
    }
    if (data.containsKey('bottom_emoji')) {
      context.handle(
          _bottomEmojiMeta,
          bottomEmoji.isAcceptableOrUnknown(
              data['bottom_emoji']!, _bottomEmojiMeta));
    }
    if (data.containsKey('shoes_emoji')) {
      context.handle(
          _shoesEmojiMeta,
          shoesEmoji.isAcceptableOrUnknown(
              data['shoes_emoji']!, _shoesEmojiMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Outfit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Outfit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      topId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}top_id'])!,
      bottomId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bottom_id'])!,
      shoesId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shoes_id'])!,
      accessoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}accessory_id']),
      topName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}top_name'])!,
      bottomName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bottom_name'])!,
      shoesName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shoes_name'])!,
      topEmoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}top_emoji'])!,
      bottomEmoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bottom_emoji'])!,
      shoesEmoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shoes_emoji'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
    );
  }

  @override
  $OutfitsTable createAlias(String alias) {
    return $OutfitsTable(attachedDatabase, alias);
  }
}

class Outfit extends DataClass implements Insertable<Outfit> {
  final String id;
  final String name;
  final String topId;
  final String bottomId;
  final String shoesId;
  final String? accessoryId;
  final String topName;
  final String bottomName;
  final String shoesName;
  final String topEmoji;
  final String bottomEmoji;
  final String shoesEmoji;
  final DateTime createdAt;
  final bool isFavorite;
  const Outfit(
      {required this.id,
      required this.name,
      required this.topId,
      required this.bottomId,
      required this.shoesId,
      this.accessoryId,
      required this.topName,
      required this.bottomName,
      required this.shoesName,
      required this.topEmoji,
      required this.bottomEmoji,
      required this.shoesEmoji,
      required this.createdAt,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['top_id'] = Variable<String>(topId);
    map['bottom_id'] = Variable<String>(bottomId);
    map['shoes_id'] = Variable<String>(shoesId);
    if (!nullToAbsent || accessoryId != null) {
      map['accessory_id'] = Variable<String>(accessoryId);
    }
    map['top_name'] = Variable<String>(topName);
    map['bottom_name'] = Variable<String>(bottomName);
    map['shoes_name'] = Variable<String>(shoesName);
    map['top_emoji'] = Variable<String>(topEmoji);
    map['bottom_emoji'] = Variable<String>(bottomEmoji);
    map['shoes_emoji'] = Variable<String>(shoesEmoji);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  OutfitsCompanion toCompanion(bool nullToAbsent) {
    return OutfitsCompanion(
      id: Value(id),
      name: Value(name),
      topId: Value(topId),
      bottomId: Value(bottomId),
      shoesId: Value(shoesId),
      accessoryId: accessoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(accessoryId),
      topName: Value(topName),
      bottomName: Value(bottomName),
      shoesName: Value(shoesName),
      topEmoji: Value(topEmoji),
      bottomEmoji: Value(bottomEmoji),
      shoesEmoji: Value(shoesEmoji),
      createdAt: Value(createdAt),
      isFavorite: Value(isFavorite),
    );
  }

  factory Outfit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Outfit(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      topId: serializer.fromJson<String>(json['topId']),
      bottomId: serializer.fromJson<String>(json['bottomId']),
      shoesId: serializer.fromJson<String>(json['shoesId']),
      accessoryId: serializer.fromJson<String?>(json['accessoryId']),
      topName: serializer.fromJson<String>(json['topName']),
      bottomName: serializer.fromJson<String>(json['bottomName']),
      shoesName: serializer.fromJson<String>(json['shoesName']),
      topEmoji: serializer.fromJson<String>(json['topEmoji']),
      bottomEmoji: serializer.fromJson<String>(json['bottomEmoji']),
      shoesEmoji: serializer.fromJson<String>(json['shoesEmoji']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'topId': serializer.toJson<String>(topId),
      'bottomId': serializer.toJson<String>(bottomId),
      'shoesId': serializer.toJson<String>(shoesId),
      'accessoryId': serializer.toJson<String?>(accessoryId),
      'topName': serializer.toJson<String>(topName),
      'bottomName': serializer.toJson<String>(bottomName),
      'shoesName': serializer.toJson<String>(shoesName),
      'topEmoji': serializer.toJson<String>(topEmoji),
      'bottomEmoji': serializer.toJson<String>(bottomEmoji),
      'shoesEmoji': serializer.toJson<String>(shoesEmoji),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  Outfit copyWith(
          {String? id,
          String? name,
          String? topId,
          String? bottomId,
          String? shoesId,
          Value<String?> accessoryId = const Value.absent(),
          String? topName,
          String? bottomName,
          String? shoesName,
          String? topEmoji,
          String? bottomEmoji,
          String? shoesEmoji,
          DateTime? createdAt,
          bool? isFavorite}) =>
      Outfit(
        id: id ?? this.id,
        name: name ?? this.name,
        topId: topId ?? this.topId,
        bottomId: bottomId ?? this.bottomId,
        shoesId: shoesId ?? this.shoesId,
        accessoryId: accessoryId.present ? accessoryId.value : this.accessoryId,
        topName: topName ?? this.topName,
        bottomName: bottomName ?? this.bottomName,
        shoesName: shoesName ?? this.shoesName,
        topEmoji: topEmoji ?? this.topEmoji,
        bottomEmoji: bottomEmoji ?? this.bottomEmoji,
        shoesEmoji: shoesEmoji ?? this.shoesEmoji,
        createdAt: createdAt ?? this.createdAt,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  Outfit copyWithCompanion(OutfitsCompanion data) {
    return Outfit(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      topId: data.topId.present ? data.topId.value : this.topId,
      bottomId: data.bottomId.present ? data.bottomId.value : this.bottomId,
      shoesId: data.shoesId.present ? data.shoesId.value : this.shoesId,
      accessoryId:
          data.accessoryId.present ? data.accessoryId.value : this.accessoryId,
      topName: data.topName.present ? data.topName.value : this.topName,
      bottomName:
          data.bottomName.present ? data.bottomName.value : this.bottomName,
      shoesName: data.shoesName.present ? data.shoesName.value : this.shoesName,
      topEmoji: data.topEmoji.present ? data.topEmoji.value : this.topEmoji,
      bottomEmoji:
          data.bottomEmoji.present ? data.bottomEmoji.value : this.bottomEmoji,
      shoesEmoji:
          data.shoesEmoji.present ? data.shoesEmoji.value : this.shoesEmoji,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Outfit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('topId: $topId, ')
          ..write('bottomId: $bottomId, ')
          ..write('shoesId: $shoesId, ')
          ..write('accessoryId: $accessoryId, ')
          ..write('topName: $topName, ')
          ..write('bottomName: $bottomName, ')
          ..write('shoesName: $shoesName, ')
          ..write('topEmoji: $topEmoji, ')
          ..write('bottomEmoji: $bottomEmoji, ')
          ..write('shoesEmoji: $shoesEmoji, ')
          ..write('createdAt: $createdAt, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      topId,
      bottomId,
      shoesId,
      accessoryId,
      topName,
      bottomName,
      shoesName,
      topEmoji,
      bottomEmoji,
      shoesEmoji,
      createdAt,
      isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Outfit &&
          other.id == this.id &&
          other.name == this.name &&
          other.topId == this.topId &&
          other.bottomId == this.bottomId &&
          other.shoesId == this.shoesId &&
          other.accessoryId == this.accessoryId &&
          other.topName == this.topName &&
          other.bottomName == this.bottomName &&
          other.shoesName == this.shoesName &&
          other.topEmoji == this.topEmoji &&
          other.bottomEmoji == this.bottomEmoji &&
          other.shoesEmoji == this.shoesEmoji &&
          other.createdAt == this.createdAt &&
          other.isFavorite == this.isFavorite);
}

class OutfitsCompanion extends UpdateCompanion<Outfit> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> topId;
  final Value<String> bottomId;
  final Value<String> shoesId;
  final Value<String?> accessoryId;
  final Value<String> topName;
  final Value<String> bottomName;
  final Value<String> shoesName;
  final Value<String> topEmoji;
  final Value<String> bottomEmoji;
  final Value<String> shoesEmoji;
  final Value<DateTime> createdAt;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const OutfitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.topId = const Value.absent(),
    this.bottomId = const Value.absent(),
    this.shoesId = const Value.absent(),
    this.accessoryId = const Value.absent(),
    this.topName = const Value.absent(),
    this.bottomName = const Value.absent(),
    this.shoesName = const Value.absent(),
    this.topEmoji = const Value.absent(),
    this.bottomEmoji = const Value.absent(),
    this.shoesEmoji = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OutfitsCompanion.insert({
    required String id,
    required String name,
    required String topId,
    required String bottomId,
    required String shoesId,
    this.accessoryId = const Value.absent(),
    this.topName = const Value.absent(),
    this.bottomName = const Value.absent(),
    this.shoesName = const Value.absent(),
    this.topEmoji = const Value.absent(),
    this.bottomEmoji = const Value.absent(),
    this.shoesEmoji = const Value.absent(),
    required DateTime createdAt,
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        topId = Value(topId),
        bottomId = Value(bottomId),
        shoesId = Value(shoesId),
        createdAt = Value(createdAt);
  static Insertable<Outfit> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? topId,
    Expression<String>? bottomId,
    Expression<String>? shoesId,
    Expression<String>? accessoryId,
    Expression<String>? topName,
    Expression<String>? bottomName,
    Expression<String>? shoesName,
    Expression<String>? topEmoji,
    Expression<String>? bottomEmoji,
    Expression<String>? shoesEmoji,
    Expression<DateTime>? createdAt,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (topId != null) 'top_id': topId,
      if (bottomId != null) 'bottom_id': bottomId,
      if (shoesId != null) 'shoes_id': shoesId,
      if (accessoryId != null) 'accessory_id': accessoryId,
      if (topName != null) 'top_name': topName,
      if (bottomName != null) 'bottom_name': bottomName,
      if (shoesName != null) 'shoes_name': shoesName,
      if (topEmoji != null) 'top_emoji': topEmoji,
      if (bottomEmoji != null) 'bottom_emoji': bottomEmoji,
      if (shoesEmoji != null) 'shoes_emoji': shoesEmoji,
      if (createdAt != null) 'created_at': createdAt,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OutfitsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? topId,
      Value<String>? bottomId,
      Value<String>? shoesId,
      Value<String?>? accessoryId,
      Value<String>? topName,
      Value<String>? bottomName,
      Value<String>? shoesName,
      Value<String>? topEmoji,
      Value<String>? bottomEmoji,
      Value<String>? shoesEmoji,
      Value<DateTime>? createdAt,
      Value<bool>? isFavorite,
      Value<int>? rowid}) {
    return OutfitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      topId: topId ?? this.topId,
      bottomId: bottomId ?? this.bottomId,
      shoesId: shoesId ?? this.shoesId,
      accessoryId: accessoryId ?? this.accessoryId,
      topName: topName ?? this.topName,
      bottomName: bottomName ?? this.bottomName,
      shoesName: shoesName ?? this.shoesName,
      topEmoji: topEmoji ?? this.topEmoji,
      bottomEmoji: bottomEmoji ?? this.bottomEmoji,
      shoesEmoji: shoesEmoji ?? this.shoesEmoji,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (topId.present) {
      map['top_id'] = Variable<String>(topId.value);
    }
    if (bottomId.present) {
      map['bottom_id'] = Variable<String>(bottomId.value);
    }
    if (shoesId.present) {
      map['shoes_id'] = Variable<String>(shoesId.value);
    }
    if (accessoryId.present) {
      map['accessory_id'] = Variable<String>(accessoryId.value);
    }
    if (topName.present) {
      map['top_name'] = Variable<String>(topName.value);
    }
    if (bottomName.present) {
      map['bottom_name'] = Variable<String>(bottomName.value);
    }
    if (shoesName.present) {
      map['shoes_name'] = Variable<String>(shoesName.value);
    }
    if (topEmoji.present) {
      map['top_emoji'] = Variable<String>(topEmoji.value);
    }
    if (bottomEmoji.present) {
      map['bottom_emoji'] = Variable<String>(bottomEmoji.value);
    }
    if (shoesEmoji.present) {
      map['shoes_emoji'] = Variable<String>(shoesEmoji.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutfitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('topId: $topId, ')
          ..write('bottomId: $bottomId, ')
          ..write('shoesId: $shoesId, ')
          ..write('accessoryId: $accessoryId, ')
          ..write('topName: $topName, ')
          ..write('bottomName: $bottomName, ')
          ..write('shoesName: $shoesName, ')
          ..write('topEmoji: $topEmoji, ')
          ..write('bottomEmoji: $bottomEmoji, ')
          ..write('shoesEmoji: $shoesEmoji, ')
          ..write('createdAt: $createdAt, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlannerEntriesTable extends PlannerEntries
    with TableInfo<$PlannerEntriesTable, PlannerEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlannerEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _outfitIdMeta =
      const VerificationMeta('outfitId');
  @override
  late final GeneratedColumn<String> outfitId = GeneratedColumn<String>(
      'outfit_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _outfitNameMeta =
      const VerificationMeta('outfitName');
  @override
  late final GeneratedColumn<String> outfitName = GeneratedColumn<String>(
      'outfit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, date, outfitId, outfitName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'planner_entries';
  @override
  VerificationContext validateIntegrity(Insertable<PlannerEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('outfit_id')) {
      context.handle(_outfitIdMeta,
          outfitId.isAcceptableOrUnknown(data['outfit_id']!, _outfitIdMeta));
    }
    if (data.containsKey('outfit_name')) {
      context.handle(
          _outfitNameMeta,
          outfitName.isAcceptableOrUnknown(
              data['outfit_name']!, _outfitNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlannerEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlannerEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      outfitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}outfit_id']),
      outfitName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}outfit_name']),
    );
  }

  @override
  $PlannerEntriesTable createAlias(String alias) {
    return $PlannerEntriesTable(attachedDatabase, alias);
  }
}

class PlannerEntry extends DataClass implements Insertable<PlannerEntry> {
  final String id;
  final DateTime date;
  final String? outfitId;
  final String? outfitName;
  const PlannerEntry(
      {required this.id, required this.date, this.outfitId, this.outfitName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || outfitId != null) {
      map['outfit_id'] = Variable<String>(outfitId);
    }
    if (!nullToAbsent || outfitName != null) {
      map['outfit_name'] = Variable<String>(outfitName);
    }
    return map;
  }

  PlannerEntriesCompanion toCompanion(bool nullToAbsent) {
    return PlannerEntriesCompanion(
      id: Value(id),
      date: Value(date),
      outfitId: outfitId == null && nullToAbsent
          ? const Value.absent()
          : Value(outfitId),
      outfitName: outfitName == null && nullToAbsent
          ? const Value.absent()
          : Value(outfitName),
    );
  }

  factory PlannerEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlannerEntry(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      outfitId: serializer.fromJson<String?>(json['outfitId']),
      outfitName: serializer.fromJson<String?>(json['outfitName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'outfitId': serializer.toJson<String?>(outfitId),
      'outfitName': serializer.toJson<String?>(outfitName),
    };
  }

  PlannerEntry copyWith(
          {String? id,
          DateTime? date,
          Value<String?> outfitId = const Value.absent(),
          Value<String?> outfitName = const Value.absent()}) =>
      PlannerEntry(
        id: id ?? this.id,
        date: date ?? this.date,
        outfitId: outfitId.present ? outfitId.value : this.outfitId,
        outfitName: outfitName.present ? outfitName.value : this.outfitName,
      );
  PlannerEntry copyWithCompanion(PlannerEntriesCompanion data) {
    return PlannerEntry(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      outfitId: data.outfitId.present ? data.outfitId.value : this.outfitId,
      outfitName:
          data.outfitName.present ? data.outfitName.value : this.outfitName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlannerEntry(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('outfitId: $outfitId, ')
          ..write('outfitName: $outfitName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, outfitId, outfitName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlannerEntry &&
          other.id == this.id &&
          other.date == this.date &&
          other.outfitId == this.outfitId &&
          other.outfitName == this.outfitName);
}

class PlannerEntriesCompanion extends UpdateCompanion<PlannerEntry> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String?> outfitId;
  final Value<String?> outfitName;
  final Value<int> rowid;
  const PlannerEntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.outfitId = const Value.absent(),
    this.outfitName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlannerEntriesCompanion.insert({
    required String id,
    required DateTime date,
    this.outfitId = const Value.absent(),
    this.outfitName = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date);
  static Insertable<PlannerEntry> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? outfitId,
    Expression<String>? outfitName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (outfitId != null) 'outfit_id': outfitId,
      if (outfitName != null) 'outfit_name': outfitName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlannerEntriesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<String?>? outfitId,
      Value<String?>? outfitName,
      Value<int>? rowid}) {
    return PlannerEntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      outfitId: outfitId ?? this.outfitId,
      outfitName: outfitName ?? this.outfitName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (outfitId.present) {
      map['outfit_id'] = Variable<String>(outfitId.value);
    }
    if (outfitName.present) {
      map['outfit_name'] = Variable<String>(outfitName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlannerEntriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('outfitId: $outfitId, ')
          ..write('outfitName: $outfitName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClothingItemsTable clothingItems = $ClothingItemsTable(this);
  late final $OutfitsTable outfits = $OutfitsTable(this);
  late final $PlannerEntriesTable plannerEntries = $PlannerEntriesTable(this);
  late final ClothingDao clothingDao = ClothingDao(this as AppDatabase);
  late final OutfitDao outfitDao = OutfitDao(this as AppDatabase);
  late final PlannerDao plannerDao = PlannerDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [clothingItems, outfits, plannerEntries];
}

typedef $$ClothingItemsTableCreateCompanionBuilder = ClothingItemsCompanion
    Function({
  required String id,
  required String name,
  required String category,
  required String color,
  required String season,
  Value<String?> imagePath,
  Value<String?> notes,
  Value<String> emoji,
  Value<int> rowid,
});
typedef $$ClothingItemsTableUpdateCompanionBuilder = ClothingItemsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> category,
  Value<String> color,
  Value<String> season,
  Value<String?> imagePath,
  Value<String?> notes,
  Value<String> emoji,
  Value<int> rowid,
});

class $$ClothingItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ClothingItemsTable> {
  $$ClothingItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get season => $composableBuilder(
      column: $table.season, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnFilters(column));
}

class $$ClothingItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClothingItemsTable> {
  $$ClothingItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get season => $composableBuilder(
      column: $table.season, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnOrderings(column));
}

class $$ClothingItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClothingItemsTable> {
  $$ClothingItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);
}

class $$ClothingItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClothingItemsTable,
    ClothingItem,
    $$ClothingItemsTableFilterComposer,
    $$ClothingItemsTableOrderingComposer,
    $$ClothingItemsTableAnnotationComposer,
    $$ClothingItemsTableCreateCompanionBuilder,
    $$ClothingItemsTableUpdateCompanionBuilder,
    (
      ClothingItem,
      BaseReferences<_$AppDatabase, $ClothingItemsTable, ClothingItem>
    ),
    ClothingItem,
    PrefetchHooks Function()> {
  $$ClothingItemsTableTableManager(_$AppDatabase db, $ClothingItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClothingItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClothingItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClothingItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> color = const Value.absent(),
            Value<String> season = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> emoji = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClothingItemsCompanion(
            id: id,
            name: name,
            category: category,
            color: color,
            season: season,
            imagePath: imagePath,
            notes: notes,
            emoji: emoji,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String category,
            required String color,
            required String season,
            Value<String?> imagePath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> emoji = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClothingItemsCompanion.insert(
            id: id,
            name: name,
            category: category,
            color: color,
            season: season,
            imagePath: imagePath,
            notes: notes,
            emoji: emoji,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ClothingItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClothingItemsTable,
    ClothingItem,
    $$ClothingItemsTableFilterComposer,
    $$ClothingItemsTableOrderingComposer,
    $$ClothingItemsTableAnnotationComposer,
    $$ClothingItemsTableCreateCompanionBuilder,
    $$ClothingItemsTableUpdateCompanionBuilder,
    (
      ClothingItem,
      BaseReferences<_$AppDatabase, $ClothingItemsTable, ClothingItem>
    ),
    ClothingItem,
    PrefetchHooks Function()>;
typedef $$OutfitsTableCreateCompanionBuilder = OutfitsCompanion Function({
  required String id,
  required String name,
  required String topId,
  required String bottomId,
  required String shoesId,
  Value<String?> accessoryId,
  Value<String> topName,
  Value<String> bottomName,
  Value<String> shoesName,
  Value<String> topEmoji,
  Value<String> bottomEmoji,
  Value<String> shoesEmoji,
  required DateTime createdAt,
  Value<bool> isFavorite,
  Value<int> rowid,
});
typedef $$OutfitsTableUpdateCompanionBuilder = OutfitsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> topId,
  Value<String> bottomId,
  Value<String> shoesId,
  Value<String?> accessoryId,
  Value<String> topName,
  Value<String> bottomName,
  Value<String> shoesName,
  Value<String> topEmoji,
  Value<String> bottomEmoji,
  Value<String> shoesEmoji,
  Value<DateTime> createdAt,
  Value<bool> isFavorite,
  Value<int> rowid,
});

class $$OutfitsTableFilterComposer
    extends Composer<_$AppDatabase, $OutfitsTable> {
  $$OutfitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get topId => $composableBuilder(
      column: $table.topId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bottomId => $composableBuilder(
      column: $table.bottomId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shoesId => $composableBuilder(
      column: $table.shoesId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accessoryId => $composableBuilder(
      column: $table.accessoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get topName => $composableBuilder(
      column: $table.topName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bottomName => $composableBuilder(
      column: $table.bottomName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shoesName => $composableBuilder(
      column: $table.shoesName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get topEmoji => $composableBuilder(
      column: $table.topEmoji, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bottomEmoji => $composableBuilder(
      column: $table.bottomEmoji, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shoesEmoji => $composableBuilder(
      column: $table.shoesEmoji, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));
}

class $$OutfitsTableOrderingComposer
    extends Composer<_$AppDatabase, $OutfitsTable> {
  $$OutfitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get topId => $composableBuilder(
      column: $table.topId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bottomId => $composableBuilder(
      column: $table.bottomId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shoesId => $composableBuilder(
      column: $table.shoesId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accessoryId => $composableBuilder(
      column: $table.accessoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get topName => $composableBuilder(
      column: $table.topName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bottomName => $composableBuilder(
      column: $table.bottomName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shoesName => $composableBuilder(
      column: $table.shoesName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get topEmoji => $composableBuilder(
      column: $table.topEmoji, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bottomEmoji => $composableBuilder(
      column: $table.bottomEmoji, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shoesEmoji => $composableBuilder(
      column: $table.shoesEmoji, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));
}

class $$OutfitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutfitsTable> {
  $$OutfitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get topId =>
      $composableBuilder(column: $table.topId, builder: (column) => column);

  GeneratedColumn<String> get bottomId =>
      $composableBuilder(column: $table.bottomId, builder: (column) => column);

  GeneratedColumn<String> get shoesId =>
      $composableBuilder(column: $table.shoesId, builder: (column) => column);

  GeneratedColumn<String> get accessoryId => $composableBuilder(
      column: $table.accessoryId, builder: (column) => column);

  GeneratedColumn<String> get topName =>
      $composableBuilder(column: $table.topName, builder: (column) => column);

  GeneratedColumn<String> get bottomName => $composableBuilder(
      column: $table.bottomName, builder: (column) => column);

  GeneratedColumn<String> get shoesName =>
      $composableBuilder(column: $table.shoesName, builder: (column) => column);

  GeneratedColumn<String> get topEmoji =>
      $composableBuilder(column: $table.topEmoji, builder: (column) => column);

  GeneratedColumn<String> get bottomEmoji => $composableBuilder(
      column: $table.bottomEmoji, builder: (column) => column);

  GeneratedColumn<String> get shoesEmoji => $composableBuilder(
      column: $table.shoesEmoji, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);
}

class $$OutfitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OutfitsTable,
    Outfit,
    $$OutfitsTableFilterComposer,
    $$OutfitsTableOrderingComposer,
    $$OutfitsTableAnnotationComposer,
    $$OutfitsTableCreateCompanionBuilder,
    $$OutfitsTableUpdateCompanionBuilder,
    (Outfit, BaseReferences<_$AppDatabase, $OutfitsTable, Outfit>),
    Outfit,
    PrefetchHooks Function()> {
  $$OutfitsTableTableManager(_$AppDatabase db, $OutfitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutfitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutfitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutfitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> topId = const Value.absent(),
            Value<String> bottomId = const Value.absent(),
            Value<String> shoesId = const Value.absent(),
            Value<String?> accessoryId = const Value.absent(),
            Value<String> topName = const Value.absent(),
            Value<String> bottomName = const Value.absent(),
            Value<String> shoesName = const Value.absent(),
            Value<String> topEmoji = const Value.absent(),
            Value<String> bottomEmoji = const Value.absent(),
            Value<String> shoesEmoji = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OutfitsCompanion(
            id: id,
            name: name,
            topId: topId,
            bottomId: bottomId,
            shoesId: shoesId,
            accessoryId: accessoryId,
            topName: topName,
            bottomName: bottomName,
            shoesName: shoesName,
            topEmoji: topEmoji,
            bottomEmoji: bottomEmoji,
            shoesEmoji: shoesEmoji,
            createdAt: createdAt,
            isFavorite: isFavorite,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String topId,
            required String bottomId,
            required String shoesId,
            Value<String?> accessoryId = const Value.absent(),
            Value<String> topName = const Value.absent(),
            Value<String> bottomName = const Value.absent(),
            Value<String> shoesName = const Value.absent(),
            Value<String> topEmoji = const Value.absent(),
            Value<String> bottomEmoji = const Value.absent(),
            Value<String> shoesEmoji = const Value.absent(),
            required DateTime createdAt,
            Value<bool> isFavorite = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OutfitsCompanion.insert(
            id: id,
            name: name,
            topId: topId,
            bottomId: bottomId,
            shoesId: shoesId,
            accessoryId: accessoryId,
            topName: topName,
            bottomName: bottomName,
            shoesName: shoesName,
            topEmoji: topEmoji,
            bottomEmoji: bottomEmoji,
            shoesEmoji: shoesEmoji,
            createdAt: createdAt,
            isFavorite: isFavorite,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OutfitsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OutfitsTable,
    Outfit,
    $$OutfitsTableFilterComposer,
    $$OutfitsTableOrderingComposer,
    $$OutfitsTableAnnotationComposer,
    $$OutfitsTableCreateCompanionBuilder,
    $$OutfitsTableUpdateCompanionBuilder,
    (Outfit, BaseReferences<_$AppDatabase, $OutfitsTable, Outfit>),
    Outfit,
    PrefetchHooks Function()>;
typedef $$PlannerEntriesTableCreateCompanionBuilder = PlannerEntriesCompanion
    Function({
  required String id,
  required DateTime date,
  Value<String?> outfitId,
  Value<String?> outfitName,
  Value<int> rowid,
});
typedef $$PlannerEntriesTableUpdateCompanionBuilder = PlannerEntriesCompanion
    Function({
  Value<String> id,
  Value<DateTime> date,
  Value<String?> outfitId,
  Value<String?> outfitName,
  Value<int> rowid,
});

class $$PlannerEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $PlannerEntriesTable> {
  $$PlannerEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get outfitId => $composableBuilder(
      column: $table.outfitId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get outfitName => $composableBuilder(
      column: $table.outfitName, builder: (column) => ColumnFilters(column));
}

class $$PlannerEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PlannerEntriesTable> {
  $$PlannerEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get outfitId => $composableBuilder(
      column: $table.outfitId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get outfitName => $composableBuilder(
      column: $table.outfitName, builder: (column) => ColumnOrderings(column));
}

class $$PlannerEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlannerEntriesTable> {
  $$PlannerEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get outfitId =>
      $composableBuilder(column: $table.outfitId, builder: (column) => column);

  GeneratedColumn<String> get outfitName => $composableBuilder(
      column: $table.outfitName, builder: (column) => column);
}

class $$PlannerEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlannerEntriesTable,
    PlannerEntry,
    $$PlannerEntriesTableFilterComposer,
    $$PlannerEntriesTableOrderingComposer,
    $$PlannerEntriesTableAnnotationComposer,
    $$PlannerEntriesTableCreateCompanionBuilder,
    $$PlannerEntriesTableUpdateCompanionBuilder,
    (
      PlannerEntry,
      BaseReferences<_$AppDatabase, $PlannerEntriesTable, PlannerEntry>
    ),
    PlannerEntry,
    PrefetchHooks Function()> {
  $$PlannerEntriesTableTableManager(
      _$AppDatabase db, $PlannerEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlannerEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlannerEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlannerEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> outfitId = const Value.absent(),
            Value<String?> outfitName = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlannerEntriesCompanion(
            id: id,
            date: date,
            outfitId: outfitId,
            outfitName: outfitName,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime date,
            Value<String?> outfitId = const Value.absent(),
            Value<String?> outfitName = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlannerEntriesCompanion.insert(
            id: id,
            date: date,
            outfitId: outfitId,
            outfitName: outfitName,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlannerEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlannerEntriesTable,
    PlannerEntry,
    $$PlannerEntriesTableFilterComposer,
    $$PlannerEntriesTableOrderingComposer,
    $$PlannerEntriesTableAnnotationComposer,
    $$PlannerEntriesTableCreateCompanionBuilder,
    $$PlannerEntriesTableUpdateCompanionBuilder,
    (
      PlannerEntry,
      BaseReferences<_$AppDatabase, $PlannerEntriesTable, PlannerEntry>
    ),
    PlannerEntry,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClothingItemsTableTableManager get clothingItems =>
      $$ClothingItemsTableTableManager(_db, _db.clothingItems);
  $$OutfitsTableTableManager get outfits =>
      $$OutfitsTableTableManager(_db, _db.outfits);
  $$PlannerEntriesTableTableManager get plannerEntries =>
      $$PlannerEntriesTableTableManager(_db, _db.plannerEntries);
}
