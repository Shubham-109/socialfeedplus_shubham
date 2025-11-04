import 'package:flutter/material.dart';

class GenerateCaptionButton extends StatelessWidget {
  final Function? onPressed;

  const GenerateCaptionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed == null ? null : () => onPressed!(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF6A11CB), Color(0xFF2575FC)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: const Color(0xFF2575FC).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.auto_awesome, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Generate Caption with AI",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16, letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
