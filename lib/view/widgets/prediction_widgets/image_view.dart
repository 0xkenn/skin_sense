import 'dart:io';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String? imagePath;

  const ImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 30), // 30 margin on left and right
      child: SizedBox(
        height: 400, // Fixed height
        child: Image.file(
          File(imagePath ?? 'No Image Found'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
