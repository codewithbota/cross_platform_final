// lib/presentation/screens/community/create_post_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/models/clothing_item.dart';
import '../../widgets/clothing_item_thumbnail.dart';
import '../../../domain/models/community_post.dart';
import '../../providers/auth_provider.dart';
import '../../providers/database_provider.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});
  @override
  ConsumerState<CreatePostPage> createState() =>
      _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final List<ClothingItem> _selectedItems = [];
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  bool _posting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  bool get _canPost =>
      _selectedItems.length >= 2 && _nameCtrl.text.trim().isNotEmpty;

  /// Returns emoji for the given category, or the first item's emoji as fallback,
  /// or a default emoji if list is empty.
  String _emojiForCategory(String category, List<ClothingItem> items) {
    if (items.isEmpty) {
      switch (category) {
        case 'Tops': return '👕';
        case 'Bottoms': return '👖';
        case 'Shoes': return '👟';
        default: return '👗';
      }
    }
    final match = items.firstWhere(
      (item) => item.category == category,
      orElse: () => items.first,
    );
    return match.emoji;
  }

  Future<void> _post() async {
    if (!_canPost) return;
    setState(() => _posting = true);

    try {
      final user = ref.read(currentUserProvider);
      final selectedItems = List<ClothingItem>.from(_selectedItems);
      final topEmoji = _emojiForCategory('Tops', selectedItems);
      final bottomEmoji = _emojiForCategory('Bottoms', selectedItems);
      final shoesEmoji = _emojiForCategory('Shoes', selectedItems);
      
      // ✅ Get image paths from selected items
      final topImagePath = selectedItems
          .firstWhere(
            (item) => item.category == 'Tops',
            orElse: () => selectedItems.first,
          )
          .imagePath;
      final bottomImagePath = selectedItems
          .firstWhere(
            (item) => item.category == 'Bottoms',
            orElse: () => selectedItems.first,
          )
          .imagePath;
      final shoesImagePath = selectedItems
          .firstWhere(
            (item) => item.category == 'Shoes',
            orElse: () => selectedItems.first,
          )
          .imagePath;
      
      final post = CommunityPost(
        id: const Uuid().v4(),
        userId: user?.uid ?? 'anonymous',
        username: user?.email?.split('@').first ?? 'User',
        userHandle:
            '@${user?.email?.split('@').first ?? 'user'}.style',
        outfitName: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        items: selectedItems.map((item) => item.name).toList(),
        topEmoji: topEmoji,
        bottomEmoji: bottomEmoji,
        shoesEmoji: shoesEmoji,
        topImagePath: topImagePath,
        bottomImagePath: bottomImagePath,
        shoesImagePath: shoesImagePath,
        likes: 0,
        likedBy: const [],
        timeAgo: 'just now',
        avatarLetter: (user?.email ?? 'U').substring(0, 1).toUpperCase(),
        avatarColor: '#B8A9C9',
        createdAt: DateTime.now(),
      );

      await ref.read(communityRepositoryProvider).createPost(post);
      if (mounted) {
        setState(() => _posting = false);
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Post shared! 🌸'),
              backgroundColor: Color(0xFF8B7BA8)),
        );
      }
    } catch (error) {
      if (mounted) {
        setState(() => _posting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при публикации: $error'),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.grey),
          onPressed: () => context.pop(),
        ),
        title: const Text('Create Post',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: (_canPost && !_posting) ? _post : null,
              child: _posting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF8B7BA8)))
                  : Text('Post',
                      style: TextStyle(
                          color: _canPost
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
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _nameCtrl,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Outfit name (e.g. Sunday Brunch) ✨',
                hintStyle: TextStyle(
                    color: Colors.grey[400], fontSize: 14),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                        color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                        color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                        color: Color(0xFFB8A9C9))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _descCtrl,
              onChanged: (_) => setState(() {}),
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Caption (optional) 💬',
                hintStyle: TextStyle(
                    color: Colors.grey[400], fontSize: 14),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                        color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                        color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                        color: Color(0xFFB8A9C9))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select 2–3 clothing items',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15)),
                const SizedBox(height: 6),
                Text(
                  _selectedItems.isEmpty
                      ? 'Select at least 2 items to post'
                      : '${_selectedItems.length} / 3 selected',
                  style: TextStyle(
                      color: _selectedItems.isEmpty
                          ? Colors.orange.shade400
                          : Colors.grey[500],
                      fontSize: 13),
                ),
              ],
            ),
          ),
          if (_selectedItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _selectedItems
                    .map((item) => Chip(
                          label: Text(item.name),
                          avatar: Text(item.emoji),
                          onDeleted: () => setState(() {
                            _selectedItems
                                .removeWhere((selected) => selected.id == item.id);
                          }),
                        ))
                    .toList(),
              ),
            ),
          Expanded(
            child: itemsAsync.when(
              data: (items) => GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16),
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
                  final isSelected = _selectedItems
                      .any((selected) => selected.id == item.id);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        setState(() {
                          _selectedItems
                              .removeWhere((selected) => selected.id == item.id);
                        });
                      } else if (_selectedItems.length < 3) {
                        setState(() {
                          _selectedItems.add(item);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You can select up to 3 items'),
                            backgroundColor: Color(0xFF8B7BA8),
                          ),
                        );
                      }
                    },
                    child: AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 180),
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
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                // ✅ Show real photo if available
                                ClothingItemThumbnail(
                                  imagePath: item.imagePath,
                                  emoji: item.emoji,
                                  size: 60,
                                  borderRadius: 10,
                                ),
                                const SizedBox(height: 6),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 6),
                                  child: Text(item.name,
                                      textAlign:
                                          TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow
                                          .ellipsis,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight:
                                              FontWeight.w500)),
                                ),
                                Text(item.category,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color:
                                            Colors.grey[400])),
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
              ),
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