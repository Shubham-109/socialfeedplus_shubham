part of 'create_post_bloc.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object?> get props => [];
}

class SelectImageEvent extends CreatePostEvent {}

class GenerateCaptionEvent extends CreatePostEvent {}

class CaptionChangedEvent extends CreatePostEvent {
  final String caption;

  const CaptionChangedEvent(this.caption);

  @override
  List<Object?> get props => [caption];
}

class SubmitPostEvent extends CreatePostEvent {}
