import '../../domain/models/community_post.dart';
import '../../domain/repositories/community_repository.dart';
import '../remote/firestore_service.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final FirestoreService _service;

  CommunityRepositoryImpl(this._service);

  @override
  Stream<List<CommunityPost>> watchPosts(String? currentUserId) =>
      _service.watchPosts(currentUserId);

  @override
  Future<void> createPost(CommunityPost post) => _service.createPost(post);

  @override
  Future<void> toggleLike(
          String postId, bool isLiked, int currentLikes, String userId) =>
      _service.toggleLike(postId, isLiked, currentLikes, userId);
}