import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/community_post.dart';
import 'auth_provider.dart';
import 'database_provider.dart';

final communityPostsProvider = StreamProvider<List<CommunityPost>>((ref) {
  final currentUserId = ref.watch(currentUserProvider)?.uid;
  return ref.watch(communityRepositoryProvider).watchPosts(currentUserId);
});