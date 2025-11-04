import '../entities/feed_entity.dart';
import '../repositories/feeds_repository.dart';

class FetchFeedsUseCase {
  final FeedRepository repository;

  FetchFeedsUseCase(this.repository);

  Future<List<FeedEntity>> call() async {
    return await repository.fetchFeeds();
  }
}
