import '../repositories/create_post_repository.dart';

class GenerateCaptionUseCase {
  final CreatePostRepository repository;

  GenerateCaptionUseCase(this.repository);

  Future<String> call(String imageUrl) async {
    return await repository.generateCaption(imageUrl);
  }
}
