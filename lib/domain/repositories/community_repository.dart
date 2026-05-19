import '../models/community_post.dart';

abstract class CommunityRepository {
  Stream<List<CommunityPost>> watchPosts(String? currentUserId);
  Future<void> createPost(CommunityPost post);
  Future<void> toggleLike(
      String postId, bool isLiked, int currentLikes, String userId);
}