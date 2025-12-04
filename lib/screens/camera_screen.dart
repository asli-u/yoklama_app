import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import '../models/student.dart';
import '../services/face_recognition_simulator.dart'; // EKLEDİK
import '../data/students_data.dart';

class CameraScreen extends StatefulWidget {
  final Student student;

  const CameraScreen({super.key, required this.student});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      await _controller!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print("Kamera açılamadı: $e");
    }
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized) return;

    final image = await _controller!.takePicture();

    final directory = await getTemporaryDirectory();
    final filePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    await image.saveTo(filePath);

    File finalImage = File(filePath);

    // --- YENİ EKLEDİĞİMİZ KISIM ---
    final result = await FaceRecognitionSimulator.recognize(finalImage, students);

    if (result == null) {
      // Tanınmayan yüz
      Navigator.pop(context, false);
    } else {
      // Tanındı (şimdilik hiç olmayacak)
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.student.name} için Kamera"),
      ),
      body: _isCameraInitialized
          ? Column(
              children: [
                Expanded(
                  child: CameraPreview(_controller!),
                ),
                ElevatedButton(
                  onPressed: _takePicture,
                  child: const Text("Fotoğraf Çek"),
                ),
              ],
            )
          : const Center(
              child: Text("Kamera yükleniyor..."),
            ),
    );
  }
}
