import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/generate_captions_usecase.dart';
import '../../domain/usecases/upload_image_usecase.dart';
import '../../domain/usecases/upload_post_usecase.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final GenerateCaptionUseCase generateCaptionUseCase;
  final UploadPostUseCase uploadPostUseCase;
  final UploadImageUseCase uploadImageUseCase;

  File? _selectedImage;
  String _caption = '';
  String _selectedImageUrl = '';

  CreatePostBloc({required this.generateCaptionUseCase, required this.uploadPostUseCase, required this.uploadImageUseCase})
    : super(CreatePostInitial()) {
    on<SelectImageEvent>(_onSelectImage);
    on<GenerateCaptionEvent>(_onGenerateCaption);
    on<CaptionChangedEvent>(_onCaptionChanged);
    on<SubmitPostEvent>(_onSubmitPost);
  }

  Future<void> _onSelectImage(SelectImageEvent event, Emitter<CreatePostState> emit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      emit(ImageUploadingState());
      _selectedImageUrl = await uploadImageUseCase(imageFile: _selectedImage!);
      emit(ImageSelectedState(image: _selectedImage!));
    } else {
      emit(CreatePostFailure('No image selected'));
    }
  }

  Future<void> _onGenerateCaption(GenerateCaptionEvent event, Emitter<CreatePostState> emit) async {
    emit(CaptionGenerating());
    if (_selectedImage == null) {
      emit(CreatePostFailure('Select an image first'));
      return;
    }

    emit(CaptionGenerating());

    try {
      final caption = await generateCaptionUseCase(_selectedImageUrl);
      _caption = caption;
      emit(CaptionGeneratedState(image: _selectedImage!, caption: caption));
    } catch (e) {
      emit(CreatePostFailure('Failed to generate caption: ${e.toString()}'));
    }
  }

  void _onCaptionChanged(CaptionChangedEvent event, Emitter<CreatePostState> emit) {
    _caption = event.caption;
    if (_selectedImage != null) {
      emit(CaptionGeneratedState(image: _selectedImage!, caption: _caption));
    } else {
      emit(CreatePostFailure('Image is required'));
    }
  }

  Future<void> _onSubmitPost(SubmitPostEvent event, Emitter<CreatePostState> emit) async {
    emit(PostSubmitting());

    if (_selectedImage == null || _caption.isEmpty) {
      emit(CreatePostFailure('Image and caption required'));
      return;
    }

    emit(PostSubmitting());

    try {
      await uploadPostUseCase(imageUrl: _selectedImageUrl, caption: _caption);
      emit(PostSuccess());
      _selectedImage = null;
      _selectedImageUrl = '';
    } catch (e) {
      emit(CreatePostFailure('Failed to create post: ${e.toString()}'));
    }
  }
}
