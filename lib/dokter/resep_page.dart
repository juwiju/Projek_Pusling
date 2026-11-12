
import 'package:flutter/material.dart';

class BuatResepPage extends StatefulWidget {
  const BuatResepPage({super.key});

  @override
  State<BuatResepPage> createState() => _BuatResepPageState();
}

class _BuatResepPageState extends State<BuatResepPage> {
  // 1. CONTROLLER
  final TextEditingController catatanController =
      TextEditingController();

  final TextEditingController pencarianController =
      TextEditingController();

  // 2. DATA PASIEN SEMENTARA
  String? pasienTerpilih;

  final List<String> daftarPasien = [
    'Andi Saputra',
    'Siti Aminah',
    'Budi Santoso',
    'Rina Amelia',
  ];

  // 3. DATA OBAT SEMENTARA
  final List<Map<String, dynamic>> daftarObat = [
    {
      'nama': 'Paracetamol',
      'kekuatan': '500 mg',
      'stok': 120,
    },
    {
      'nama': 'Amoxicillin',
      'kekuatan': '500 mg',
      'stok': 80,
    },
    {
      'nama': 'Vitamin C',
      'kekuatan': '500 mg',
      'stok': 100,
    },
    {
      'nama': 'Ibuprofen',
      'kekuatan': '200 mg',
      'stok': 60,
    },
    {
      'nama': 'Cetirizine',
      'kekuatan': '10 mg',
      'stok': 45,
    },
  ];

  // 4. DAFTAR OBAT YANG DIPILIH
  final List<Map<String, dynamic>> obatResep = [];

  // 5. FILTER PENCARIAN OBAT
  List<Map<String, dynamic>> get obatTersaring {
    final keyword = pencarianController.text.toLowerCase();

    return daftarObat.where((obat) {
      return obat['nama'].toString().toLowerCase().contains(keyword);
    }).toList();
  }

  // 6. TAMBAH OBAT
  void tambahObat(Map<String, dynamic> obat) {
    final sudahAda = obatResep.any(
      (item) => item['nama'] == obat['nama'],
    );

    if (sudahAda) {
      tampilkanPesan('Obat sudah ditambahkan.');
      return;
    }

    setState(() {
      obatResep.add({
        'nama': obat['nama'],
        'kekuatan': obat['kekuatan'],
        'stok': obat['stok'],
        'dosis': TextEditingController(),
        'jumlah': TextEditingController(),
        'aturan': 'Sesuai instruksi dokter',
      });
    });

    pencarianController.clear();
    FocusScope.of(context).unfocus();
  }

  // 7. HAPUS OBAT
  void hapusObat(int index) {
    setState(() {
      final obat = obatResep.removeAt(index);
      (obat['dosis'] as TextEditingController).dispose();
      (obat['jumlah'] as TextEditingController).dispose();
    });
  }

  // 8. VALIDASI RESEP
  void buatResep() {
    if (pasienTerpilih == null) {
      tampilkanPesan('Silakan pilih pasien terlebih dahulu.');
      return;
    }

    if (obatResep.isEmpty) {
      tampilkanPesan('Tambahkan minimal satu obat.');
      return;
    }

    for (final obat in obatResep) {
      final dosis =
          (obat['dosis'] as TextEditingController).text.trim();

      final jumlah =
          (obat['jumlah'] as TextEditingController).text.trim();

      if (dosis.isEmpty || jumlah.isEmpty) {
        tampilkanPesan('Lengkapi dosis dan jumlah obat.');
        return;
      }

      final jumlahAngka = int.tryParse(jumlah);

      if (jumlahAngka == null || jumlahAngka <= 0) {
        tampilkanPesan('Jumlah harus berupa angka lebih dari 0.');
        return;
      }

      if (jumlahAngka > (obat['stok'] as int)) {
        tampilkanPesan('Jumlah ${obat['nama']} melebihi stok.');
        return;
      }
    }

    tampilkanPesan('Resep berhasil dibuat (simulasi).');
  }

