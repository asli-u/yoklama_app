import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/face_recognition_simulator.dart';


class AddStudentPopup {
  static void show(BuildContext context, String? imagePath, Function(Student) onStudentAdded)
 {
    final _nameController = TextEditingController();
    final _surnameController = TextEditingController();
    final _idController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeni Öğrenci Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Ad'),
              ),
              TextField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: 'Soyad'),
              ),
              TextField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'Okul Numarası'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                final newStudent = Student(
                  id: _idController.text,
                  name: _nameController.text,
                  surname: _surnameController.text,
                  imagePath: imagePath,
                  faceId: "face_${DateTime.now().millisecondsSinceEpoch}",
                  embedding: FaceRecognitionSimulator.generateEmbedding(),
                );
                onStudentAdded(newStudent);
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Yeni öğrenci başarıyla kaydedildi!')),
                );
              },
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }
}
