import 'package:flutter/material.dart';

import '../models/pasien.dart';

class RekamMedisPage extends StatefulWidget {
  final Pasien pasien;

  const RekamMedisPage({
    super.key,
    required this.pasien,
  });

  @override
  State<RekamMedisPage> createState() =>
      _RekamMedisPageState();
}

class _RekamMedisPageState extends State<RekamMedisPage> {

  // CONTROLLER
  final TextEditingController searchController =
      TextEditingController();

  final TextEditingController keluhanController =
      TextEditingController();

  final TextEditingController diagnosisController =
      TextEditingController();

  final TextEditingController terapiController =
      TextEditingController();

  final TextEditingController catatanController =
      TextEditingController();

  // DAFTAR GEJALA
  final List<String> daftarGejala = [
    'Demam',
    'Batuk',
    'Pilek',
    'Sakit kepala',
    'Mual',
    'Muntah',
    'Pusing',
    'Nyeri perut',
    'Diare',
    'Sesak napas',
    'Nyeri dada',
    'Lemas',
    'Sakit tenggorokan',
    'Nyeri otot',
    'Ruam kulit',
  ];

  // GEJALA DIPILIH
  final List<String> gejalaDipilih = [];

  // WARNA SAMA SEPERTI RESEP
  final Color primaryColor = const Color(0xFF1689D3);

  final Color backgroundColor = const Color(0xFFF7F9FC);

  final Color textColor = const Color(0xFF243447);

  final Color secondaryColor = const Color(0xFF7B8794);

