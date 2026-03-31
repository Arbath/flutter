import 'package:hive/hive.dart';

part 'hive_mahasiswa.g.dart';

@HiveType(typeId: 0)
class HiveMahasiswa extends HiveObject {
  @HiveField(0)
  String nama;

  @HiveField(1)
  String nim;

  @HiveField(2)
  String prodi;

  HiveMahasiswa({required this.nama, required this.nim, required this.prodi});
}