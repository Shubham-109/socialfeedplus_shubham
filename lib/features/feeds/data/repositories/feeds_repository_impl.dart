import '../../../login/domain/repositories/auth_repository.dart';
import '../../domain/entities/feed_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/like_entity.dart';
import '../../domain/repositories/feeds_repository.dart';
import '../datasources/feeds_remote_data_source.dart';
import '../models/comment_model.dart';
import '../models/like_model.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;
  final AuthRepository authRepository;

  FeedRepositoryImpl({required this.remoteDataSource, required this.authRepository});

  @override
  Future<List<FeedEntity>> fetchFeeds() async {
    final currentUserId = await authRepository.getUserId() ?? '';
    final feedModels = await remoteDataSource.fetchFeeds(currentUserId);
    return feedModels.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> likeFeed(LikeEntity like) async {
    final currentUserId = await authRepository.getUserId() ?? '';
    final likeModel = LikeModel(userId: currentUserId, feedId: like.feedId, likedAt: like.likedAt);
    await remoteDataSource.likeFeed(likeModel);
  }

  @override
  Future<void> addComment(CommentEntity comment) async {
    final currentUserId = await authRepository.getUserId() ?? '';
    final commentModel = CommentModel(
      id: comment.id,
      feedId: comment.feedId,
      userId: currentUserId,
      text: comment.text,
      commentedAt: comment.commentedAt,
    );
    await remoteDataSource.addComment(commentModel);
  }

  @override
  Future<List<CommentEntity>> getComments(String feedId) async {
    final comments = await remoteDataSource.fetchComments(feedId);
    return comments.map((c) => c.toEntity()).toList();
  }
}
