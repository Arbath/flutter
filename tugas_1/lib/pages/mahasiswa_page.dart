import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import '../services/mahasiswa_service.dart';
// import '../models/mahasiswa.dart';
import '../models/hive_mahasiswa.dart';

// class MahasiswaPage extends StatefulWidget {
//   @override
//   State<MahasiswaPage> createState() => _MahasiswaPageState();
// }

// class _MahasiswaPageState extends State<MahasiswaPage> {

//   final MahasiswaService service = MahasiswaService();
//   List<Mahasiswa> data = [];

//   final TextEditingController namaController = TextEditingController();
//   final TextEditingController nimController = TextEditingController();
//   final TextEditingController jurusanController = TextEditingController();

//   int? selectedId;

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   void loadData() async {
//     final result = await service.getAll();
//     setState(() {
//       data = result;
//     });
//   }

//   void simpanMahasiswa() async {
//     final mahasiswa = Mahasiswa(
//       id: selectedId,
//       nama: namaController.text,
//       nim: nimController.text,
//       jurusan: jurusanController.text,
//     );

//     if (selectedId == null) {
//       await service.tambah(mahasiswa);
//     } else {
//       await service.perbarui(mahasiswa);
//     }

//     setState(() {
//       selectedId = null;
//     });
    
//     namaController.clear();
//     nimController.clear();
//     jurusanController.clear();
    
//     loadData();
//   }

//   // Fungsi untuk mengisi field text saat tombol Edit diklik
//   void siapkanEdit(Mahasiswa mhs) {
//     setState(() {
//       selectedId = mhs.id;
//       namaController.text = mhs.nama;
//       nimController.text = mhs.nim;
//       jurusanController.text = mhs.jurusan;
//     });
//   }

//   void hapusMahasiswa(int id) async {
//     await service.hapus(id);
//     loadData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Daftar Mahasiswa")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: namaController,
//               decoration: InputDecoration(labelText: "Nama"),
//             ),
//             TextField(
//               controller: nimController,
//               decoration: InputDecoration(labelText: "NIM"),
//             ),
//             TextField(
//               controller: jurusanController,
//               decoration: InputDecoration(labelText: "Jurusan"),
//             ),
//             SizedBox(height: 10),

//             ElevatedButton(
//               onPressed: simpanMahasiswa,
//               child: Text("Simpan"), 
//             ),

//             SizedBox(height: 20),

//             Expanded(
//               child: ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   final mhs = data[index];

//                   return ListTile(
//                     title: Text(mhs.nama),
//                     subtitle: Text("${mhs.nim} - ${mhs.jurusan}"),
                    
//                     // Membungkus icon dengan Row agar bisa berdampingan
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             siapkanEdit(mhs);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () {
//                             hapusMahasiswa(mhs.id!);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


class MahasiswaPage extends StatefulWidget {
  @override
  _MahasiswaPageState createState() => _MahasiswaPageState();
}

class _MahasiswaPageState extends State<MahasiswaPage> {
  final Box<HiveMahasiswa> box = Hive.box<HiveMahasiswa>('mahasiswaBox');

  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final prodiController = TextEditingController();

  int? editIndex;

  void saveData() {
    final mahasiswa = HiveMahasiswa(
      nama: namaController.text,
      nim: nimController.text,
      prodi: prodiController.text,
    );

    if (editIndex == null) {
      box.add(mahasiswa);
    } else {
      box.putAt(editIndex!, mahasiswa);
      editIndex = null;
    }

    clearForm();
  }

  void editData(int index) {
    final data = box.getAt(index)!;

    namaController.text = data.nama;
    nimController.text = data.nim;
    prodiController.text = data.prodi;

    setState(() {
      editIndex = index;
    });
  }

  void deleteData(int index) {
    box.deleteAt(index);
  }

  void clearForm() {
    namaController.clear();
    nimController.clear();
    prodiController.clear();

    setState(() {
      editIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CRUD Mahasiswa - Hive")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: nimController,
              decoration: InputDecoration(labelText: "NIM"),
            ),
            TextField(
              controller: prodiController,
              decoration: InputDecoration(labelText: "Prodi"),
            ),

            SizedBox(height: 10),

            Row(
              children: [
                ElevatedButton(
                  onPressed: saveData,
                  child: Text(editIndex == null ? "Simpan" : "Update"),
                ),
                SizedBox(width: 10),
                if (editIndex != null)
                  ElevatedButton(
                    onPressed: clearForm,
                    child: Text("Batal"),
                  ),
              ],
            ),

            SizedBox(height: 20),

            Expanded(
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, Box<HiveMahasiswa> box, _) {
                  if (box.isEmpty) {
                    return Center(child: Text("Belum ada data"));
                  }

                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final data = box.getAt(index)!;

                      return Card(
                        child: ListTile(
                          title: Text(data.nama),
                          subtitle: Text(
                            "NIM: ${data.nim} | ${data.prodi}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.orange),
                                onPressed: () => editData(index),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteData(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}