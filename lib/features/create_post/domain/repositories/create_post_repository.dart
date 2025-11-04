import 'dart:io';

import '../entities/post_entity.dart';

abstract class CreatePostRepository {
  Future<String> uploadImage(File imageFile);

  Future<String> generateCaption(String imageUrl);

  Future<void> uploadPost(PostEntity post);
}
