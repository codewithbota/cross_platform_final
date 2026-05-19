import '../models/clothing_item.dart';

abstract class ClothingRepository {
  Stream<List<ClothingItem>> watchAllItems();
  Stream<List<ClothingItem>> watchItemsByCategory(String category);
  Future<void> addItem(ClothingItem item);
  Future<void> deleteItem(String id);
  Future<void> updateItem(ClothingItem item);
}