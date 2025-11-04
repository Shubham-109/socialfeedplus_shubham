import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social/features/create_post/presentation/pages/widgets/add_media_container.dart';
import 'package:social/features/create_post/presentation/pages/widgets/upload_post_button.dart';
import '../bloc/create_post_bloc.dart';
import 'widgets/caption_textfield.dart';
import 'widgets/generate_caption_button.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _captionController = TextEditingController();
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Post"), centerTitle: true),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocConsumer<CreatePostBloc, CreatePostState>(
          listener: (context, state) {
            if (state is CreatePostFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
            } else if (state is PostSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post uploaded successfully!")));
              Navigator.pop(context);
            } else if (state is CaptionGeneratedState) {
              _captionController.text = state.caption;
            } else if (state is ImageSelectedState) {
              _selectedImage = state.image;
            }
          },
          builder: (context, state) {
            final bool isLoading = state is CaptionGenerating || state is PostSubmitting;

            if (state is ImageUploadingState) {
              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.3, bottom: 10),
                      child: Lottie.asset(
                        'assets/animations/uploading_image.json',
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text("Uploading Image...", style: TextStyle(color: Colors.grey, fontSize: 16)),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image selector
                  AddMediaContainer(onTap: () => context.read<CreatePostBloc>().add(SelectImageEvent()), selectedImage: _selectedImage),
                  const SizedBox(height: 20),

                  // Caption field
                  CaptionTextField(
                    controller: _captionController,
                    onChanged: (value) {
                      context.read<CreatePostBloc>().add(CaptionChangedEvent(value));
                    },
                  ),
                  const SizedBox(height: 30),

                  // Generate Caption Button
                  isLoading
                      ? SizedBox()
                      : GenerateCaptionButton(
                          onPressed: () {
                            context.read<CreatePostBloc>().add(GenerateCaptionEvent());
                          },
                        ),

                  const SizedBox(height: 20),

                  // Upload Button
                  isLoading
                      ? SizedBox()
                      : UploadPostButton(
                          onPressed: () {
                            context.read<CreatePostBloc>().add(SubmitPostEvent());
                          },
                        ),

                  if (isLoading) ...[const SizedBox(height: 20), const Center(child: CircularProgressIndicator())],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }
}
