import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../apoteker/dashboard_apoteker.dart';

class ManajemenObatPage extends StatefulWidget {
  const ManajemenObatPage({super.key});

  @override
  State<ManajemenObatPage> createState() => _ManajemenObatPageState();
}

class _ManajemenObatPageState extends State<ManajemenObatPage> {
  static const Color primaryBlue = Color(0xFF1686D2);
  static const Color primaryTeal = Color(0xFF0D9EAB);
  static const Color backgroundColor = Color(0xFFF7FAFC);
  static const Color darkText = Color(0xFF0F172A);
  static const Color mutedText = Color(0xFF64748B);
  static const Color lightBlue = Color(0xFFEBF3FB);

  final List<Map<String, dynamic>> obatList = [
    {
      'nama': 'Paracetamol 500 mg',
      'detail': '124 tablet',
      'stok': 124,
      'satuan': 'tablet',
    },
    {
      'nama': 'Amoxicillin 500 mg',
      'detail': '32 kapsul',
      'stok': 32,
      'satuan': 'kapsul',
    },
    {
      'nama': 'Oralit',
      'detail': '18 sachet',
      'stok': 18,
      'satuan': 'sachet',
    },
  ];

  void _ubahStok(int index, int perubahan) {
    setState(() {
      final stokSaatIni = obatList[index]['stok'] as int;
      final stokBaru = stokSaatIni + perubahan;

      if (stokBaru >= 0) {
        obatList[index]['stok'] = stokBaru;
        obatList[index]['detail'] =
            '$stokBaru ${obatList[index]['satuan']}';
      }
    });
  }

  void _simpanStok() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Perubahan stok berhasil disimpan.',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: const Color(0xFF1686D2),
        ),
      );
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
            _buildBackButton(),
            const SizedBox(height: 20),

            // HEADER APOTEKER & MANAJEMEN STOK
            _buildPageTitle(),
            const SizedBox(height: 24),

            // KARTU PERSEDIAAN OBAT
            _buildStockCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // TOMBOL KEMBALI
  Widget _buildBackButton() {
    return InkWell(
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
    );
  }

  // JUDUL HALAMAN
  Widget _buildPageTitle() {
    return Row(
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
            Icons.view_in_ar_rounded,
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
                'Manajemen stok',
                style: GoogleFonts.inter(
                  color: darkText,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Pantau dan perbarui persediaan obat.',
                style: GoogleFonts.inter(
                  color: mutedText,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // KARTU PERSEDIAAN OBAT
  Widget _buildStockCard() {
    return Container(
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
          Text(
            'Persediaan obat',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Perubahan tersimpan pada perangkat ini',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(obatList.length, (index) {
            return _buildMedicineRow(index);
          }),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryBlue, Color(0xFF0B87A6)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton(
                onPressed: _simpanStok,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Simpan perubahan stok',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BARIS OBAT DAN KONTROL STOK
  Widget _buildMedicineRow(int index) {
    final obat = obatList[index];
    final int stok = obat['stok'] as int;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      obat['nama'] as String,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: darkText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '$stok ${obat['satuan']}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
              _buildStockButton(
                icon: Icons.remove_rounded,
                onTap: () => _ubahStok(index, -1),
              ),
              SizedBox(
                width: 32,
                child: Text(
                  '$stok',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
              ),
              _buildStockButton(
                icon: Icons.add_rounded,
                onTap: () => _ubahStok(index, 1),
              ),
            ],
          ),
        ),
        if (index < obatList.length - 1)
          const Divider(
            color: Color(0xFFF1F5F9),
            height: 16,
            thickness: 1,
          ),
      ],
    );
  }

  Widget _buildStockButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: lightBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: primaryBlue,
          size: 18,
        ),
      ),
    );
  }

  // BOTTOM NAVIGATION
  Widget _buildBottomNavigation() {
    return Container(
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
                onTap: () => _showMessage('Menu Resep'),
              ),
              _buildNavItem(
                icon: Icons.calendar_today_outlined,
                label: 'Jadwal',
                isActive: false,
                onTap: () => _showMessage('Menu Jadwal'),
              ),
              _buildNavItem(
                icon: Icons.person_outline_rounded,
                label: 'Profil',
                isActive: false,
                onTap: () => _showMessage('Menu Profil'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    const Color activeColor = primaryBlue;
    const Color inactiveColor = Color(0xFF94A3B8);

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
                color: isActive ? activeColor : inactiveColor,
                size: 22,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive ? activeColor : inactiveColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: GoogleFonts.inter()),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}