  // 9. PESAN
  void tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }

  // 10. MEMBERSIHKAN CONTROLLER
  @override
  void dispose() {
    catatanController.dispose();
    pencarianController.dispose();

    for (final obat in obatResep) {
      (obat['dosis'] as TextEditingController).dispose();
      (obat['jumlah'] as TextEditingController).dispose();
    }

    super.dispose();
  }

  // 11. TAMPILAN UTAMA
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      appBar: AppBar(
        title: const Text(
          'Buat Resep',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF243447),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Resep Baru',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF243447),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Lengkapi informasi pasien dan obat yang akan diresepkan.',
              style: TextStyle(color: Color(0xFF7B8794)),
            ),

            const SizedBox(height: 25),

            // INFORMASI PASIEN
            judulBagian(Icons.person_outline, 'Informasi Pasien'),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: dekorasiCard(),
              child: DropdownButtonFormField<String>(
                value: pasienTerpilih,
                decoration: dekorasiInput(
                  hint: 'Pilih pasien',
                  icon: Icons.person_outline,
                ),
                items: daftarPasien.map((pasien) {
                  return DropdownMenuItem(
                    value: pasien,
                    child: Text(pasien),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    pasienTerpilih = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 25),

            // PILIH OBAT
            judulBagian(Icons.medication_outlined, 'Pilih Obat'),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: dekorasiCard(),
              child: Column(
                children: [
                  TextField(
                    controller: pencarianController,
                    onChanged: (value) => setState(() {}),
                    decoration: dekorasiInput(
                      hint: 'Cari nama obat...',
                      icon: Icons.search,
                    ),
                  ),

                  const SizedBox(height: 15),

                  ...obatTersaring.map((obat) {
                    final sudahAda = obatResep.any(
                      (item) => item['nama'] == obat['nama'],
                    );

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F9FC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.medication,
                            color: Color(0xFF1689D3),
                            size: 30,
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  obat['nama'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${obat['kekuatan']} • Stok ${obat['stok']}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          IconButton(
                            onPressed: sudahAda
                                ? null
                                : () => tambahObat(obat),
                            icon: Icon(
                              sudahAda
                                  ? Icons.check_circle
                                  : Icons.add_circle,
                              color: sudahAda
                                  ? Colors.green
                                  : const Color(0xFF1689D3),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  if (obatTersaring.isEmpty)
                    const Text('Obat tidak ditemukan.'),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // DAFTAR OBAT RESEP
            judulBagian(Icons.receipt_long, 'Daftar Obat Resep'),

            const SizedBox(height: 8),

            Text('${obatResep.length} obat ditambahkan'),

            const SizedBox(height: 12),

            if (obatResep.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: dekorasiCard(),
                child: const Column(
                  children: [
                    Icon(
                      Icons.medication_outlined,
                      size: 40,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text('Belum ada obat ditambahkan'),
                  ],
                ),
              ),

            ...List.generate(obatResep.length, (index) {
              final obat = obatResep[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: dekorasiCard(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            obat['nama'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => hapusObat(index),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      obat['kekuatan'],
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 15),

                    const Text('Dosis'),
                    const SizedBox(height: 6),

                    TextField(
                      controller: obat['dosis'],
                      decoration: dekorasiInput(
                        hint: 'Contoh: 1 tablet',
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text('Aturan Pakai'),
                    const SizedBox(height: 6),

                    DropdownButtonFormField<String>(
                      value: obat['aturan'],
                      decoration: dekorasiInput(),
                      items: [
                        'Sesuai instruksi dokter',
                        'Sebelum makan',
                        'Sesudah makan',
                        'Bersama makanan',
                        'Sesuai kebutuhan',
                      ].map((aturan) {
                        return DropdownMenuItem(
                          value: aturan,
                          child: Text(
                            aturan,
                            style: const TextStyle(fontSize: 13),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          obat['aturan'] = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    const Text('Jumlah Obat'),
                    const SizedBox(height: 6),

                    TextField(
                      controller: obat['jumlah'],
                      keyboardType: TextInputType.number,
                      decoration: dekorasiInput(
                        hint: 'Masukkan jumlah obat',
                        suffix: 'Unit',
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 15),

            // CATATAN DOKTER
            judulBagian(Icons.note_alt_outlined, 'Catatan Dokter'),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: dekorasiCard(),
              child: TextField(
                controller: catatanController,
                maxLines: 4,
                decoration: dekorasiInput(
                  hint: 'Tambahkan catatan dokter...',
                ),
              ),
            ),

            const SizedBox(height: 25),

            // TOMBOL BUAT RESEP
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: buatResep,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text(
                  'Buat Resep',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1689D3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// WIDGET JUDUL BAGIAN
Widget judulBagian(IconData icon, String judul) {
  return Row(
    children: [
      Icon(
        icon,
        color: const Color(0xFF1689D3),
        size: 22,
      ),
      const SizedBox(width: 10),
      Text(
        judul,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Color(0xFF243447),
        ),
      ),
    ],
  );
}

// DEKORASI CARD
BoxDecoration dekorasiCard() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: const Color(0xFFE8EDF2),
    ),
  );
}

// DEKORASI INPUT
InputDecoration dekorasiInput({
  String? hint,
  IconData? icon,
  String? suffix,
}) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: icon != null ? Icon(icon) : null,
    suffixText: suffix,
    filled: true,
    fillColor: const Color(0xFFF7F9FC),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 14,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color(0xFFE8EDF2),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color(0xFFE8EDF2),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color(0xFF1689D3),
        width: 1.5,
      ),
    ),
  );
}
