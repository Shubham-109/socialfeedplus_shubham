class CommentEntity {
  final String id;
  final String feedId;
  final String userId;
  final String text;
  final DateTime commentedAt;

  const CommentEntity({required this.id, required this.feedId, required this.userId, required this.text, required this.commentedAt});
}
