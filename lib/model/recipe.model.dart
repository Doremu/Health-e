import 'package:firebase_database/firebase_database.dart';

class Recipe {
  String key;
  String namaObat;
  String penyakit;
  int hariTanggal;
  int bulanTanggal;
  int tahunTanggal;

  Recipe(this.namaObat, this.penyakit, this.hariTanggal, this.bulanTanggal, this.tahunTanggal);

  Recipe.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        namaObat = snapshot.value["namaObat"],
        penyakit = snapshot.value["penyakit"],
        hariTanggal = snapshot.value["hariTanggal"],
        bulanTanggal = snapshot.value["bulanTanggal"],
        tahunTanggal = snapshot.value["tahunTanggal"];

  toJson() {
    return {
      "namaObat": namaObat,
      "penyakit": penyakit,
      "hariTanggal": hariTanggal,
      "bulanTanggal": bulanTanggal,
      "tahunanggal": tahunTanggal,
    };
  }
}
