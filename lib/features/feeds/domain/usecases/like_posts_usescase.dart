import '../entities/like_entity.dart';
import '../repositories/feeds_repository.dart';

class LikeFeedUseCase {
  final FeedRepository repository;

  LikeFeedUseCase(this.repository);

  Future<void> call(LikeEntity like) async {
    await repository.likeFeed(like);
  }
}
