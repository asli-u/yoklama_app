import 'dart:math';

class FaceRecognitionSimulator {
  // Rasgele 128 boyutlu vektör üretir
  static List<double> generateEmbedding() {
    Random r = Random();
    return List.generate(128, (_) => r.nextDouble());
  }

  // İki embedding arasındaki benzerliği karşılaştırır
  static double calculateSimilarity(List<double> a, List<double> b) {
    double sum = 0;
    for (int i = 0; i < a.length; i++) {
      sum += (1 - (a[i] - b[i]).abs());
    }
    return sum / a.length; // ortalama benzerlik (0–1)
  }

  // Eşik üzerinde ise eşleşmiş kabul edilir
  static bool isMatch(List<double> a, List<double> b) {
    return calculateSimilarity(a, b) > 0.90;
  }

  // --- YEPYENİ: Tek görüntüden yüz tanıma ---
  static bool recognizeFace(String imagePath) {
    // Simülasyon: %30 oranında tanıdı varsayalım
    return Random().nextDouble() > 0.7;
  }

  // --- YEPYENİ: İki resmi karşılaştır ---
  static bool compareFaces(String img1, String img2) {
    // Simülasyon: rastgele benzerlik veriyoruz
    List<double> emb1 = generateEmbedding();
    List<double> emb2 = generateEmbedding();
    return isMatch(emb1, emb2);
  }

  // --- YEPYENİ: Benzersiz öğrenci yüz ID'si oluştur ---
  static String generateFaceId() {
    return "face_${Random().nextInt(99999999)}";
  }
}

