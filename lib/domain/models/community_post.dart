class CommunityPost {
  final String id;
  final String userId;
  final String username;
  final String userHandle;
  final String outfitName;
  final String description;
  final List<String> items;
  final String topEmoji;
  final String bottomEmoji;
  final String shoesEmoji;
  int likes;
  bool isLiked;
  final List<String> likedBy;
  final String timeAgo;
  final String avatarLetter;
  final String avatarColor;
  final DateTime createdAt;

  CommunityPost({
    required this.id,
    required this.userId,
    required this.username,
    required this.userHandle,
    required this.outfitName,
    required this.description,
    required this.items,
    required this.topEmoji,
    required this.bottomEmoji,
    required this.shoesEmoji,
    required this.likes,
    this.isLiked = false,
    this.likedBy = const [],
    required this.timeAgo,
    required this.avatarLetter,
    required this.avatarColor,
    required this.createdAt,
  });

  factory CommunityPost.fromFirestore(
      Map<String, dynamic> data, String id,
      {String? currentUserId}) {
    final likedBy = List<String>.from(data['likedBy'] ?? []);
    return CommunityPost(
      id: id,
      userId: data['userId'] ?? '',
      username: data['username'] ?? '',
      userHandle: data['userHandle'] ?? '',
      outfitName: data['outfitName'] ?? '',
      description: data['description'] ?? '',
      items: List<String>.from(data['items'] ?? []),
      topEmoji: data['topEmoji'] ?? '👕',
      bottomEmoji: data['bottomEmoji'] ?? '👖',
      shoesEmoji: data['shoesEmoji'] ?? '👟',
      likes: data['likes'] ?? 0,
      isLiked: currentUserId != null && likedBy.contains(currentUserId),
      likedBy: likedBy,
      timeAgo: _timeAgo(data['createdAt']),
      avatarLetter: (data['username'] ?? 'U').substring(0, 1).toUpperCase(),
      avatarColor: data['avatarColor'] ?? '#B8A9C9',
      createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'username': username,
      'userHandle': userHandle,
      'outfitName': outfitName,
      'description': description,
      'items': items,
      'topEmoji': topEmoji,
      'bottomEmoji': bottomEmoji,
      'shoesEmoji': shoesEmoji,
      'likes': likes,
      'likedBy': likedBy,
      'avatarColor': avatarColor,
      'createdAt': createdAt,
    };
  }

  static String _timeAgo(dynamic timestamp) {
    if (timestamp == null) return 'just now';
    final date = timestamp.toDate() as DateTime;
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}