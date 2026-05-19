import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';
import '../../domain/models/clothing_item.dart';
import '../../domain/repositories/clothing_repository.dart';
import '../local/database.dart' as local_db;

class ClothingRepositoryImpl implements ClothingRepository {
  final local_db.AppDatabase _db;
  final _uuid = const Uuid();

  ClothingRepositoryImpl(this._db);

  @override
  Stream<List<ClothingItem>> watchAllItems() {
    return _db.clothingDao.watchAllItems().map(
          (List<local_db.ClothingItem> rows) =>
              rows.map(_rowToModel).toList(),
        );
  }

  @override
  Stream<List<ClothingItem>> watchItemsByCategory(String category) {
    return _db.clothingDao.watchByCategory(category).map(
          (List<local_db.ClothingItem> rows) =>
              rows.map(_rowToModel).toList(),
        );
  }

  @override
  Future<void> addItem(ClothingItem item) async {
    await _db.clothingDao.insertItem(local_db.ClothingItemsCompanion(
      id: Value(item.id.isEmpty ? _uuid.v4() : item.id),
      name: Value(item.name),
      category: Value(item.category),
      color: Value(item.color),
      season: Value(item.season),
      imagePath: Value(item.imagePath),
      notes: Value(item.notes),
      emoji: Value(item.emoji),
    ));
  }

  @override
  Future<void> deleteItem(String id) => _db.clothingDao.deleteItem(id);

  @override
  Future<void> updateItem(ClothingItem item) async {
    await _db.clothingDao.updateItem(local_db.ClothingItemsCompanion(
      id: Value(item.id),
      name: Value(item.name),
      category: Value(item.category),
      color: Value(item.color),
      season: Value(item.season),
      imagePath: Value(item.imagePath),
      notes: Value(item.notes),
      emoji: Value(item.emoji),
    ));
  }

  ClothingItem _rowToModel(local_db.ClothingItem row) => ClothingItem(
        id: row.id,
        name: row.name,
        category: row.category,
        color: row.color,
        season: row.season,
        imagePath: row.imagePath,
        notes: row.notes,
        emoji: row.emoji,
      );
}