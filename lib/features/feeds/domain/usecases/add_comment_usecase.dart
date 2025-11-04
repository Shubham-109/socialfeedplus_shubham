import '../entities/comment_entity.dart';
import '../repositories/feeds_repository.dart';

class AddCommentUseCase {
  final FeedRepository repository;

  AddCommentUseCase(this.repository);

  Future<void> call(CommentEntity comment) async {
    await repository.addComment(comment);
  }
}
