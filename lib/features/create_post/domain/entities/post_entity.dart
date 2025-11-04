class PostEntity {
  final String id;
  final String userId;
  final String imageUrl;
  final String caption;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;

  const PostEntity({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.caption,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
  });
}
