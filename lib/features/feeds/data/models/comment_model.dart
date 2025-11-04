import '../../domain/entities/comment_entity.dart';

class CommentModel {
  final String id;
  final String feedId;
  final String userId;
  final String text;
  final DateTime commentedAt;

  CommentModel({required this.id, required this.feedId, required this.userId, required this.text, required this.commentedAt});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? '',
      feedId: json['feedId'] ?? '',
      userId: json['userId'] ?? '',
      text: json['text'] ?? '',
      commentedAt: (json['commentedAt'] is int) ? DateTime.fromMillisecondsSinceEpoch(json['commentedAt']) : DateTime.parse(json['commentedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'feedId': feedId, 'userId': userId, 'text': text, 'commentedAt': commentedAt.millisecondsSinceEpoch};
  }

  CommentEntity toEntity() => CommentEntity(id: id, feedId: feedId, userId: userId, text: text, commentedAt: commentedAt);

  factory CommentModel.fromEntity(CommentEntity entity) {
    return CommentModel(id: entity.id, feedId: entity.feedId, userId: entity.userId, text: entity.text, commentedAt: entity.commentedAt);
  }
}
