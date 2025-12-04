class Student {
  final String id;
  final String name;
  final String surname;
  final String? imagePath;

  String? faceId;             // Öğrencinin yüz kimliği
  List<double>? embedding;    // Yüz özellik vektörü (sahte simülasyon)
  
  bool isPresent;

  Student({
    required this.id,
    required this.name,
    required this.surname,
    this.imagePath,
    this.faceId,
    this.embedding,
    this.isPresent = false,
  });
}
