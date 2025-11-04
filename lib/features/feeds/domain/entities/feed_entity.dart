class FeedEntity {
  final String id;
  final String userId;
  final String caption;
  final String imageUrl;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;
  final bool isLikedByCurrentUser;

  const FeedEntity({
    required this.id,
    required this.userId,
    required this.caption,
    required this.imageUrl,
    required this.createdAt,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isLikedByCurrentUser = false,
  });
}