  // DEKORASI INPUT
  InputDecoration dekorasiInput({
    required String label,
    String? hint,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: Colors.white,
      labelStyle: TextStyle(
        color: secondaryColor,
        fontSize: 13,
      ),
      hintStyle: TextStyle(
        color: secondaryColor.withOpacity(0.7),
        fontSize: 13,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE3EAF0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE3EAF0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: primaryColor,
          width: 1.5,
        ),
      ),
    );
  }

  // JUDUL BAGIAN
  Widget judulBagian(
    String judul, {
    String? keterangan,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        if (keterangan != null) ...[
          const SizedBox(height: 4),
          Text(
            keterangan,
            style: TextStyle(
              fontSize: 12,
              color: secondaryColor,
            ),
          ),
        ],
      ],
    );
  }

  // DEKORASI CARD
  BoxDecoration dekorasiCard() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color(0xFFE9EEF3),
      ),
    );
  }

  // PESAN
  void tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior: SnackBarBehavior.floating,
        backgroundColor: textColor,
      ),
    );
  }
    // INFORMASI PASIEN
  Widget informasiPasien() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: dekorasiCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          judulBagian(
            'Informasi Pasien',
            keterangan: 'Pasien yang akan diperiksa.',
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xFFE8F4FC),
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                  size: 28,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pasien.nama,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'ID Pasien: ${widget.pasien.idPasien}',
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Nomor Antrean: ${widget.pasien.nomorAntrean}',
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Divider(height: 25),

          Row(
            children: [
              Expanded(
                child: detailPasien(
                  'Umur',
                  '${widget.pasien.umur} tahun',
                ),
              ),

              Expanded(
                child: detailPasien(
                  'Jenis Kelamin',
                  widget.pasien.jenisKelamin,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // DETAIL PASIEN
  Widget detailPasien(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: secondaryColor,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
    // FORM GEJALA
  Widget formGejala() {
    final hasilPencarian =
        searchController.text.trim().length < 2
            ? <String>[]
            : daftarGejala.where((gejala) {
                return gejala.toLowerCase().contains(
                  searchController.text.toLowerCase().trim(),
                );
              }).toList();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: dekorasiCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          judulBagian(
            'Gejala yang Dialami',
            keterangan:
                'Cari dan pilih gejala yang dialami pasien.',
          ),

          const SizedBox(height: 18),

          // PENCARIAN GEJALA
          TextField(
            controller: searchController,
            onChanged: (_) {
              setState(() {});
            },
            decoration: dekorasiInput(
              label: 'Cari Gejala',
              hint: 'Masukkan nama gejala...',
              prefixIcon: Icon(
                Icons.search,
                color: primaryColor,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // PETUNJUK PENCARIAN
          if (searchController.text.trim().length < 2)
            Text(
              'Ketik minimal 2 huruf untuk mencari gejala.',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 12,
              ),
            ),

          // HASIL PENCARIAN KOSONG
          if (searchController.text.trim().length >= 2 &&
              hasilPencarian.isEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Gejala tidak ditemukan.',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 12,
                ),
              ),
            ),

          // DAFTAR CHECKBOX
          ...hasilPencarian.map((gejala) {
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              activeColor: primaryColor,
              title: Text(
                gejala,
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                ),
              ),
              value: gejalaDipilih.contains(gejala),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    if (!gejalaDipilih.contains(gejala)) {
                      gejalaDipilih.add(gejala);
                    }
                  } else {
                    gejalaDipilih.remove(gejala);
                  }
                });
              },
            );
          }),

          // DAFTAR GEJALA TERPILIH
          if (gejalaDipilih.isNotEmpty) ...[
            const Divider(height: 25),

            judulBagian('Gejala Dipilih'),

            const SizedBox(height: 12),

            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: gejalaDipilih.map((gejala) {
                return Chip(
                  backgroundColor: const Color(0xFFE8F4FC),
                  label: Text(
                    gejala,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                    ),
                  ),
                  onDeleted: () {
                    setState(() {
                      gejalaDipilih.remove(gejala);
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
    // FORM KELUHAN UTAMA
  Widget formKeluhan() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: dekorasiCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          judulBagian(
            'Keluhan Utama',
            keterangan:
                'Tuliskan keluhan yang disampaikan pasien.',
          ),

          const SizedBox(height: 14),

          TextField(
            controller: keluhanController,
            maxLines: 3,
            decoration: dekorasiInput(
              label: 'Keluhan Utama',
              hint: 'Contoh: Demam sejak dua hari lalu...',
              prefixIcon: const Icon(
                Icons.edit_note,
              ),
            ).copyWith(
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
    );
  }

  // FORM DIAGNOSIS
  Widget formDiagnosis() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: dekorasiCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          judulBagian(
            'Diagnosis',
            keterangan:
                'Masukkan hasil diagnosis pasien.',
          ),

          const SizedBox(height: 14),

          TextField(
            controller: diagnosisController,
            maxLines: 2,
            decoration: dekorasiInput(
              label: 'Diagnosis / Kode ICD-10',
              hint: 'Masukkan diagnosis pasien...',
              prefixIcon: const Icon(
                Icons.medical_information_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FORM TERAPI
  Widget formTerapi() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: dekorasiCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          judulBagian(
            'Terapi',
            keterangan:
                'Tuliskan tindakan atau terapi yang diberikan.',
          ),

          const SizedBox(height: 14),

          TextField(
            controller: terapiController,
            maxLines: 4,
            decoration: dekorasiInput(
              label: 'Terapi',
              hint: 'Tuliskan tindakan atau terapi...',
              prefixIcon: const Icon(
                Icons.healing_outlined,
              ),
            ).copyWith(
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
    );
  }

  // CATATAN DOKTER
  Widget catatanDokter() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: dekorasiCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          judulBagian(
            'Catatan Dokter',
            keterangan:
                'Tambahkan catatan tambahan jika diperlukan.',
          ),

          const SizedBox(height: 14),

          TextField(
            controller: catatanController,
            maxLines: 4,
            decoration: dekorasiInput(
              label: 'Catatan',
              hint: 'Tuliskan catatan tambahan...',
              prefixIcon: const Icon(
                Icons.notes,
              ),
            ).copyWith(
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
    );
  }
    // SIMPAN REKAM MEDIS
  void simpanData() {
    if (gejalaDipilih.isEmpty) {
      tampilkanPesan(
        'Pilih minimal satu gejala pasien.',
      );
      return;
    }

    if (keluhanController.text.trim().isEmpty) {
      tampilkanPesan(
        'Keluhan utama harus diisi.',
      );
      return;
    }

    final dataRekamMedis = {
      'pasien': {
        'nama': widget.pasien.nama,
        'umur': widget.pasien.umur,
        'id': widget.pasien.idPasien,
        'nomor': widget.pasien.nomorAntrean,
        'jenisKelamin': widget.pasien.jenisKelamin,
        'keterangan':
            widget.pasien.keterangan ??
            widget.pasien.jenisKelamin,
      },
      'gejala': List<String>.from(gejalaDipilih),
      'keluhan': keluhanController.text.trim(),
      'diagnosis': diagnosisController.text.trim(),
      'terapi': terapiController.text.trim(),
      'catatan': catatanController.text.trim(),
    };

    konfirmasiRekamMedis(dataRekamMedis);
  }

  // KONFIRMASI REKAM MEDIS
  void konfirmasiRekamMedis(
    Map<String, dynamic> dataRekamMedis,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          title: const Text(
            'Konfirmasi Rekam Medis',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Data Pasien',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text('Nama: ${widget.pasien.nama}'),
                  Text('ID: ${widget.pasien.idPasien}'),
                  Text('Umur: ${widget.pasien.umur} tahun'),
                  Text(
                    'Jenis Kelamin: ${widget.pasien.jenisKelamin}',
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Gejala Pasien',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  ...gejalaDipilih.asMap().entries.map(
                    (entry) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Text(
                          '${entry.key + 1}. ${entry.value}',
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Keluhan Utama',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(keluhanController.text.trim()),

                  const SizedBox(height: 16),

                  const Text(
                    'Diagnosis',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    diagnosisController.text.trim().isEmpty
                        ? '-'
                        : diagnosisController.text.trim(),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Terapi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    terapiController.text.trim().isEmpty
                        ? '-'
                        : terapiController.text.trim(),
                  ),

                  if (catatanController.text
                      .trim()
                      .isNotEmpty) ...[
                    const Divider(height: 25),

                    const Text(
                      'Catatan Dokter',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(catatanController.text.trim()),
                  ],
                ],
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Periksa Lagi'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),

              onPressed: () {
                widget.pasien.status = 'Selesai';

                Navigator.pop(dialogContext);

                Navigator.pop(
                  context,
                  dataRekamMedis,
                );
              },

              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }
    // DISPOSE
  @override
  void dispose() {
    searchController.dispose();
    keluhanController.dispose();
    diagnosisController.dispose();
    terapiController.dispose();
    catatanController.dispose();

    super.dispose();
  }

  // BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: textColor,
        elevation: 0,
        title: const Text(
          'Rekam Medis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // INFORMASI PASIEN
            informasiPasien(),

            const SizedBox(height: 20),

            // GEJALA
            formGejala(),

            const SizedBox(height: 20),

            // KELUHAN
            formKeluhan(),

            const SizedBox(height: 20),

            // DIAGNOSIS
            formDiagnosis(),

            const SizedBox(height: 20),

            // TERAPI
            formTerapi(),

            const SizedBox(height: 20),

            // CATATAN DOKTER
            catatanDokter(),

            const SizedBox(height: 25),

            // TOMBOL SIMPAN
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: simpanData,
                icon: const Icon(
                  Icons.save_outlined,
                ),
                label: const Text(
                  'Simpan Rekam Medis',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}