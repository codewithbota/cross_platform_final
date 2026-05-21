import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' show Value;
import '../../../data/local/database.dart' as local_db;
import '../../../domain/models/clothing_item.dart';
import '../../providers/database_provider.dart';
import '../../widgets/clothing_item_thumbnail.dart';

class OutfitBuilderScreen extends ConsumerStatefulWidget {
  const OutfitBuilderScreen({super.key});
  @override
  ConsumerState<OutfitBuilderScreen> createState() =>
      _OutfitBuilderScreenState();
}

class _OutfitBuilderScreenState extends ConsumerState<OutfitBuilderScreen> {
  int _step = 0; // 0=Top 1=Bottom 2=Shoes 3=Accessory
  final Map<int, ClothingItem?> _selected = {
    0: null, 1: null, 2: null, 3: null
  };
  final _nameCtrl = TextEditingController();
  bool _saving = false;

  static const _stepLabels = ['Top', 'Bottom', 'Shoes', 'Extras'];
  static const _stepEmojis = ['👕', '👖', '👟', '✨'];
  static const _mainCategories = ['Tops', 'Bottoms', 'Shoes'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  bool get _canSave =>
      _nameCtrl.text.trim().isNotEmpty &&
      _selected[0] != null &&
      _selected[1] != null &&
      _selected[2] != null;

  Future<void> _save() async {
    if (!_canSave) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Добавь название, верх, низ и обувь'),
            backgroundColor: Colors.redAccent),
      );
      return;
    }

    setState(() => _saving = true);

    try {
      final db = ref.read(databaseProvider);
      final top = _selected[0]!;
      final bottom = _selected[1]!;
      final shoes = _selected[2]!;
      final acc = _selected[3];

      await db.outfitDao.insertOutfit(local_db.OutfitsCompanion(
        id: Value(const Uuid().v4()),
        name: Value(_nameCtrl.text.trim()),
        topId: Value(top.id),
        bottomId: Value(bottom.id),
        shoesId: Value(shoes.id),
        accessoryId: Value(acc?.id),
        topName: Value(top.name),
        bottomName: Value(bottom.name),
        shoesName: Value(shoes.name),
        topEmoji: Value(top.emoji),
        bottomEmoji: Value(bottom.emoji),
        shoesEmoji: Value(shoes.emoji),
        topImagePath: Value(top.imagePath),
        bottomImagePath: Value(bottom.imagePath),
        shoesImagePath: Value(shoes.imagePath),
        createdAt: Value(DateTime.now()),
      ));

      if (mounted) {
        final name = _nameCtrl.text.trim();
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Outfit "$name" saved! 👗'),
              backgroundColor: const Color(0xFF8B7BA8)),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(clothingItemsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Build Outfit ✨'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: (_canSave && !_saving) ? _save : null,
              child: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Color(0xFF8B7BA8)))
                  : Text('Save',
                      style: TextStyle(
                          color: _canSave
                              ? const Color(0xFF8B7BA8)
                              : Colors.grey.shade400,
                          fontWeight: FontWeight.w700,
                          fontSize: 15)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Outfit name
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _nameCtrl,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Outfit name...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFFB8A9C9))),
              ),
            ),
          ),

          // Step tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: List.generate(4, (i) {
                final done = _selected[i] != null;
                final active = _step == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _step = i),
                    child: Container(
                      margin: EdgeInsets.only(right: i < 3 ? 8 : 0),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: active
                            ? const Color(0xFFB8A9C9)
                            : done
                                ? const Color(0xFFB8A9C9)
                                    .withAlpha((0.15 * 255).round())
                                : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: active
                                ? const Color(0xFFB8A9C9)
                                : Colors.grey.shade200),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_stepEmojis[i],
                              style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 2),
                          Text(_stepLabels[i],
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: active
                                      ? Colors.white
                                      : Colors.grey[600])),
                          if (done)
                            Icon(Icons.check_circle_rounded,
                                size: 12,
                                color: active
                                    ? Colors.white70
                                    : const Color(0xFF8B7BA8)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          if (_selected[_step] != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: const Color(0xFFB8A9C9)
                        .withAlpha((0.12 * 255).round()),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    ClothingItemThumbnail(
                      imagePath: _selected[_step]!.imagePath,
                      emoji: _selected[_step]!.emoji,
                      size: 40,
                      borderRadius: 8,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(_selected[_step]!.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500))),
                    GestureDetector(
                      onTap: () =>
                          setState(() => _selected[_step] = null),
                      child: const Icon(Icons.close_rounded,
                          color: Colors.grey, size: 18),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 8),

          // Progress hint
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  _step == 3
                      ? 'Optional extras'
                      : 'Choose ${_stepLabels[_step]}',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text(
                  '${_selected.values.where((v) => v != null).length}/3 required',
                  style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: itemsAsync.when(
              data: (all) {
                final items = _step == 3
                    ? all
                        .where((i) => !_mainCategories.contains(i.category))
                        .toList()
                    : all
                        .where((i) =>
                            i.category ==
                            (_step == 0
                                ? 'Tops'
                                : _step == 1
                                    ? 'Bottoms'
                                    : 'Shoes'))
                        .toList();
                final emptyLabel = _step == 3
                    ? 'No extra items in closet'
                    : 'No ${_stepLabels[_step]} in closet — add some first!';
                if (items.isEmpty) {
                  return Center(
                      child: Text(emptyLabel,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[400])));
                }
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 4),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final item = items[i];
                    final isSelected = _selected[_step]?.id == item.id;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selected[_step] = item),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFB8A9C9)
                                  .withAlpha((0.18 * 255).round())
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFB8A9C9)
                                  : Colors.transparent,
                              width: 2),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black
                                    .withAlpha((0.04 * 255).round()),
                                blurRadius: 6,
                                offset: const Offset(0, 2))
                          ],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClothingItemThumbnail(
                                      imagePath: item.imagePath,
                                      emoji: item.emoji,
                                      size: 64,
                                      borderRadius: 10,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(item.name,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF8B7BA8),
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.check_rounded,
                                      color: Colors.white, size: 11),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
