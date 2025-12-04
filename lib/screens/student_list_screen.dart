import 'package:flutter/material.dart';
import '../data/students_data.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {

  // Bu sayfa yeniden açıldığında listeyi yenilemesi için
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {}); // listeyi ZORLA yenile
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğrenci Listesi'),
      ),

      body: StudentData.students.isEmpty
          ? const Center(
              child: Text(
                "Hiç öğrenci yok.\nKameradan yüz ekleyince burada görünecek.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: StudentData.students.length,
              itemBuilder: (context, index) {
                final student = StudentData.students[index];
                return ListTile(
                  title: Text("${student.name} ${student.surname}"),
                  subtitle: Text("ID: ${student.id}"),
                  trailing: Icon(
                    student.isPresent ? Icons.check_circle : Icons.cancel,
                    color: student.isPresent ? Colors.green : Colors.red,
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Kamera ekranına git → geri gelince liste yenilensin
          await Navigator.pushNamed(context, '/camera');
          setState(() {}); // EKLEME OLDUYSA LİSTEYİ YENİLE
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
