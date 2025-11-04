import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/fetch_posts_usecase.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import '../../domain/usecases/get_comments_usecase.dart';
import '../../domain/usecases/like_posts_usescase.dart';
import 'feeds_event.dart';
import 'feeds_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FetchFeedsUseCase fetchFeedsUseCase;
  final LikeFeedUseCase likeFeedUseCase;
  final AddCommentUseCase addCommentUseCase;
  final FetchCommentsUseCase fetchCommentsUseCase;

  FeedBloc({required this.fetchFeedsUseCase, required this.likeFeedUseCase, required this.addCommentUseCase, required this.fetchCommentsUseCase})
    : super(FeedInitial()) {
    on<FetchFeedsEvent>(_onFetchFeeds);
    on<LikeFeedEvent>(_onLikeFeed);
    on<AddCommentEvent>(_onAddComment);
    on<FetchCommentsEvent>(_onFetchComments);
  }

  Future<void> _onFetchFeeds(FetchFeedsEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoading());
    try {
      final feeds = await fetchFeedsUseCase();
      emit(FeedLoaded(feeds));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }

  Future<void> _onLikeFeed(LikeFeedEvent event, Emitter<FeedState> emit) async {
    try {
      await likeFeedUseCase(event.like);
      // Optionally refresh feeds
      final feeds = await fetchFeedsUseCase();
      emit(FeedLoaded(feeds));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }

  Future<void> _onAddComment(AddCommentEvent event, Emitter<FeedState> emit) async {
    emit(CommentsLoading());
    try {
      await addCommentUseCase(event.comment);
      // Optionally refresh feeds
      final comments = await fetchCommentsUseCase(event.comment.feedId);
      emit(CommentsLoaded(feedId: event.comment.feedId, comments: comments));
      final feeds = await fetchFeedsUseCase();
      emit(FeedLoaded(feeds));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }

  Future<void> _onFetchComments(FetchCommentsEvent event, Emitter<FeedState> emit) async {
    emit(CommentsLoading());
    try {
      final comments = await fetchCommentsUseCase(event.feedId);
      emit(CommentsLoaded(feedId: event.feedId, comments: comments));
    } catch (e) {
      emit(CommentsError('Failed to load comments: $e'));
    }
  }
}
