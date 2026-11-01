import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Data List Obat dengan Standar Kode KFA (Kamus Farmasi dan Alat Kesehatan)
  final List<Map<String, dynamic>> obatList = [
    {
      'kodeKFA': '93000124',
      'nama': 'Paracetamol',
      'berat': '500 mg',
      'bentuk': 'Tablet',
      'stokAwal': 150,
      'stokSekarang': 124,
    },
    {
      'kodeKFA': '93000582',
      'nama': 'Amoxicillin',
      'berat': '500 mg',
      'bentuk': 'Kapsul',
      'stokAwal': 50,
      'stokSekarang': 32,
    },
    {
      'kodeKFA': '93001045',
      'nama': 'Oralit',
      'berat': '200 ml',
      'bentuk': 'Sachet',
      'stokAwal': 30,
      'stokSekarang': 18,
    },
  ];

class TambahObatPage extends StatefulWidget {
  const TambahObatPage({super.key});

  @override
  State<TambahObatPage> createState() => _TambahObatPageState();
}

class _TambahObatPageState extends State<TambahObatPage> {
  static const Color primaryBlue = Color(0xFF1686D2);
  static const Color backgroundColor = Color(0xFFF7FAFC);
  static const Color darkText = Color(0xFF0F172A);
  static const Color mutedText = Color(0xFF64748B);
  static const Color lightBlue = Color(0xFFEBF3FB);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _kodeKFAController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();
  final TextEditingController _bentukController = TextEditingController();
  final TextEditingController _stokAwalController = TextEditingController();

  
  
  void _simpanObatBaru() {
    if (_formKey.currentState!.validate()) {
      final int stokAwal = int.parse(_stokAwalController.text);

      final Map<String, dynamic> dataObatBaru = {
        'kodeKFA': _kodeKFAController.text,
        'nama': _namaController.text,
        'berat': _beratController.text,
        'bentuk': _bentukController.text,
        'stokAwal': stokAwal,
        'stokSekarang': stokAwal, // Stok awal otomatis jadi stok sekarang
      };

      Navigator.pop(context, dataObatBaru);
    }
  }

  @override
  void dispose() {
    _kodeKFAController.dispose();
    _namaController.dispose();
    _beratController.dispose();
    _bentukController.dispose();
    _stokAwalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: Row(
          children: [
            const Icon(
              Icons.favorite_border_rounded,
              color: primaryBlue,
              size: 26,
            ),
            const SizedBox(width: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Pusling',
                    style: GoogleFonts.inter(
                      color: primaryBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '+',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF57E1C4),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOMBOL KEMBALI
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: lightBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.chevron_left_rounded,
                      color: primaryBlue,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Kembali',
                      style: GoogleFonts.inter(
                        color: primaryBlue,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // HEADER FORM
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: lightBlue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.medication_outlined,
                    color: primaryBlue,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'APOTEKER',
                        style: GoogleFonts.inter(
                          color: primaryBlue,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Tambah obat baru',
                        style: GoogleFonts.inter(
                          color: darkText,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // CARD FORM INPUT
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: darkText.withOpacity(0.03),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(
                      label: 'Kode KFA',
                      controller: _kodeKFAController,
                      hint: 'Contoh: 93000124',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      label: 'Nama obat',
                      controller: _namaController,
                      hint: 'Contoh: Paracetamol',
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      label: 'Berat / Dosis',
                      controller: _beratController,
                      hint: 'Contoh: 500 mg, 100 ml',
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      label: 'Bentuk sediaan',
                      controller: _bentukController,
                      hint: 'Contoh: Tablet, Kapsul, Sirup',
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      label: 'Stok awal',
                      controller: _stokAwalController,
                      hint: 'Contoh: 100',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 28),

                    // TOMBOL SIMPAN DATA
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [primaryBlue, Color(0xFF0B87A6)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ElevatedButton(
                          onPressed: _simpanObatBaru,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check, color: Colors.white),
                              const SizedBox(width: 8),
                              Text(
                                'Simpan obat',
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET HELPER INPUT FIELD
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'Wajib',
              style: GoogleFonts.inter(
                fontSize: 10,
                color: primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '$label tidak boleh kosong';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF94A3B8),
              fontSize: 13,
            ),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: primaryBlue, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}