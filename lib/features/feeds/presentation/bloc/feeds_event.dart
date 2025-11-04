import 'package:equatable/equatable.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/like_entity.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object?> get props => [];
}

class FetchFeedsEvent extends FeedEvent {}

class LikeFeedEvent extends FeedEvent {
  final LikeEntity like;

  const LikeFeedEvent(this.like);

  @override
  List<Object?> get props => [like];
}

class AddCommentEvent extends FeedEvent {
  final CommentEntity comment;

  const AddCommentEvent(this.comment);

  @override
  List<Object?> get props => [comment];
}

class FetchCommentsEvent extends FeedEvent {
  final String feedId;

  const FetchCommentsEvent(this.feedId);

  @override
  List<Object?> get props => [feedId];
}
