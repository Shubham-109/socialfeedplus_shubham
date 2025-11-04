import '../../domain/entities/like_entity.dart';

class LikeModel {
  final String userId;
  final String feedId;
  final DateTime likedAt;

  LikeModel({required this.userId, required this.feedId, required this.likedAt});

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      userId: json['userId'] ?? '',
      feedId: json['feedId'] ?? '',
      likedAt: (json['likedAt'] is int) ? DateTime.fromMillisecondsSinceEpoch(json['likedAt']) : DateTime.parse(json['likedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'feedId': feedId, 'likedAt': likedAt.millisecondsSinceEpoch};
  }

  LikeEntity toEntity() => LikeEntity(userId: userId, feedId: feedId, likedAt: likedAt);

  factory LikeModel.fromEntity(LikeEntity entity) {
    return LikeModel(userId: entity.userId ?? '', feedId: entity.feedId, likedAt: entity.likedAt);
  }
}
