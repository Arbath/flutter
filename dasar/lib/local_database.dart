import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> simpanNama(String nama) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('nama_user', nama);
}

Future<String?> ambilNama() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('nama_user');
}

Future<void> hapusNama() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('nama_user');
}

class LocalDatabase extends StatefulWidget {
  const LocalDatabase({super.key});

  @override
  State<LocalDatabase> createState() => _LocalDatabaseState();
}

class _LocalDatabaseState extends State<LocalDatabase> {
  TextEditingController namaController = TextEditingController();
  String namaTersimpan = "";

  Future<void> simpanNama() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama_user', namaController.text);
  }

  Future<void> ambilNama() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      namaTersimpan = prefs.getString('nama_user') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    ambilNama();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: "Masukkan Nama",
              ),
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                simpanNama();
                ambilNama();
              },
              child: Text("Simpan Nama"),
            ),

            SizedBox(height: 20),

            Text(
              "Nama tersimpan: $namaTersimpan",
              style: TextStyle(fontSize: 18),
            )

          ],
        ),
      ),
    );
}
}

