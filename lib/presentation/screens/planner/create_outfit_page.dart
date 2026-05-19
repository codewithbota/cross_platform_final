// lib/presentation/screens/planner/create_outfit_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' show Value;
import '../../../data/local/database.dart' as local_db;
import '../../../domain/models/clothing_item.dart';
import '../../providers/database_provider.dart';

class CreateOutfitPage extends ConsumerStatefulWidget {
  const CreateOutfitPage({super.key});
  @override
  ConsumerState<CreateOutfitPage> createState() =>
      _CreateOutfitPageState();
}

class _CreateOutfitPageState extends ConsumerState<CreateOutfitPage> {
  String? _selectedItemId;
  ClothingItem? _selectedItem;
  final _nameCtrl = TextEditingController();
  String _filter = 'All';
  bool _saving = false;

  final List<String> _categories = [
    'All', 'Tops', 'Bottoms', 'Shoes', 'Bags', 'Accessories', 'Outerwear'
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  bool get _canSave =>
      _selectedItemId != null && _nameCtrl.text.trim().isNotEmpty;

  Future<void> _save() async {
    if (!_canSave || _selectedItem == null) return;
    setState(() => _saving = true);

    try {
      final db = ref.read(databaseProvider);
      await db.outfitDao.insertOutfit(local_db.OutfitsCompanion(
        id: Value(const Uuid().v4()),
        name: Value(_nameCtrl.text.trim()),
        topId: Value(_selectedItem!.id),
        bottomId: Value(_selectedItem!.id),
        shoesId: Value(_selectedItem!.id),
        accessoryId: const Value(null),
        topName: Value(_selectedItem!.name),
        bottomName: const Value(''),
        shoesName: const Value(''),
        topEmoji: Value(_selectedItem!.emoji),
        bottomEmoji: const Value(''),
        shoesEmoji: const Value(''),
        createdAt: Value(DateTime.now()),
      ));
      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Outfit "${_nameCtrl.text.trim()}" saved! 👗'),
              backgroundColor: const Color(0xFF8B7BA8)),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при сохранении: $e'),
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
        backgroundColor: const Color(0xFFFAF8F5),
        elevation: 0,
        leading: TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel',
              style: TextStyle(color: Colors.grey, fontSize: 15)),
        ),
        title: const Text('Create Outfit',
            style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
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
                          strokeWidth: 2,
                          color: Color(0xFF8B7BA8)))
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _nameCtrl,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Outfit name (e.g. Monday Look) 📅',
                hintStyle:
                    TextStyle(color: Colors.grey[400], fontSize: 14),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        BorderSide(color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                        color: Color(0xFFB8A9C9))),
              ),
            ),
          ),
          SizedBox(
            height: 46,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.fromLTRB(16, 10, 16, 0),
              itemCount: _categories.length,
              itemBuilder: (context, i) {
                final cat = _categories[i];
                final isActive = _filter == cat;
                return GestureDetector(
                  onTap: () => setState(() => _filter = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFFB8A9C9)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: isActive
                              ? const Color(0xFFB8A9C9)
                              : Colors.grey.shade200),
                    ),
                    child: Text(cat,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isActive
                                ? Colors.white
                                : Colors.grey[600])),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Select clothing',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 15)),
          ),
          Expanded(
            child: itemsAsync.when(
              data: (all) {
                final items = _filter == 'All'
                    ? all
                    : all
                        .where((i) => i.category == _filter)
                        .toList();
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    final isSelected = _selectedItemId == item.id;
                    return GestureDetector(
                      onTap: () => setState(() {
                        _selectedItemId = item.id;
                        _selectedItem = item;
                      }),
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
                                color:
                                    Colors.black.withAlpha((0.04 * 255).round()),
                                blurRadius: 6,
                                offset: const Offset(0, 2))
                          ],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Text(item.emoji,
                                      style: const TextStyle(
                                          fontSize: 34)),
                                  const SizedBox(height: 6),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 6),
                                    child: Text(item.name,
                                        textAlign:
                                            TextAlign.center,
                                        maxLines: 2,
                                        overflow:
                                            TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight:
                                                FontWeight.w500)),
                                  ),
                                  Text(item.category,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[400])),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF8B7BA8),
                                      shape: BoxShape.circle),
                                  child: const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 13),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(
                  child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text('Error: $e')),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}