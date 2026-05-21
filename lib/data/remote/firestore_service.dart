// lib/data/remote/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/community_post.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ─── Posts ───────────────────────────────────────────────────────────────

  Stream<List<CommunityPost>> watchPosts(String? currentUserId) {
    return _db
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => CommunityPost.fromFirestore(
                doc.data(), doc.id,
                currentUserId: currentUserId))
            .toList());
  }

  Future<void> createPost(CommunityPost post) async {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      await Future.microtask(
          () => _db.collection('posts').add(post.toFirestore()));
    } else {
      await _db.collection('posts').add(post.toFirestore());
    }
  }

  Future<void> toggleLike(
      String postId, bool isLiked, int currentLikes, String userId) async {
    final safeLikes = currentLikes < 0 ? 0 : currentLikes;
    final docRef = _db.collection('posts').doc(postId);
    final data = {
      'likes': safeLikes,
      'likedBy': isLiked
          ? FieldValue.arrayUnion([userId])
          : FieldValue.arrayRemove([userId]),
    };

    if (defaultTargetPlatform == TargetPlatform.windows) {
      await Future.microtask(() => docRef.update(data));
    } else {
      await docRef.update(data);
    }
  }

  Future<void> deletePost(String postId) async {
    final docRef = _db.collection('posts').doc(postId);
    if (defaultTargetPlatform == TargetPlatform.windows) {
      await Future.microtask(() => docRef.delete());
    } else {
      await docRef.delete();
    }
  }

  // ─── Users ───────────────────────────────────────────────────────────────

  Future<void> createOrUpdateUser({
    required String userId,
    required String username,
    required String handle,
    String avatarColor = '#B8A9C9',
  }) async {
    final data = {
      'username': username,
      'handle': handle,
      'avatarColor': avatarColor,
    };
    if (defaultTargetPlatform == TargetPlatform.windows) {
      await Future.microtask(() => _db
          .collection('users')
          .doc(userId)
          .set(data, SetOptions(merge: true)));
    } else {
      await _db
          .collection('users')
          .doc(userId)
          .set(data, SetOptions(merge: true));
    }
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    return doc.data();
  }
}