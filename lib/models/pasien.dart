class Pasien {
  String idPasien;
  String nomorAntrean;
  String nama;
  int umur;
  String jenisKelamin;
  String status;
  String? keterangan;

  Pasien({
    required this.idPasien,
    required this.nomorAntrean,
    required this.nama,
    required this.umur,
    required this.jenisKelamin,
    required this.status,
    this.keterangan,
  });
}
