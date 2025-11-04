import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostFeedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PostFeedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: const Color(0xFF1DA1F2),
      elevation: 6,
      splashColor: Colors.white.withOpacity(0.3),
      label: const Text(
        'Create Post',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
      ),
      icon: const Icon(FontAwesomeIcons.penToSquare, color: Colors.white),
    );
  }
}
