class LikeEntity {
  final String? userId;
  final String feedId;
  final DateTime likedAt;

  const LikeEntity({this.userId, required this.feedId, required this.likedAt});
}
