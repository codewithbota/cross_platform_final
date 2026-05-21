import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/planner_entry.dart';
import '../../data/local/database.dart' as local_db;
import 'database_provider.dart';

class WeekPlanNotifier
    extends StateNotifier<AsyncValue<List<PlannerEntry>>> {
  final local_db.AppDatabase _db;
  final _uuid = const Uuid();

  WeekPlanNotifier(this._db) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    final monday = _getMonday(DateTime.now());
    await _ensureWeekExists(monday);
    _db.plannerDao
        .watchWeekEntries(monday, monday.add(const Duration(days: 6)))
        .map((rows) => rows
            .map((r) => PlannerEntry(
                  id: r.id,
                  date: r.date,
                  outfitId: r.outfitId,
                  outfitName: r.outfitName,
                ))
            .toList())
        .listen(
          (entries) => state = AsyncValue.data(entries),
          onError: (e, st) => state = AsyncValue.error(e, st),
        );
  }

  Future<void> _ensureWeekExists(DateTime monday) async {
    // Create 7 entries for this week if they don't exist
    for (int i = 0; i < 7; i++) {
      final day = DateTime(
          monday.year, monday.month, monday.day + i);
      try {
        await _db.plannerDao.upsertEntry(local_db.PlannerEntriesCompanion.insert(
          id: _uuid.v4(),
          date: day,
        ));
      } catch (_) {
        // Entry already exists — skip
      }
    }
  }

  Future<void> setOutfitForDay(
      String entryId, String outfitId, String outfitName) async {
    await (_db.update(_db.plannerEntries)
          ..where((t) => t.id.equals(entryId)))
        .write(local_db.PlannerEntriesCompanion(
      outfitId: Value(outfitId),
      outfitName: Value(outfitName),
    ));
  }

  Future<void> clearDay(String entryId) async {
    await _db.plannerDao.clearEntry(entryId);
  }

  DateTime _getMonday(DateTime date) {
    final diff = date.weekday - 1;
    return DateTime(date.year, date.month, date.day - diff);
  }
}

final weekPlanProvider = StateNotifierProvider<WeekPlanNotifier,
    AsyncValue<List<PlannerEntry>>>((ref) {
  return WeekPlanNotifier(ref.watch(databaseProvider));
});
