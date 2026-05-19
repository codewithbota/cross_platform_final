import 'package:drift/drift.dart';
import 'daos/clothing_dao.dart';
import 'daos/outfit_dao.dart';
import 'daos/planner_dao.dart';
import 'database_connection.dart';

part 'database.g.dart';

// ─── Tables ──────────────────────────────────────────────────────────────────

class ClothingItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get color => text()();
  TextColumn get season => text()();
  TextColumn get imagePath => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get emoji => text().withDefault(const Constant('👕'))();

  @override
  Set<Column> get primaryKey => {id};
}

class Outfits extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get topId => text()();
  TextColumn get bottomId => text()();
  TextColumn get shoesId => text()();
  TextColumn get accessoryId => text().nullable()();
  TextColumn get topName => text().withDefault(const Constant(''))();
  TextColumn get bottomName => text().withDefault(const Constant(''))();
  TextColumn get shoesName => text().withDefault(const Constant(''))();
  TextColumn get topEmoji => text().withDefault(const Constant('👕'))();
  TextColumn get bottomEmoji => text().withDefault(const Constant('👖'))();
  TextColumn get shoesEmoji => text().withDefault(const Constant('👟'))();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class PlannerEntries extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get outfitId => text().nullable()();
  TextColumn get outfitName => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── Database ─────────────────────────────────────────────────────────────────

@DriftDatabase(
  tables: [ClothingItems, Outfits, PlannerEntries],
  daos: [ClothingDao, OutfitDao, PlannerDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(LazyDatabase(() async => openDatabaseConnection()));

  @override
  int get schemaVersion => 1;
}