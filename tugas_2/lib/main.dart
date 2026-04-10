import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:praktikum_hive/app.dart';
import 'package:praktikum_hive/models/mahasiswa.dart';
import 'package:praktikum_hive/models/prodi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(MahasiswaAdapter());
  Hive.registerAdapter(ProdiAdapter());

  await Hive.openBox<Mahasiswa>('mahasiswaBox');
  Box<Prodi> prodiBox = await Hive.openBox<Prodi>('prodiBox');

  if (prodiBox.isEmpty) {
    prodiBox.addAll([
      Prodi(namaProdi: "Informatika"),
      Prodi(namaProdi: "Biologi"),
      Prodi(namaProdi: "Fisika"),
      Prodi(namaProdi: "Matematika"),
      Prodi(namaProdi: "Kimia"),
    ]);
  }

  runApp(App());
}
