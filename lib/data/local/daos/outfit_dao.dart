import 'package:drift/drift.dart';
import '../database.dart';

part 'outfit_dao.g.dart';

@DriftAccessor(tables: [Outfits])
class OutfitDao extends DatabaseAccessor<AppDatabase> with _$OutfitDaoMixin {
  OutfitDao(super.db);

  Stream<List<Outfit>> watchAllOutfits() => select(outfits).watch();

  Future<void> insertOutfit(OutfitsCompanion outfit) =>
      into(outfits).insert(outfit);

  Future<void> deleteOutfit(String id) =>
      (delete(outfits)..where((t) => t.id.equals(id))).go();

  Future<void> toggleFavorite(String id, bool isFavorite) =>
      (update(outfits)..where((t) => t.id.equals(id)))
          .write(OutfitsCompanion(isFavorite: Value(isFavorite)));
}