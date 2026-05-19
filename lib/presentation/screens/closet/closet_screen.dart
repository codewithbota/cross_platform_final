
// lib/presentation/screens/closet/closet_screen.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/models/clothing_item.dart';
import '../../providers/database_provider.dart';

class ClosetScreen extends ConsumerStatefulWidget {
  const ClosetScreen({super.key});
  @override
  ConsumerState<ClosetScreen> createState() => _ClosetScreenState();
}

class _ClosetScreenState extends ConsumerState<ClosetScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> categories = [
    'All', 'Tops', 'Bottoms', 'Shoes', 'Bags', 'Accessories', 'Outerwear'
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allItemsAsync = ref.watch(clothingItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Closet 👚'),
        actions: [
          IconButton(
              icon: const Icon(Icons.search_rounded), onPressed: () {}),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: const Color(0xFF8B7BA8),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFFB8A9C9),
          indicatorWeight: 3,
          tabAlignment: TabAlignment.start,
          tabs: categories.map((c) => Tab(text: c)).toList(),
        ),
      ),
      body: allItemsAsync.when(
        data: (allItems) {
          return TabBarView(
            controller: _tabController,
            children: categories.map((cat) {
              final items = cat == 'All'
                  ? allItems
                  : allItems
                      .where((i) => i.category == cat)
                      .toList();
              if (items.isEmpty) {
                return _EmptyCategory(category: cat);
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                  if (index == items.length) {
                    return _AddItemCard(
                        onTap: () =>
                            context.go('/closet/add-item'));
                  }
                  return _ClothingCard(
                      item: items[index],
                      onDelete: () => _deleteItem(items[index].id));
                },
              );
            }).toList(),
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/closet/add-item'),
        backgroundColor: const Color(0xFFB8A9C9),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _deleteItem(String id) async {
    await ref.read(clothingRepositoryProvider).deleteItem(id);
  }
}

class _ClothingCard extends StatelessWidget {
  final ClothingItem item;
  final VoidCallback onDelete;
  const _ClothingCard({required this.item, required this.onDelete});

@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) => Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.delete_outline_rounded,
                      color: Colors.redAccent),
                  title: const Text('Delete item'),
                  onTap: () {
                    Navigator.pop(context);
                    onDelete();
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F0F8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: item.imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.file(File(item.imagePath!), fit: BoxFit.cover))
                  : Center(
                      child: Text(item.emoji,
                          style: const TextStyle(fontSize: 30))),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(item.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500)),
            ),
            const SizedBox(height: 2),
            Text(item.season,
                style:
                    TextStyle(fontSize: 10, color: Colors.grey[400])),
          ],
        ),
      ),
    );
  }
}

class _AddItemCard extends StatelessWidget {
  final VoidCallback onTap;
  const _AddItemCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFB8A9C9).withAlpha((0.1 * 255).round()),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: const Color(0xFFB8A9C9).withAlpha((0.4 * 255).round()),
              style: BorderStyle.solid),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline_rounded,
                color: Color(0xFFB8A9C9), size: 32),
            SizedBox(height: 6),
            Text('Add Item',
                style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFFB8A9C9),
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _EmptyCategory extends StatelessWidget {
  final String category;
  const _EmptyCategory({required this.category});

@override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🧺', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 12),
          Text('No $category yet',
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Text('Tap + to add your first item',
              style: TextStyle(color: Colors.grey[400])),
        ],
      ),
    );
  }
}
