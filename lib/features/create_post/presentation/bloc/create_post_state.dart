part of 'create_post_bloc.dart';

abstract class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object?> get props => [];
}

class CreatePostInitial extends CreatePostState {}

class ImageUploadingState extends CreatePostState {}

class ImageSelectedState extends CreatePostState {
  final File image;

  const ImageSelectedState({required this.image});

  @override
  List<Object?> get props => [image];
}

class CaptionGenerating extends CreatePostState {}

class CaptionGeneratedState extends CreatePostState {
  final File image;
  final String caption;

  const CaptionGeneratedState({required this.image, required this.caption});

  @override
  List<Object?> get props => [image, caption];
}

class PostSubmitting extends CreatePostState {}

class PostSuccess extends CreatePostState {}

class CreatePostFailure extends CreatePostState {
  final String message;

  const CreatePostFailure(this.message);

  @override
  List<Object?> get props => [message];
}
