
import 'package:flutter/material.dart';

import '../models/pasien.dart';
import '../models/obat.dart';
import '../models/data_obat.dart';

class BuatResepPage extends StatefulWidget {
  final Pasien pasien;

  const BuatResepPage({
    super.key,
    required this.pasien,
  });

  @override
  State<BuatResepPage> createState() => _BuatResepPageState();
}

class _BuatResepPageState extends State<BuatResepPage> {
  // Controller
  final TextEditingController searchController =
      TextEditingController();

  final TextEditingController tabletPerMinumController =
      TextEditingController();

  final TextEditingController frekuensiController =
      TextEditingController();

  final TextEditingController aturanPakaiController =
      TextEditingController();

  final TextEditingController durasiController =
      TextEditingController();

  final TextEditingController catatanController =
      TextEditingController();

  // Obat yang dipilih
  Obat? obatTerpilih;

  // Daftar obat resep
  final List<Map<String, dynamic>> obatResep = [];

  // Warna
  final Color primaryColor = const Color(0xFF1689D3);
  final Color backgroundColor = const Color(0xFFF7F9FC);
  final Color textColor = const Color(0xFF243447);
  final Color secondaryColor = const Color(0xFF7B8794);

  // Filter obat
  List<Obat> get daftarObatTerfilter {
    final keyword = searchController.text.toLowerCase().trim();

    return obatList.where((obat) {
      final namaCocok =
          obat.nama.toLowerCase().contains(keyword);

      final stokTersedia = obat.stokSekarang > 0;

      return namaCocok && stokTersedia;
    }).toList();
  }

  // Perhitungan otomatis jumlah obat
  int get jumlahObatOtomatis {
    final tabletPerMinum = int.tryParse(
          tabletPerMinumController.text.trim(),
        ) ??
        0;

    final frekuensi = int.tryParse(
          frekuensiController.text.trim(),
        ) ??
        0;

    final durasi = int.tryParse(
          durasiController.text.trim(),
        ) ??
        0;

    return tabletPerMinum * frekuensi * durasi;
  }

  // Dekorasi input
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

