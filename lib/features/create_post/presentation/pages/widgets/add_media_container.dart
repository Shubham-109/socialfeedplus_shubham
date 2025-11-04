import 'dart:io';

import 'package:flutter/material.dart';

class AddMediaContainer extends StatelessWidget {
  final Function? onTap;
  final File? _selectedImage;
  const AddMediaContainer({super.key, required this.onTap, File? selectedImage}) : _selectedImage = selectedImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).width * .6,
        padding: EdgeInsets.all(_selectedImage != null ? 0 : 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2C1A4A), // Deep purple tone
              Color(0xFF162347), // Deep blue tone
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white24, width: 1),
        ),
        child: _selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(_selectedImage, fit: BoxFit.cover),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Add media",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
      ),
    );
  }
}
