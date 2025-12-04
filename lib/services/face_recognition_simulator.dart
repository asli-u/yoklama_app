import 'dart:io';
import '../models/student.dart';

class FaceRecognitionSimulator {
  /// Bu fonksiyon şimdilik HER ZAMAN null döner.
  /// Arkadaşın bu fonksiyonun içini dolduracak.
  static Future<Student?> recognize(File image, List<Student> students) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null; // Şimdilik kimseyi tanıyamıyor
  }
}
