import 'package:equatable/equatable.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/feed_entity.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<FeedEntity> feeds;

  const FeedLoaded(this.feeds);

  @override
  List<Object?> get props => [feeds];
}

class FeedError extends FeedState {
  final String message;

  const FeedError(this.message);

  @override
  List<Object?> get props => [message];
}

class CommentsError extends FeedState {
  final String message;

  const CommentsError(this.message);

  @override
  List<Object?> get props => [message];
}

class CommentsLoading extends FeedState {}

class CommentsLoaded extends FeedState {
  final String feedId;
  final List<CommentEntity> comments;

  const CommentsLoaded({required this.feedId, required this.comments});

  @override
  List<Object?> get props => [feedId, comments];
}
