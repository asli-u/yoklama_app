import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../services/face_recognition_simulator.dart';
import '../widgets/add_student_popup.dart';
import '../data/students_data.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool _isInitialized = false;
  bool _isProcessing = false; 
  bool _popupShown = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _controller.initialize();

    _controller.startImageStream((CameraImage image) {
      if (_isProcessing || _popupShown) return;
      _isProcessing = true;

      List<double> liveEmbedding = FaceRecognitionSimulator.generateEmbedding();

      bool matched = false;

      for (var student in StudentData.students) {
        if (student.embedding != null &&
            FaceRecognitionSimulator.isMatch(student.embedding!, liveEmbedding)) {
          
          matched = true;
          student.isPresent = true;

          _popupShown = true;
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Öğrenci Tanındı"),
              content: Text("${student.name} yoklamaya işlendi."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context); 
                  },
                  child: const Text("Tamam"),
                ),
              ],
            ),
          );

          _isProcessing = false;
          return;
        }
      }

      // Eşleşme yoksa: yeni öğrenci ekle
      if (!matched && !_popupShown) {
        _popupShown = true;

        AddStudentPopup.show(context, liveEmbedding, (newStudent) {
          StudentData.students.add(newStudent);
        });

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      }

      _isProcessing = false;
    });

    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Canlı Yüz Tanıma")),
      body: CameraPreview(_controller),
    );
  }
}
