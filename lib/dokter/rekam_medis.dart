import 'package:flutter/material.dart';
import 'antrean_dokter.dart';

class RekamMedisPage extends StatefulWidget {
  final Pasien pasien;

  const RekamMedisPage({
    super.key,
    required this.pasien,
  });

  @override
  State<RekamMedisPage> createState() => _RekamMedisPageState();
}

class _RekamMedisPageState extends State<RekamMedisPage> {

  // CONTROLLER
  final TextEditingController _searchController =
      TextEditingController();

  final TextEditingController _keluhanController =
      TextEditingController();

  final TextEditingController _diagnosisController =
      TextEditingController();

  final TextEditingController _terapiController =
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

  final List<String> gejalaDipilih = [];

  // WARNA APLIKASI
  final Color biru = const Color(0xFF237BC5);
  final Color biruMuda = const Color(0xFFE8F3FD);
  final Color background = const Color(0xFFF3F7FA);
  final Color teks = const Color(0xFF17243A);

  @override
  void dispose() {
    _searchController.dispose();
    _keluhanController.dispose();
    _diagnosisController.dispose();
    _terapiController.dispose();
    super.dispose();
  }
  // DEKORASI INPUT
  InputDecoration inputDecoration({
    required String hint,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFFA7B0BC),
        fontSize: 14,
      ),
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: const Color(0xFFFBFCFD),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 22,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: biru,
          width: 1.5,
        ),
      ),
    );
  }

  // LABEL FORM
  Widget labelForm(String judul, {bool wajib = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Text(
            judul,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF455166),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 9),
          Text(
            wajib ? 'Wajib' : 'Opsional',
            style: const TextStyle(
              color: Color(0xFF7C8796),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // INFORMASI PASIEN
  Widget dataPasien() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 22,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFCFD),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: biruMuda,
                child: Icon(
                  Icons.person_outline,
                  color: biru,
                  size: 27,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pasien.nama,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: teks,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Nomor antrean: ${widget.pasien.nomor}',
                      style: const TextStyle(
                        color: Color(0xFF8290A0),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                       'Umur: ${widget.pasien.umur}',
                        style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8290A0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // PENCARIAN GEJALA
  Widget pencarianGejala() {
    final hasilPencarian =
        _searchController.text.length < 2
            ? <String>[]
            : daftarGejala.where((gejala) {
                return gejala.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    );
              }).toList();

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFBFCFD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: inputDecoration(
              hint: 'Cari gejala...',
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (_) {
              setState(() {});
            },
          ),

          const SizedBox(height: 10),

          if (_searchController.text.length < 2)
            const Text(
              'Ketik minimal 2 huruf untuk mencari gejala.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

          if (_searchController.text.length >= 2 &&
              hasilPencarian.isEmpty)
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text('Gejala tidak ditemukan.'),
            ),

          ...hasilPencarian.map((gejala) {
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              activeColor: Color(0xFF168BC2),
              title: Text(gejala),
              value: gejalaDipilih.contains(gejala),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    gejalaDipilih.add(gejala);
                  } else {
                    gejalaDipilih.remove(gejala);
                  }
                });
              },
            );
          }),

          if (gejalaDipilih.isNotEmpty) ...[
            const Divider(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Gejala dipilih:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 6,
              runSpacing: 5,
              children: gejalaDipilih.map((gejala) {
                return Chip(
                  backgroundColor: biruMuda,
                  label: Text(
                    gejala,
                    style: TextStyle(color: biru),
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


void simpanData() {
  if (_keluhanController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Keluhan utama harus diisi.'),
        backgroundColor: Colors.redAccent,
      ),
    );
    return;
  }

  final dataRekamMedis = {
    'pasien': {
      'nama': widget.pasien.nama,
      'umur': widget.pasien.umur,
      'nomor': widget.pasien.nomor,
      'keterangan': widget.pasien.keterangan,
    },
    'gejala': List<String>.from(gejalaDipilih),
    'keluhan': _keluhanController.text.trim(),
    'diagnosis': _diagnosisController.text.trim(),
    'terapi': _terapiController.text.trim(),
  };

  widget.pasien.status = 'Asesmen selesai';

  debugPrint('DATA REKAM MEDIS: $dataRekamMedis');

  Navigator.pop(context, dataRekamMedis);
}

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // HEADER APLIKASI
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 24,
        title: Row(
          children: [
            Icon(
              Icons.favorite_border,
              color: biru,
              size: 29,
            ),
            const SizedBox(width: 10),
            Text(
              'Pusling+',
              style: TextStyle(
                color: biru,
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F6F9),
              borderRadius: BorderRadius.circular(18),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: Color(0xFF17243A),
                size: 27,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Container(
            margin: const EdgeInsets.only(
              right: 20,
              top: 9,
              bottom: 9,
            ),
            width: 54,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF18A69A),
                  Color(0xFF168BC2),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.center,
            child: const Text(
              'DR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          24,
          30,
          24,
          35,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // TOMBOL KEMBALI
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: biruMuda,
                foregroundColor: biru,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                '‹ Kembali',
                style: TextStyle(fontSize: 15),
              ),
            ),

            const SizedBox(height: 15),

            // JUDUL REKAM MEDIS
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: biruMuda,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    Icons.assignment_outlined,
                    color: biru,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DOKTER',
                        style: TextStyle(
                          color: biru,
                          fontSize: 13,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Rekam medis',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: teks,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        'Catat keluhan, diagnosis, dan terapi pasien.',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // FORM REKAM MEDIS
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: const Color(0xFFE3E9EF),
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  // DATA PASIEN
                  labelForm('Pasien'),

                  dataPasien(),

                  const SizedBox(height: 20),

                  // GEJALA
                  labelForm('Gejala yang dialami', wajib: true,),

                  pencarianGejala(),

                  const SizedBox(height: 20),

                  // KELUHAN UTAMA
                  labelForm(
                    'Keluhan utama',
                    wajib: true,
                  ),

                  TextField(
                    controller: _keluhanController,
                    maxLines: 2,
                    decoration: inputDecoration(
                      hint: 'Keluhan yang disampaikan pasien',
                    ),
                  ),

                  const SizedBox(height: 20),

                  // DIAGNOSIS
                  labelForm('Diagnosis'),

                  TextField(
                    controller: _diagnosisController,
                    decoration: inputDecoration(
                      hint: 'Diagnosis / kode ICD-10',
                    ),
                  ),

                  const SizedBox(height: 20),

                  // TERAPI
                  labelForm('Terapi'),

                  TextField(
                    controller: _terapiController,
                    maxLines: 4,
                    decoration: inputDecoration(
                      hint: 'Tindakan atau terapi yang diberikan',
                    ),
                  ),

                  const SizedBox(height: 20),

                  // TOMBOL SIMPAN
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF2179D0),
                            Color(0xFF0D91AF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.18),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: simpanData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        icon: const Icon(
                          Icons.check,
                          size: 20,
                        ),
                        label: const Text(
                          'Simpan data',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}