import 'package:social/features/feeds/domain/repositories/feeds_repository.dart';

import '../entities/comment_entity.dart';

class FetchCommentsUseCase {
  final FeedRepository repository;

  FetchCommentsUseCase(this.repository);

  Future<List<CommentEntity>> call(String feedId) {
    return repository.getComments(feedId);
  }
}
