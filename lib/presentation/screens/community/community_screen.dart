// lib/presentation/screens/community/community_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/models/community_post.dart';
import '../../providers/auth_provider.dart';
import '../../providers/community_provider.dart';
import '../../providers/database_provider.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(communityPostsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover 🌸'),
        actions: [
          IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {}),
        ],
      ),
      body: postsAsync.when(
        data: (posts) => _PostFeed(posts: posts),
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🌸', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              const Text('Community feed',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              Text('Connect Firebase to see posts',
                  style: TextStyle(color: Colors.grey[400])),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/community/create-post'),
        backgroundColor: const Color(0xFFB8A9C9),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Create Post',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _PostFeed extends ConsumerStatefulWidget {
  final List<CommunityPost> posts;
  const _PostFeed({required this.posts});
  @override
  ConsumerState<_PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends ConsumerState<_PostFeed> {
  @override
  Widget build(BuildContext context) {
    if (widget.posts.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🌸', style: TextStyle(fontSize: 56)),
            SizedBox(height: 12),
            Text('No posts yet',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 6),
            Text('Be the first to share your outfit!',
                style:
                    TextStyle(color: Color(0xFFB8A9C9))),
          ],
        ),
      );
    }

    final currentUserId = ref.read(currentUserProvider)?.uid;

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: widget.posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, i) {
        final post = widget.posts[i];
        return _PostCard(
          post: post,
          onToggleLike: () {
            if (currentUserId == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please sign in to like posts'),
                  backgroundColor: Colors.redAccent,
                ),
              );
              return;
            }
            final newLiked = !post.isLiked;
            final newLikes = (post.likes + (newLiked ? 1 : -1)).clamp(0, 9999999);
            setState(() {
              post.isLiked = newLiked;
              post.likes = newLikes;
            });
            ref
                .read(communityRepositoryProvider)
                .toggleLike(post.id, newLiked, newLikes, currentUserId);
          },
        );
      },
    );
  }
}

class _PostCard extends StatelessWidget {
  final CommunityPost post;
  final VoidCallback onToggleLike;
  const _PostCard(
      {required this.post, required this.onToggleLike});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).round()),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _Avatar(
                    letter: post.avatarLetter,
                    hexColor: post.avatarColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(post.username,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14)),
                        Text(post.userHandle,
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12)),
                      ]),
                ),
                Text(post.timeAgo,
                    style: TextStyle(
                        color: Colors.grey[400], fontSize: 12)),
              ],
            ),
          ),

          // Outfit preview
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF5F0F8), Color(0xFFFAF8F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(post.outfitName,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    _BigEmoji(emoji: post.topEmoji),
                    const SizedBox(width: 16),
                    _BigEmoji(emoji: post.bottomEmoji),
                    const SizedBox(width: 16),
                    _BigEmoji(emoji: post.shoesEmoji),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  children: post.items
                      .map((item) => Container(
                            padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFB8A9C9)
                                  .withAlpha((0.15 * 255).round()),
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            child: Text(item,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color:
                                        Color(0xFF8B7BA8))),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 10),
            child: Text(post.description,
                style: TextStyle(
                    color: Colors.grey[700], fontSize: 13)),
          ),

          // Like only
          Padding(
            padding: const EdgeInsets.only(
                left: 16, right: 16, bottom: 14),
            child: GestureDetector(
              onTap: onToggleLike,
              child: Row(
                children: [
                  AnimatedSwitcher(
                    duration:
                        const Duration(milliseconds: 200),
                    child: Icon(
                      post.isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      key: ValueKey(post.isLiked),
                      color: post.isLiked
                          ? Colors.redAccent
                          : Colors.grey[400],
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text('${post.likes}',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BigEmoji extends StatelessWidget {
  final String emoji;
  const _BigEmoji({required this.emoji});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha((0.06 * 255).round()),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Center(
          child:
              Text(emoji, style: const TextStyle(fontSize: 32))),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String letter;
  final String hexColor;
  const _Avatar(
      {required this.letter, required this.hexColor});

  Color _hexToColor(String hex) {
    final h = hex.replaceAll('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
          color: _hexToColor(hexColor).withAlpha((0.4 * 255).round()),
          shape: BoxShape.circle),
      child: Center(
          child: Text(letter,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: _hexToColor(hexColor)))),
    );
  }
}

