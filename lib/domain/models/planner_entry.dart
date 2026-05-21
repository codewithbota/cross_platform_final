class PlannerEntry {
  final String id;
  final DateTime date;
  final String? outfitId;
  String? outfitName;

  PlannerEntry({
    required this.id,
    required this.date,
    this.outfitId,
    this.outfitName,
  });

  String get dayLabel {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  String get fullDayLabel {
    const days = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday'
    ];
    return days[date.weekday - 1];
  }
}
