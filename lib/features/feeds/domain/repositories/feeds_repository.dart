import '../entities/feed_entity.dart';
import '../entities/comment_entity.dart';
import '../entities/like_entity.dart';

abstract class FeedRepository {
  Future<List<FeedEntity>> fetchFeeds();

  Future<void> likeFeed(LikeEntity like);

  Future<void> addComment(CommentEntity comment);

  Future<List<CommentEntity>> getComments(String feedId);
}
