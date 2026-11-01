import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import 'dashboard_apoteker.dart';
import 'tambahObat.dart'; 

class ManajemenObatPage extends StatefulWidget {
  const ManajemenObatPage({super.key});

  @override
  State<ManajemenObatPage> createState() => _ManajemenObatPageState();
}

class _ManajemenObatPageState extends State<ManajemenObatPage> {
  static const Color primaryBlue = Color(0xFF1686D2);
  static const Color backgroundColor = Color(0xFFF7FAFC);
  static const Color darkText = Color(0xFF0F172A);
  static const Color mutedText = Color(0xFF64748B);
  static const Color lightBlue = Color(0xFFEBF3FB);

  

  void _ubahStok(int index, int perubahan) {
    setState(() {
      final stokSaatIni = obatList[index]['stokSekarang'] as int;
      final stokBaru = stokSaatIni + perubahan;

      if (stokBaru >= 0) {
        obatList[index]['stokSekarang'] = stokBaru;
      }
    });
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
        actions: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4F8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: Color(0xFF334155),
                  size: 22,
                ),
                Positioned(
                  top: 10,
                  right: 11,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE11D48),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primaryBlue, Color(0xFF0D91B9)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'AP',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOMBOL KEMBALI
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardApoteker(),
                  ),
                );
              },
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

            // HEADER APOTEKER
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
                    Icons.inventory_2_outlined,
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
                        'Daftar obat tersedia',
                        style: GoogleFonts.inter(
                          color: darkText,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Kelola dan perbarui informasi persediaan obat.',
                        style: GoogleFonts.inter(
                          color: mutedText,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // KARTU DAFTAR OBAT
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // ITEM DAFTAR OBAT
                  ...List.generate(obatList.length, (index) {
                    return _buildMedicineRow(index);
                  }),
                  
                
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),

      // TOMBOL MELAYANG (+) UNTUK PINDAH HALAMAN FORM TAMBAH OBAT
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newObat = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(
              builder: (context) => const TambahObatPage(),
            ),
          );

          if (newObat != null) {
            setState(() {
              obatList.add(newObat);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Obat ${newObat['nama']} berhasil ditambahkan!',
                  style: GoogleFonts.inter(),
                ),
                backgroundColor: primaryBlue,
              ),
            );
          }
        },
        backgroundColor: primaryBlue,
        elevation: 4,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'Tambah Obat',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildNavItem(
                  icon: Icons.home_outlined,
                  label: 'Beranda',
                  isActive: false,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardApoteker(),
                      ),
                    );
                  },
                ),
                _buildNavItem(
                  icon: Icons.assignment_outlined,
                  label: 'Resep',
                  isActive: false,
                  onTap: () {},
                ),
                _buildNavItem(
                  icon: Icons.calendar_today_outlined,
                  label: 'Jadwal',
                  isActive: false,
                  onTap: () {},
                ),
                _buildNavItem(
                  icon: Icons.person_outline_rounded,
                  label: 'Profil',
                  isActive: false,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // WIDGET ROW SETIAP ITEM OBAT
  
    Widget _buildMedicineRow(int index) {
        final obat = obatList[index];

        return Column(
            children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            // INFORMASI OBAT DI SEBELAH KIRI
                            Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        // KODE KFA
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                            color: lightBlue,
                                            borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                            '${obat['kodeKFA']}',
                                            style: GoogleFonts.inter(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: primaryBlue,
                                            ),
                                            ),
                                        ),
                                        const SizedBox(height: 8),

                                        // NAMA OBAT
                                        Text(
                                            '${obat['nama']}',
                                            style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: darkText,
                                            ),
                                        ),
                                        const SizedBox(height: 5),

                                        Row(
                                            children: [
                                                Text(
                                                '${obat['berat']}',
                                                style: GoogleFonts.inter(
                                                    fontSize: 11,
                                                    color: mutedText,
                                                ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                '${obat['bentuk']}',
                                                style: GoogleFonts.inter(
                                                    fontSize: 11,
                                                    color: mutedText,
                                                ),
                                                ),
                                            ],
                                        ),
                                    ],
                                ),
                            ),

                            const SizedBox(width: 8),

                            // STOK AWAL DI SEBELAH KANAN
                            SizedBox(
                                width: 48,
                                child: Column(
                                    children: [
                                        Text(
                                            'Stok awal',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                            fontSize: 9,
                                            color: mutedText,
                                            ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                            '${obat['stokAwal']}',
                                            style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: darkText,
                                            ),
                                        ),
                                    ],
                                ),
                            ),

                            const SizedBox(width: 8),

                            // STOK SEKARANG DI SEBELAH KANAN
                            SizedBox(
                                width: 66,
                                child: Column(
                                    children: [
                                        Text(
                                            'Stok sekarang',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                            fontSize: 9,
                                            color: primaryBlue,
                                            fontWeight: FontWeight.w600,
                                            ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                            '${obat['stokSekarang']}',
                                            style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryBlue,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        ],
                    ),
                ),

                if (index < obatList.length - 1)
                    const Divider(
                    color: Color(0xFFF1F5F9),
                    height: 16,
                    thickness: 2,
                    ),
            ],
        );
    }


  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? primaryBlue : const Color(0xFF94A3B8),
                size: 22,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive ? primaryBlue : const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}