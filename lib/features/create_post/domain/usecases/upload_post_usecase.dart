import 'package:uuid/uuid.dart';
import '../../../login/domain/repositories/auth_repository.dart';
import '../entities/post_entity.dart';
import '../repositories/create_post_repository.dart';

class UploadPostUseCase {
  final CreatePostRepository repository;
  final AuthRepository authRepository;
  UploadPostUseCase(this.repository, this.authRepository);

  Future<void> call({required String imageUrl, required String caption}) async {
    final currentUserId = await authRepository.getUserId() ?? '';

    final post = PostEntity(
      id: const Uuid().v4(),
      userId: currentUserId,
      imageUrl: imageUrl,
      caption: caption,
      createdAt: DateTime.now(),
      likesCount: 0,
      commentsCount: 0,
    );

    await repository.uploadPost(post);
  }
}
