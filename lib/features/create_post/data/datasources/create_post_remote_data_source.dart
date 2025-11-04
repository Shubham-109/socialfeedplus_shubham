import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../../core/constants/urls.dart';
import '../models/post_model.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

abstract class CreatePostRemoteDataSource {
  Future<String> uploadImageToFirebase(File imageFile);
  Future<String> fetchCaptionFromApi(String imageUrl);
  Future<void> createPostInFirestore(PostModel postModel);
}

class CreatePostRemoteDataSourceImpl implements CreatePostRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final String captionGeneratorApiKey = dotenv.env['CAPTION_GENERATOR_API_KEY']!;

  CreatePostRemoteDataSourceImpl({required this.firestore, required this.storage});

  @override
  Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      final ref = storage.ref().child('posts/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await ref.putFile(imageFile);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }

  @override
  Future<String> fetchCaptionFromApi(String imageUrl) async {
    try {
      final url = Uri.https(AppUrls.captionGeneratorApi, AppUrls.captionGeneratorEndpoint, {
        'imageUrl': imageUrl,
        'useEmojis': 'true',
        'useHashtags': 'true',
        'limit': '1',
      });

      final headers = {'X-RapidAPI-Key': captionGeneratorApiKey, 'X-RapidAPI-Host': AppUrls.captionGeneratorApi};
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final body = response.body;
        final data = json.decode(body);
        return data['captions'][0] ?? '';
      } else {
        throw Exception('Failed to generate caption');
      }
    } catch (e) {
      throw Exception('Caption API error: $e');
    }
  }

  @override
  Future<void> createPostInFirestore(PostModel postModel) async {
    try {
      await firestore.collection('feeds').doc(postModel.id).set(postModel.toJson());
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }
}
