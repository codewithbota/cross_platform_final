import 'package:drift/drift.dart';
import '../database.dart';

part 'planner_dao.g.dart';

@DriftAccessor(tables: [PlannerEntries])
class PlannerDao extends DatabaseAccessor<AppDatabase> with _$PlannerDaoMixin {
  PlannerDao(super.db);

  Stream<List<PlannerEntry>> watchWeekEntries(DateTime start, DateTime end) =>
      (select(plannerEntries)
            ..where((t) =>
                t.date.isBiggerOrEqualValue(start) &
                t.date.isSmallerOrEqualValue(end)))
          .watch();

  Future<void> upsertEntry(PlannerEntriesCompanion entry) =>
      into(plannerEntries).insertOnConflictUpdate(entry);

  Future<void> clearEntry(String id) =>
      (update(plannerEntries)..where((t) => t.id.equals(id))).write(
          const PlannerEntriesCompanion(
              outfitId: Value(null), outfitName: Value(null)));
}