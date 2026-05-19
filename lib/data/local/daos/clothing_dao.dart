import 'package:drift/drift.dart';
import '../database.dart';

part 'clothing_dao.g.dart';

@DriftAccessor(tables: [ClothingItems])
class ClothingDao extends DatabaseAccessor<AppDatabase>
    with _$ClothingDaoMixin {
  ClothingDao(super.db);

  Stream<List<ClothingItem>> watchAllItems() => select(clothingItems).watch();

  Stream<List<ClothingItem>> watchByCategory(String category) =>
      (select(clothingItems)
            ..where((t) => t.category.equals(category)))
          .watch();

  Future<void> insertItem(ClothingItemsCompanion item) =>
      into(clothingItems).insert(item);

  Future<void> updateItem(ClothingItemsCompanion item) =>
      (update(clothingItems)
            ..where((t) => t.id.equals(item.id.value)))
          .write(item);

  Future<void> deleteItem(String id) =>
      (delete(clothingItems)..where((t) => t.id.equals(id))).go();
}
