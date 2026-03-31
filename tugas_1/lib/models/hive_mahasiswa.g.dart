// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_mahasiswa.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMahasiswaAdapter extends TypeAdapter<HiveMahasiswa> {
  @override
  final int typeId = 0;

  @override
  HiveMahasiswa read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMahasiswa(
      nama: fields[0] as String,
      nim: fields[1] as String,
      prodi: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveMahasiswa obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nama)
      ..writeByte(1)
      ..write(obj.nim)
      ..writeByte(2)
      ..write(obj.prodi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMahasiswaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
