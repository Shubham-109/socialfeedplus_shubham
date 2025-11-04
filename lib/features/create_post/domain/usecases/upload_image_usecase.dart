import 'dart:io';
import '../repositories/create_post_repository.dart';

class UploadImageUseCase {
  final CreatePostRepository repository;
  UploadImageUseCase(this.repository);

  Future<String> call({required File imageFile}) async {
    return await repository.uploadImage(imageFile);
  }
}
