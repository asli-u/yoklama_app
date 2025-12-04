import 'package:yoklama_app/services/face_recognition_simulator.dart';

void main() {
  print("===== YÜZ TANIMA SİMÜLASYON TESTLERİ =====\n");

  // ---------------------------------------------------
  // 1) Aynı kişiyi tanıma testi
  // ---------------------------------------------------
  print("1) Aynı kişiyi tanıma testi:");

  List<double> personA = FaceRecognitionSimulator.generateEmbedding();
  List<double> samePersonFrame = List<double>.from(personA);

  bool sameMatch = FaceRecognitionSimulator.isMatch(personA, samePersonFrame);

  print("→ Aynı kişi eşleşti mi?  $sameMatch\n");


  // ---------------------------------------------------
  // 2) Farklı kişileri tanımama testi
  // ---------------------------------------------------
  print("2) Farklı kişileri tanımama testi:");

  List<double> personB = FaceRecognitionSimulator.generateEmbedding();
  bool differentMatch = FaceRecognitionSimulator.isMatch(personA, personB);

  print("→ Farklı iki kişi eşleşti mi?  $differentMatch\n");


  // ---------------------------------------------------
  // 3) Rastgele eşleşme olasılığı testi
  // ---------------------------------------------------
  print("3) 5 rastgele eşleşme testi:");

  for (int i = 0; i < 5; i++) {
    List<double> e1 = FaceRecognitionSimulator.generateEmbedding();
    List<double> e2 = FaceRecognitionSimulator.generateEmbedding();

    bool match = FaceRecognitionSimulator.isMatch(e1, e2);
    print("→ Test $i sonucu: $match");
  }

  print("");


  // ---------------------------------------------------
  // 4) Öğrencinin kaydedilen yüzüyle canlı kare karşılaştırma
  // ---------------------------------------------------
  print("4) Öğrenci kaydı → canlı kare eşleşme testi:");

  List<double> studentEmbedding = FaceRecognitionSimulator.generateEmbedding();
  List<double> liveFrame = List<double>.from(studentEmbedding);

  bool studentMatch =
      FaceRecognitionSimulator.isMatch(studentEmbedding, liveFrame);

  print("→ Öğrenci canlı karede tanındı mı?  $studentMatch\n");


  print("===== TESTLER TAMAMLANDI =====");
}
