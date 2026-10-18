import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Pelayanan Awal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF007CBA)),
        useMaterial3: true,
      ),
      home: const RegistrasiScreen(),
    );
  }
}

class RegistrasiScreen extends StatefulWidget {
  const RegistrasiScreen({super.key});

  @override
  State<RegistrasiScreen> createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  // Controller Input Data
  final TextEditingController nikController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController usiaController = TextEditingController();
  final TextEditingController bbController = TextEditingController();
  final TextEditingController tbController = TextEditingController();
  final TextEditingController sistolikController = TextEditingController();
  final TextEditingController diastolikController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  String selectedPembayaran = 'BPJS';
  String selectedKategori = 'Dewasa';
  bool isCekGulaDarah = false;

  
  bool isReadOnly = false;

  @override
  void dispose() {
    nikController.dispose();
    namaController.dispose();
    usiaController.dispose();
    bbController.dispose();
    tbController.dispose();
    sistolikController.dispose();
    diastolikController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (nikController.text.trim().isEmpty || namaController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon lengkapi NIK dan Nama Lengkap terlebih dahulu!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    
    setState(() {
      isReadOnly = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    // HEADER (TETAP SAMA SEPERTI TAMPILAN AWAL)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'PELAYANAN AWAL',
                              style: TextStyle(
                                color: Color(0xFF007CBA),
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                letterSpacing: 0.8,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Registrasi & asesmen',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey[100],
                          child: const Icon(Icons.close, color: Colors.grey, size: 20),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),

                    // STEPPER INDICATOR
                    Row(
                      children: [
                        _buildStepCircle('1', 'Data pasien', isActive: true),
                        _buildStepLine(),
                        _buildStepCircle('2', 'Asesmen', isActive: true),
                        _buildStepLine(),
                        _buildStepCircle('3', 'Cek darah', isActive: false),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ================= SECTION 1: DATA PASIEN =================
                    _buildSectionHeader('1', 'Data pasien', 'Identitas dan jenis pelayanan'),
                    const SizedBox(height: 16),

                    _buildLabel('NIK', isRequired: true),
                    _buildTextField(controller: nikController, hintText: '16 digit NIK'),

                    _buildLabel('Nama lengkap', isRequired: true),
                    _buildTextField(controller: namaController, hintText: 'Nama sesuai identitas'),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Usia', isRequired: true),
                              _buildTextField(controller: usiaController, hintText: 'Tahun'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Pembayaran', isRequired: false),
                              _buildDropdownField(
                                value: selectedPembayaran,
                                items: ['BPJS', 'Mandiri', 'Asuransi'],
                                onChanged: (val) => setState(() => selectedPembayaran = val!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    _buildLabel('Kategori pasien', isRequired: false),
                    _buildDropdownField(
                      value: selectedKategori,
                      items: ['Dewasa', 'Anak-anak', 'Lansia'],
                      onChanged: (val) => setState(() => selectedKategori = val!),
                    ),

                    const SizedBox(height: 20),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    const SizedBox(height: 20),

                    // ================= SECTION 2: ASESMEN AWAL =================
                    _buildSectionHeader('2', 'Asesmen awal', 'Dilakukan oleh petugas yang sama'),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabelWithUnit('Berat badan', 'kg', isRequired: true),
                              _buildTextField(controller: bbController, hintText: 'Contoh: 55'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabelWithUnit('Tinggi badan', 'cm', isRequired: true),
                              _buildTextField(controller: tbController, hintText: 'Contoh: 160'),
                            ],
                          ),
                        ),
                      ],
                    ),

                    _buildLabelWithUnit('Tekanan darah', 'mmHg', isRequired: true),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(controller: sistolikController, hintText: 'Sistolik')),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('/', style: TextStyle(color: Colors.grey, fontSize: 16)),
                        ),
                        Expanded(child: _buildTextField(controller: diastolikController, hintText: 'Diastolik')),
                      ],
                    ),

                    _buildLabel('Catatan awal', isRequired: false),
                    _buildTextField(
                      controller: catatanController,
                      hintText: 'Keluhan atau kondisi awal pasien',
                      maxLines: 3,
                    ),

                    const SizedBox(height: 20),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    const SizedBox(height: 20),

                    // ================= SECTION 3: CEK DARAH =================
                    _buildSectionHeader('3', 'Cek darah', 'Layanan tambahan, tidak wajib'),
                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFF1F5F9)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6F4EA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.show_chart, color: Color(0xFF34A853)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Tambahkan cek gula darah',
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                SizedBox(height: 2),
                                Text('Biaya layanan Rp15.000',
                                    style: TextStyle(color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                          ),
                          Switch(
                            value: isCekGulaDarah,
                            activeColor: const Color(0xFF007CBA),
                            onChanged: isReadOnly
                                ? null
                                : (val) => setState(() => isCekGulaDarah = val),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ================= DUA MODE TOMBOL AKSI =================
                    if (!isReadOnly) ...[
                      // MODE 1: EDIT FORM (Tombol Simpan)
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                side: const BorderSide(color: Color(0xFFE2E8F0)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: const Text('Batal',
                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF007CBA),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Simpan & buat antrean',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(Icons.chevron_right, color: Colors.white, size: 18),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      // MODE 2: READ-ONLY (Tombol Cek Kembali & Sudah Benar)
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  isReadOnly = false; // Membuka kunci form untuk diedit lagi
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: const Text(
                                'Cek Kembali',
                                style: TextStyle(
                                    color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 13),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Berhasil! Antrean telah dikirim.'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF007CBA),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: const Text(
                                'Sudah Benar, Kirim',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildLabel(String text, {required bool isRequired}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 12),
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          if (isRequired) ...[
            const SizedBox(width: 2),
            const Text('*', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
          ] else ...[
            const SizedBox(width: 4),
            const Text('(Opsional)', style: TextStyle(color: Colors.grey, fontSize: 11)),
          ]
        ],
      ),
    );
  }

  Widget _buildLabelWithUnit(String text, String unit, {required bool isRequired}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 12),
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          const SizedBox(width: 4),
          Text(unit, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          if (isRequired) ...[
            const SizedBox(width: 2),
            const Text('*', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
          ] else ...[
            const SizedBox(width: 4),
            const Text('(Opsional)', style: TextStyle(color: Colors.grey, fontSize: 11)),
          ]
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String number, String title, String subtitle) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: const Color(0xFFE6F0FA),
          child: Text(
            number,
            style: const TextStyle(
              color: Color(0xFF007CBA),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      enabled: !isReadOnly, // Menonaktifkan input jika isReadOnly = true
      maxLines: maxLines,
      style: TextStyle(
        color: isReadOnly ? Colors.black87 : Colors.black,
        fontWeight: isReadOnly ? FontWeight.bold : FontWeight.normal,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        filled: true,
        fillColor: isReadOnly ? const Color(0xFFF8FAFC) : const Color(0xFFFAFAFA),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF007CBA)),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: isReadOnly ? null : onChanged, // Menonaktifkan dropdown jika isReadOnly = true
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        filled: true,
        fillColor: isReadOnly ? const Color(0xFFF8FAFC) : const Color(0xFFFAFAFA),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF007CBA)),
        ),
      ),
    );
  }

  Widget _buildStepCircle(String number, String title, {required bool isActive}) {
    return Row(
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: isActive ? const Color(0xFF007CBA) : const Color(0xFFF1F5F9),
          child: Text(
            number,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : Colors.grey[500],
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            color: isActive ? const Color(0xFF007CBA) : Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine() {
    return Expanded(
      child: Container(
        height: 1,
        color: const Color(0xFFE2E8F0),
        margin: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }
}