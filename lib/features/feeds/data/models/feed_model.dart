import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/feed_entity.dart';

class FeedModel {
  final String id;
  final String userId;
  final String caption;
  final String imageUrl;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;
  final bool isLikedByCurrentUser;

  FeedModel({
    required this.id,
    required this.userId,
    required this.caption,
    required this.imageUrl,
    required this.createdAt,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isLikedByCurrentUser = false,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    DateTime createdAt;

    final rawCreatedAt = json['createdAt'];
    if (rawCreatedAt is Timestamp) {
      createdAt = rawCreatedAt.toDate();
    } else if (rawCreatedAt is int) {
      createdAt = DateTime.fromMillisecondsSinceEpoch(rawCreatedAt);
    } else if (rawCreatedAt is String) {
      createdAt = DateTime.tryParse(rawCreatedAt) ?? DateTime.now();
    } else {
      createdAt = DateTime.now();
    }

    return FeedModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      caption: json['caption'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createdAt: createdAt,
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      isLikedByCurrentUser: json['isLikedByCurrentUser'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'caption': caption,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'isLikedByCurrentUser': isLikedByCurrentUser,
    };
  }

  FeedModel copyWith({
    String? id,
    String? userId,
    String? caption,
    String? imageUrl,
    DateTime? createdAt,
    int? likesCount,
    int? commentsCount,
    bool? isLikedByCurrentUser,
  }) {
    return FeedModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      caption: caption ?? this.caption,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLikedByCurrentUser: isLikedByCurrentUser ?? this.isLikedByCurrentUser,
    );
  }

  FeedEntity toEntity() {
    return FeedEntity(
      id: id,
      userId: userId,
      caption: caption,
      imageUrl: imageUrl,
      createdAt: createdAt,
      likesCount: likesCount,
      commentsCount: commentsCount,
      isLikedByCurrentUser: isLikedByCurrentUser,
    );
  }

  factory FeedModel.fromEntity(FeedEntity entity) {
    return FeedModel(
      id: entity.id,
      userId: entity.userId,
      caption: entity.caption,
      imageUrl: entity.imageUrl,
      createdAt: entity.createdAt,
      likesCount: entity.likesCount,
      commentsCount: entity.commentsCount,
      isLikedByCurrentUser: entity.isLikedByCurrentUser,
    );
  }
}
