import '../../domain/entities/post_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.userId,
    required super.imageUrl,
    required super.caption,
    required super.likesCount,
    required super.commentsCount,
    required super.createdAt,
  });

  /// Convert Firestore or API JSON into PostModel
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      caption: json['caption'] ?? '',
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      createdAt: (json['createdAt'] is Timestamp)
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// Convert PostModel to JSON for Firestore or API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'imageUrl': imageUrl,
      'caption': caption,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'createdAt': createdAt,
    };
  }

  /// Convert from Entity → Model (for Firestore upload)
  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
      id: entity.id,
      userId: entity.userId,
      imageUrl: entity.imageUrl,
      caption: entity.caption,
      likesCount: entity.likesCount,
      commentsCount: entity.commentsCount,
      createdAt: entity.createdAt,
    );
  }

  /// Convert from Model → Entity (for use cases)
  PostEntity toEntity() {
    return PostEntity(
      id: id,
      userId: userId,
      imageUrl: imageUrl,
      caption: caption,
      likesCount: likesCount,
      commentsCount: commentsCount,
      createdAt: createdAt,
    );
  }
}
