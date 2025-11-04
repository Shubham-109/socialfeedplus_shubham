import 'dart:io';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/create_post_repository.dart';
import '../datasources/create_post_remote_data_source.dart';
import '../models/post_model.dart';

class CreatePostRepositoryImpl implements CreatePostRepository {
  final CreatePostRemoteDataSource remoteDataSource;

  CreatePostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> uploadImage(File imageFile) async {
    return await remoteDataSource.uploadImageToFirebase(imageFile);
  }

  @override
  Future<String> generateCaption(String imageUrl) async {
    return await remoteDataSource.fetchCaptionFromApi(imageUrl);
  }

  @override
  Future<void> uploadPost(PostEntity post) async {
    final postModel = PostModel.fromEntity(post);
    await remoteDataSource.createPostInFirestore(postModel);
  }
}
