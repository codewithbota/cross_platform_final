import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/community_post.dart';
import '../../providers/auth_provider.dart';
import '../../providers/community_provider.dart';
import '../../providers/database_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});
  @override
  ConsumerState<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final itemsAsync = ref.watch(clothingItemsProvider);
    final outfitsAsync = ref.watch(outfitsProvider);
    final communityPostsAsync = ref.watch(communityPostsProvider);

    final username =
        user?.email?.split('@').first ?? 'User';
    final avatarLetter =
        username.substring(0, 1).toUpperCase();

    final likedPosts = communityPostsAsync.valueOrNull
            ?.where((p) => p.isLiked)
            .toList() ??
        [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: (){},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Avatar
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFB8A9C9),
                    Color(0xFF9BB8D4)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFFB8A9C9)
                          .withAlpha((0.4 * 255).round()),
                      blurRadius: 16,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Center(
                child: Text(avatarLetter,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 12),
            Text(username,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            Text('@$username.style',
                style: TextStyle(
                    color: Colors.grey[500], fontSize: 14)),
            const SizedBox(height: 16),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StatBadge(
                    count:
                        '${itemsAsync.valueOrNull?.length ?? 0}',
                    label: 'Items'),
                Container(
                    height: 30,
                    width: 1,
                    color: Colors.grey.shade200),
                _StatBadge(
                    count:
                        '${outfitsAsync.valueOrNull?.length ?? 0}',
                    label: 'Outfits'),
              ],
            ),
            const SizedBox(height: 16),

            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                    color: Color(0xFFB8A9C9)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 10),
              ),
              child: const Text('Edit Profile',
                  style:
                      TextStyle(color: Color(0xFF8B7BA8))),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: user == null
                  ? null
                  : () async {
                      await ref
                          .read(authNotifierProvider.notifier)
                          .signOut();
                    },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                    color: Color(0xFFE57373)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 10),
              ),
              child: const Text('Log Out',
                  style:
                      TextStyle(color: Color(0xFFE57373))),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.favorite_rounded,
                      color: Color(0xFFB8A9C9), size: 18),
                  const SizedBox(width: 6),
                  Text('Liked Posts (${likedPosts.length})',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            likedPosts.isEmpty
                ? const _EmptySection(
                    emoji: '💬',
                    message: 'No liked posts yet',
                    sub: 'Like community posts to save them here')
                : ListView.separated(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: likedPosts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) =>
                        _LikedPostCard(post: likedPosts[i]),
                  ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String count;
  final String label;
  const _StatBadge(
      {required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(children: [
        Text(count,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label,
            style: TextStyle(
                color: Colors.grey[500], fontSize: 12)),
      ]),
    );
  }
}

class _LikedPostCard extends StatelessWidget {
  final CommunityPost post;
  const _LikedPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F0F8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
                child: Text(post.topEmoji,
                    style: const TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.outfitName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text(post.items.join(', '),
                    style: TextStyle(
                        color: Colors.grey[500], fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const Icon(Icons.favorite_rounded,
              color: Color(0xFFEF5350), size: 20),
        ],
      ),
    );
  }
}

class _EmptySection extends StatelessWidget {
  final String emoji;
  final String message;
  final String sub;
  const _EmptySection(
      {required this.emoji,
      required this.message,
      required this.sub});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Text(emoji,
              style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text(message,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40),
            child: Text(sub,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[400], fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

