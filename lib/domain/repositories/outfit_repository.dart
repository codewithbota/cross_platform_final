import '../models/outfit.dart';
import '../models/planner_entry.dart';

abstract class OutfitRepository {
  Stream<List<Outfit>> watchAllOutfits();
  Future<void> addOutfit(Outfit outfit);
  Future<void> deleteOutfit(String id);
  Future<void> toggleFavorite(String id, bool isFavorite);
}

abstract class PlannerRepository {
  Stream<List<PlannerEntry>> watchWeekPlan(DateTime weekStart);
  Future<void> setOutfitForDay(String plannerEntryId, String outfitId, String outfitName);
  Future<void> clearDay(String plannerEntryId);
  Future<List<PlannerEntry>> getOrCreateWeekPlan(DateTime weekStart);
}