// lib/presentation/screens/planner/planner_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/models/outfit.dart';
import '../../providers/database_provider.dart';
import '../../providers/planner_provider.dart';

class PlannerScreen extends ConsumerStatefulWidget {
  const PlannerScreen({super.key});
  @override
  ConsumerState<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends ConsumerState<PlannerScreen> {
  int _selectedDayIndex = 0;

  static const _fullDays = [
    'Monday', 'Tuesday', 'Wednesday',
    'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];
  static const _dayIcons = [
    '💼', '📚', '☕', '🛍️', '🎉', '🌿', '🏠'
  ];

  @override
  Widget build(BuildContext context) {
    final planAsync = ref.watch(weekPlanProvider);
    final outfitsAsync = ref.watch(outfitsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Planner 📅'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/planner/create'),
        backgroundColor: const Color(0xFFB8A9C9),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Create Outfit',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: planAsync.when(
        data: (plan) {
          final selected = plan.length > _selectedDayIndex
              ? plan[_selectedDayIndex]
              : null;

          return Column(
            children: [
              // Day selector
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SizedBox(
                  height: 76,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: plan.length,
                    itemBuilder: (context, i) {
                      final isSelected = i == _selectedDayIndex;
                      final entry = plan[i];
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedDayIndex = i),
                        child: AnimatedContainer(
                          duration:
                              const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 10),
                          width: 56,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFB8A9C9)
                                : const Color(0xFFF5F0F8),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text(entry.dayLabel,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey[600])),
                              const SizedBox(height: 4),
                              Text(
                                entry.outfitId != null ? '✨' : '·',
                                style: TextStyle(
                                    fontSize:
                                        entry.outfitId != null
                                            ? 16
                                            : 20,
                                    color: isSelected
                                        ? Colors.white70
                                        : Colors.grey[400]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Day header
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            Text(
                                _dayIcons[_selectedDayIndex],
                                style: const TextStyle(
                                    fontSize: 28)),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                    _fullDays[_selectedDayIndex],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                            FontWeight.w600)),
                                Text(
                                    selected?.outfitId != null
                                        ? 'Outfit planned ✓'
                                        : 'No outfit yet',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: selected?.outfitId !=
                                                null
                                            ? const Color(
                                                0xFF8B7BA8)
                                            : Colors.grey[400])),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      if (selected != null &&
                          selected.outfitId != null) ...[
                        const Text('Planned Outfit',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        outfitsAsync.when(
                          data: (outfits) {
                            final outfit = outfits.firstWhere(
                              (o) => o.id == selected.outfitId,
                              orElse: () => Outfit(
                                id: '',
                                name: selected.outfitName ?? '',
                                topId: '',
                                bottomId: '',
                                shoesId: '',
                                createdAt: DateTime.now(),
                              ),
                            );
                            return _PlannedOutfitCard(
                              entry: selected,
                              outfit: outfit,
                              onRemove: () => ref
                                  .read(weekPlanProvider.notifier)
                                  .clearDay(selected.id),
                            );
                          },
                          loading: () =>
                              const CircularProgressIndicator(),
                          error: (_, __) => const SizedBox(),
                        ),
                      ] else
                        _EmptyDayCard(
                          onAdd: () =>
                              _showOutfitPicker(context, outfitsAsync.value ?? []),
                        ),

                      const SizedBox(height: 20),
                      const Text('Week Overview',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      ...List.generate(plan.length, (i) {
                        final entry = plan[i];
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedDayIndex = i),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: i == _selectedDayIndex
                                  ? const Color(0xFFB8A9C9)
                                      .withAlpha((0.1 * 255).round())
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.circular(14),
                              border: Border.all(
                                  color: i == _selectedDayIndex
                                      ? const Color(0xFFB8A9C9)
                                      : Colors.transparent),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 36,
                                  child: Text(entry.dayLabel,
                                      style: const TextStyle(
                                          fontWeight:
                                              FontWeight.w600,
                                          fontSize: 13)),
                                ),
                                const SizedBox(width: 12),
                                if (entry.outfitId != null) ...[
                                  const Text('✨',
                                      style:
                                          TextStyle(fontSize: 16)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                      child: Text(
                                          entry.outfitName ?? '',
                                          style: const TextStyle(
                                              fontSize: 14))),
                                ] else ...[
                                  Expanded(
                                      child: Text('No outfit',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.grey[400]))),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() =>
                                          _selectedDayIndex = i);
                                      _showOutfitPicker(context,
                                          outfitsAsync.value ?? []);
                                    },
                                    child: const Text('+ Add',
                                        style: TextStyle(
                                            color:
                                                Color(0xFF8B7BA8),
                                            fontSize: 13,
                                            fontWeight:
                                                FontWeight.w500)),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  void _showOutfitPicker(
      BuildContext context, List<Outfit> outfits) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: 400,
        decoration: const BoxDecoration(
          color: Color(0xFFFAF8F5),
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),
            const Text('Choose an Outfit',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Expanded(
              child: outfits.isEmpty
                  ? const Center(
                      child: Text('No outfits yet. Create one!'))
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16),
                      itemCount: outfits.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        final outfit = outfits[i];
                        return GestureDetector(
                          onTap: () {
                            final plan = ref
                                .read(weekPlanProvider)
                                .value;
                            if (plan != null &&
                                _selectedDayIndex <
                                    plan.length) {
                              ref
                                  .read(weekPlanProvider.notifier)
                                  .setOutfitForDay(
                                    plan[_selectedDayIndex].id,
                                    outfit.id,
                                    outfit.name,
                                  );
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(14)),
                            child: Row(
                              children: [
                                Text(outfit.topEmoji,
                                    style: const TextStyle(
                                        fontSize: 24)),
                                Text(outfit.bottomEmoji,
                                    style: const TextStyle(
                                        fontSize: 24)),
                                Text(outfit.shoesEmoji,
                                    style: const TextStyle(
                                        fontSize: 24)),
                                const SizedBox(width: 12),
                                Text(outfit.name,
                                    style: const TextStyle(
                                        fontWeight:
                                            FontWeight.w500)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlannedOutfitCard extends StatelessWidget {
  final dynamic entry;
  final Outfit outfit;
  final VoidCallback onRemove;
  const _PlannedOutfitCard(
      {required this.entry,
      required this.outfit,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).round()),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(outfit.name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600))),
              IconButton(
                  icon: const Icon(Icons.delete_outline_rounded,
                      color: Colors.redAccent, size: 20),
                  onPressed: onRemove),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _PieceChip(
                  emoji: outfit.topEmoji, label: outfit.top),
              _PieceChip(
                  emoji: outfit.bottomEmoji, label: outfit.bottom),
              _PieceChip(
                  emoji: outfit.shoesEmoji, label: outfit.shoes),
            ],
          ),
        ],
      ),
    );
  }
}

class _PieceChip extends StatelessWidget {
  final String emoji;
  final String label;
  const _PieceChip({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
              color: const Color(0xFFF5F0F8),
              borderRadius: BorderRadius.circular(14)),
          child: Center(
              child: Text(emoji,
                  style: const TextStyle(fontSize: 26))),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 68,
          child: Text(label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10)),
        ),
      ],
    );
  }
}

class _EmptyDayCard extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyDayCard({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFB8A9C9).withAlpha((0.08 * 255).round()),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: const Color(0xFFB8A9C9).withAlpha((0.3 * 255).round())),
        ),
        child: const Column(
          children: [
            Text('👗', style: TextStyle(fontSize: 36)),
            SizedBox(height: 8),
            Text('No outfit planned',
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500)),
            SizedBox(height: 4),
            Text('Tap to pick an outfit',
                style: TextStyle(
                    fontSize: 13, color: Color(0xFFB8A9C9))),
          ],
        ),
      ),
    );
  }
}

