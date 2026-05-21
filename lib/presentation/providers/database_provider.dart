import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/database.dart' show AppDatabase;
import '../../data/repositories/clothing_repository_impl.dart';
import '../../data/repositories/community_repository_impl.dart';
import '../../data/remote/firestore_service.dart';
import '../../domain/models/clothing_item.dart';
import '../../domain/models/outfit.dart';
import '../../domain/repositories/clothing_repository.dart';

//Database singleton 
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

//Clothing 
final clothingRepositoryProvider = Provider<ClothingRepository>((ref) {
  return ClothingRepositoryImpl(ref.watch(databaseProvider));
});

final clothingItemsProvider = StreamProvider<List<ClothingItem>>((ref) {
  return ref.watch(clothingRepositoryProvider).watchAllItems();
});

//Outfits (from Drift)
final outfitsProvider = StreamProvider<List<Outfit>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.outfitDao.watchAllOutfits().map((rows) => rows
      .map((r) => Outfit(
            id: r.id,
            name: r.name,
            topId: r.topId,
            bottomId: r.bottomId,
            shoesId: r.shoesId,
            accessoryId: r.accessoryId,
            createdAt: r.createdAt,
            isFavorite: r.isFavorite,
            top: r.topName,
            bottom: r.bottomName,
            shoes: r.shoesName,
            topEmoji: r.topEmoji,
            bottomEmoji: r.bottomEmoji,
            shoesEmoji: r.shoesEmoji,
            topImagePath: r.topImagePath,
            bottomImagePath: r.bottomImagePath,
            shoesImagePath: r.shoesImagePath,
          ))
      .toList());
});

//Firestore / Community 
final firestoreServiceProvider =
    Provider<FirestoreService>((_) => FirestoreService());

final communityRepositoryProvider = Provider((ref) =>
    CommunityRepositoryImpl(ref.watch(firestoreServiceProvider)));