  // Judul bagian
  Widget judulBagian(String judul, {String? keterangan}) {
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

  // Dekorasi kartu
  BoxDecoration dekorasiCard() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color(0xFFE9EEF3),
      ),
    );
  }

  // Pesan
  void tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior: SnackBarBehavior.floating,
        backgroundColor: textColor,
      ),
    );
  }

  // Pilih obat
  void pilihObat(Obat? obat) {
    setState(() {
      obatTerpilih = obat;
    });
  }

  // Reset form obat
  void resetFormObat() {
    searchController.clear();
    tabletPerMinumController.clear();
    frekuensiController.clear();
    aturanPakaiController.clear();
    durasiController.clear();

    obatTerpilih = null;
  }

  // Tambah obat
  void tambahObat() {
    if (obatTerpilih == null) {
      tampilkanPesan('Silakan pilih obat terlebih dahulu.');
      return;
    }

    if (tabletPerMinumController.text.trim().isEmpty ||
        frekuensiController.text.trim().isEmpty ||
        aturanPakaiController.text.trim().isEmpty ||
        durasiController.text.trim().isEmpty) {
      tampilkanPesan('Semua keterangan obat harus diisi.');
      return;
    }

    final tabletPerMinum = int.tryParse(
      tabletPerMinumController.text.trim(),
    );

    final frekuensi = int.tryParse(
      frekuensiController.text.trim(),
    );

    final durasi = int.tryParse(
      durasiController.text.trim(),
    );

    if (tabletPerMinum == null ||
        tabletPerMinum <= 0 ||
        frekuensi == null ||
        frekuensi <= 0 ||
        durasi == null ||
        durasi <= 0) {
      tampilkanPesan(
        'Jumlah tablet, frekuensi, dan durasi harus berupa angka lebih dari 0.',
      );
      return;
    }

    final jumlah = tabletPerMinum * frekuensi * durasi;

    if (jumlah > obatTerpilih!.stokSekarang) {
      tampilkanPesan(
        'Stok obat tidak mencukupi. '
        'Stok tersedia: ${obatTerpilih!.stokSekarang}. '
        'Kebutuhan: $jumlah.',
      );
      return;
    }

    final sudahAda = obatResep.any(
      (item) =>
          (item['obat'] as Obat).kodeKFA ==
          obatTerpilih!.kodeKFA,
    );

    if (sudahAda) {
      tampilkanPesan('Obat tersebut sudah ada dalam resep.');
      return;
    }

    setState(() {
      obatResep.add({
        'obat': obatTerpilih!,
        'tabletPerMinum': tabletPerMinum,
        'frekuensi': frekuensi,
        'aturanPakai': aturanPakaiController.text.trim(),
        'durasi': durasi,
        'jumlah': jumlah,
      });

      resetFormObat();
    });

    tampilkanPesan('Obat berhasil ditambahkan.');
  }

  // Hapus obat
  void hapusObat(int index) {
    setState(() {
      obatResep.removeAt(index);
    });

    tampilkanPesan('Obat berhasil dihapus dari resep.');
  }

  // Informasi obat
  Widget informasiObat() {
    if (obatTerpilih == null) {
      return const SizedBox.shrink();
    }

    final obat = obatTerpilih!;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F8FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFD5EAF9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            obat.nama,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text('Kode KFA: ${obat.kodeKFA}'),
          Text('Berat: ${obat.berat}'),
          Text('Bentuk: ${obat.bentuk}'),
          Text('Stok tersedia: ${obat.stokSekarang}'),
        ],
      ),
    );
  }

  // Form tambah obat
  Widget formObat() {
    final daftar = daftarObatTerfilter;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: dekorasiCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          judulBagian(
            'Pilih Obat',
            keterangan:
                'Cari obat terlebih dahulu, kemudian pilih dari daftar.',
          ),

          const SizedBox(height: 18),

          // Search obat
          TextField(
            controller: searchController,
            onChanged: (_) {
              setState(() {
                if (obatTerpilih != null &&
                    !daftarObatTerfilter.any(
                      (obat) =>
                          obat.kodeKFA ==
                          obatTerpilih!.kodeKFA,
                    )) {
                  obatTerpilih = null;
                }
              });
            },
            decoration: dekorasiInput(
              label: 'Cari Nama Obat',
              hint: 'Masukkan nama obat...',
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF1689D3),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Dropdown obat
          DropdownButtonFormField<Obat>(
            value: obatTerpilih,
            isExpanded: true,
            decoration: dekorasiInput(
              label: 'Pilih Obat',
              hint: 'Pilih obat dari daftar',
              prefixIcon: const Icon(
                Icons.medication_outlined,
                color: Color(0xFF1689D3),
              ),
            ),
            items: daftar.map((obat) {
              return DropdownMenuItem<Obat>(
                value: obat,
                child: Text(
                  '${obat.nama} - ${obat.berat}',
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: pilihObat,
          ),

          if (daftar.isEmpty) ...[
            const SizedBox(height: 10),
            Text(
              'Obat tidak ditemukan atau stok habis.',
              style: TextStyle(
                color: Colors.red.shade600,
                fontSize: 12,
              ),
            ),
          ],

          informasiObat(),

          if (obatTerpilih != null) ...[
            const SizedBox(height: 22),

            judulBagian('Keterangan Penggunaan Obat'),

            const SizedBox(height: 14),

            // Tablet per sekali minum
            TextField(
              controller: tabletPerMinumController,
              keyboardType: TextInputType.number,
              onChanged: (_) {
                setState(() {});
              },
              decoration: dekorasiInput(
                label: 'Jumlah Tablet per Sekali Minum',
                hint: 'Contoh: 2 tablet',
                prefixIcon: const Icon(
                  Icons.medication_outlined,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Frekuensi per hari
            TextField(
              controller: frekuensiController,
              keyboardType: TextInputType.number,
              onChanged: (_) {
                setState(() {});
              },
              decoration: dekorasiInput(
                label: 'Frekuensi per Hari',
                hint: 'Contoh: 3 kali sehari',
                prefixIcon: const Icon(
                  Icons.schedule,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Aturan pakai
            TextField(
              controller: aturanPakaiController,
              decoration: dekorasiInput(
                label: 'Aturan Pakai',
                hint: 'Contoh: Sesudah makan',
                prefixIcon: const Icon(
                  Icons.notes,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Durasi
            TextField(
              controller: durasiController,
              keyboardType: TextInputType.number,
              onChanged: (_) {
                setState(() {});
              },
              decoration: dekorasiInput(
                label: 'Durasi Penggunaan (Hari)',
                hint: 'Contoh: 5 hari',
                prefixIcon: const Icon(
                  Icons.calendar_today_outlined,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Jumlah otomatis
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F4FC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFD5EAF9),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Jumlah Obat',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$jumlahObatOtomatis',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1689D3),
                    ),
                  ),
                  const Text(
                    'Tablet per minum × Frekuensi per hari × Durasi',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: tambahObat,
                icon: const Icon(Icons.add),
                label: const Text(
                  'Tambah Obat',
                  style: TextStyle(
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
          ],
        ],
      ),
    );
  }

  // Daftar obat resep
  Widget daftarObatResep() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: dekorasiCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              judulBagian('Daftar Obat Resep'),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4FC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${obatResep.length} Obat',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          if (obatResep.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.medication_outlined,
                    size: 42,
                    color: secondaryColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Belum ada obat ditambahkan',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            )
          else
            ...obatResep.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final obat = item['obat'] as Obat;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFCFE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE7EDF3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F4FC),
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.medication,
                            color: primaryColor,
                            size: 21,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                obat.nama,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${obat.berat} • ${obat.bentuk}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () => hapusObat(index),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          tooltip: 'Hapus obat',
                        ),
                      ],
                    ),

                    const Divider(height: 22),

                    Text(
                      'Dosis: ${item['tabletPerMinum']} tablet '
                      '${item['frekuensi']} kali sehari',
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Aturan pakai: ${item['aturanPakai']}',
                    ),
                    const SizedBox(height: 5),
                    Text('Durasi: ${item['durasi']} hari'),
                    const SizedBox(height: 5),
                    Text(
                      'Total jumlah: ${item['jumlah']} tablet',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  // Catatan dokter
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
              prefixIcon: const Icon(Icons.notes),
            ).copyWith(
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
    );
  }

  // Informasi pasien
  Widget informasiPasien() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: dekorasiCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          judulBagian(
            'Informasi Pasien',
            keterangan: 'Pasien yang akan menerima resep.',
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

  // Konfirmasi simpan resep
  void simpanResep() {
    if (obatResep.isEmpty) {
      tampilkanPesan(
        'Tambahkan minimal satu obat sebelum menyimpan resep.',
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Konfirmasi Resep',
            style: TextStyle(
              fontWeight: FontWeight.bold,
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

                  const SizedBox(height: 16),

                  const Text(
                    'Daftar Obat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  ...obatResep.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final obat = item['obat'] as Obat;

                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${obat.nama}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Dosis: ${item['tabletPerMinum']} '
                            'tablet, ${item['frekuensi']} kali sehari',
                          ),
                          Text(
                            'Aturan pakai: ${item['aturanPakai']}',
                          ),
                          Text(
                            'Durasi: ${item['durasi']} hari',
                          ),
                          Text(
                            'Jumlah: ${item['jumlah']} tablet',
                          ),
                        ],
                      ),
                    );
                  }),

                  if (catatanController.text.trim().isNotEmpty) ...[
                    const Divider(),
                    const Text(
                      'Catatan Dokter',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
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
                Navigator.pop(dialogContext);
                Navigator.pop(context);

                tampilkanPesan(
                  'Resep berhasil dikonfirmasi.',
                );
              },
              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    tabletPerMinumController.dispose();
    frekuensiController.dispose();
    aturanPakaiController.dispose();
    durasiController.dispose();
    catatanController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: textColor,
        elevation: 0,
        title: const Text(
          'Buat Resep',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            informasiPasien(),

            const SizedBox(height: 20),

            formObat(),

            const SizedBox(height: 20),

            daftarObatResep(),

            const SizedBox(height: 20),

            catatanDokter(),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: simpanResep,
                icon: const Icon(Icons.save_outlined),
                label: const Text(
                  'Simpan Resep',
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
