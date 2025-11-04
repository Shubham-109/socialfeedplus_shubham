import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/feed_model.dart';
import '../models/comment_model.dart';
import '../models/like_model.dart';

abstract class FeedRemoteDataSource {
  Future<List<FeedModel>> fetchFeeds(String currentUserId);
  Future<void> likeFeed(LikeModel like);
  Future<void> addComment(CommentModel comment);
  Future<List<CommentModel>> fetchComments(String feedId);
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final FirebaseFirestore firestore;

  FeedRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<FeedModel>> fetchFeeds(String currentUserId) async {
    final snapshot = await firestore.collection('feeds').orderBy('createdAt', descending: true).get();
    final likedDocs = await FirebaseFirestore.instance.collectionGroup('likes').where('userId', isEqualTo: currentUserId).get();
    final likedPostIds = likedDocs.docs.map((d) => d.reference.parent.parent!.id).toSet();
    return snapshot.docs.map((doc) {
      return FeedModel.fromJson({'id': doc.id, ...doc.data(), 'isLikedByCurrentUser': likedPostIds.contains(doc.id)});
    }).toList();
  }

  @override
  Future<void> likeFeed(LikeModel like) async {
    final feedRef = firestore.collection('feeds').doc(like.feedId);
    final likeRef = feedRef.collection('likes').doc(like.userId);

    final likeDoc = await likeRef.get();

    if (likeDoc.exists) {
      await likeRef.delete();
      await feedRef.update({'likesCount': FieldValue.increment(-1)});
    } else {
      await likeRef.set(like.toJson());
      await feedRef.update({'likesCount': FieldValue.increment(1)});
    }
  }

  @override
  Future<void> addComment(CommentModel comment) async {
    final feedRef = firestore.collection('feeds').doc(comment.feedId);
    final commentRef = feedRef.collection('comments').doc(comment.id);

    await commentRef.set(comment.toJson());
    await feedRef.update({'commentsCount': FieldValue.increment(1)});
  }

  @override
  Future<List<CommentModel>> fetchComments(String feedId) async {
    final commentsSnapshot = await firestore.collection('feeds').doc(feedId).collection('comments').orderBy('commentedAt', descending: true).get();
    return commentsSnapshot.docs.map((doc) => CommentModel.fromJson({'id': doc.id, ...doc.data()})).toList();
  }
}
