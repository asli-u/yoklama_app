import 'dart:io';
import 'package:flutter/material.dart';

class PhotoPreviewScreen extends StatelessWidget {
  final String imagePath;

  const PhotoPreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fotoğraf Önizleme")),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}

// 📌 Bu ekran sadece fotoğrafın yolunu alır ve ekranda gösterir.