import 'package:flutter/material.dart';

class UploadPostButton extends StatelessWidget {
  final Function? onPressed;

  const UploadPostButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed == null ? null : () => onPressed!(),
      icon: const Icon(Icons.cloud_upload_rounded, color: Colors.white),
      label: const Text(
        "Upload Post",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1DA1F2), // Twitter blue tone
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 6,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 26),
      ),
    );
  }
}
