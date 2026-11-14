
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/pasien.dart';
import '../models/data_pasien.dart';
import 'rekam_medis.dart';
import 'resep_page.dart';

class DashboardDokter extends StatefulWidget {
  final VoidCallback? onLogout;

  const DashboardDokter({super.key, this.onLogout});

  @override
  State<DashboardDokter> createState() =>
      _DashboardDokterState();
}

class _DashboardDokterState extends State<DashboardDokter> {
  static const Color darkText = Color(0xFF243447);
  static const Color mutedText = Color(0xFF7B8794);

  // NAVIGASI REKAM MEDIS
  void _bukaRekamMedis(
    BuildContext context,
    Pasien pasien,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RekamMedisPage(
          pasien: pasien,
        ),
      ),
    ).then((hasil) {
      if (hasil != null && mounted) {
        setState(() {});
      }
    });
  }

  // NAVIGASI RESEP
  void _bukaResep(BuildContext context, Pasien pasien) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BuatResepPage(
          pasien: pasien,
        ),
      ),
    );
  }

  // SURAT RUJUKAN
  void _bukaSuratRujukan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Halaman Surat Rujukan belum tersedia.',
        ),
      ),
    );
  }

  // MENGUBAH STATUS PASIEN
  void _ubahStatus(Pasien pasien, String statusBaru) {
    setState(() {
      pasien.status = statusBaru;
    });
  }

  // WARNA STATUS
  Color _warnaStatus(String status) {
    switch (status) {
      case 'Selesai':
        return const Color(0xFF269B7B);
      case 'Diperiksa':
        return const Color(0xFF3478D4);
      default:
        return const Color(0xFFD99424);
    }
  }

  Color _backgroundStatus(String status) {
    switch (status) {
      case 'Selesai':
        return const Color(0xFFE4F7EF);
      case 'Diperiksa':
        return const Color(0xFFE8F1FF);
      default:
        return const Color(0xFFFFF3D9);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.favorite_border),
            SizedBox(width: 8),
            Text('Pusling+'),
          ],
        ),
        actions: [
          const Icon(Icons.notifications_none_rounded),
          const SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                if (widget.onLogout != null) {
                  widget.onLogout!();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Hubungkan aksi keluar ke halaman Login di main.dart.',
                      ),
                    ),
                  );
                }
              },
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1686D2),
                      Color(0xFF0D91B9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'DR',
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

      // BODY DASHBOARD
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Minggu, 27 September 2026',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 8),

            const Text(
              'Selamat Pagi, Dokter!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'Dokter Pusling',
              style: TextStyle(color: Colors.blue),
            ),

            const SizedBox(height: 24),

            _buildTodayCard(),

            const SizedBox(height: 24),

            _buildSectionTitle(
              'Ringkasan hari ini',
              'Pembaruan pelayanan pasien',
              trailing: _buildLiveBadge(),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    '${pasienList.length}',
                    'Total pasien',
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard(
                    '${pasienList.where((p) => p.status == 'Menunggu').length}',
                    'Belum diperiksa',
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard(
                    '${pasienList.where((p) => p.status == 'Selesai').length}',
                    'Sudah diperiksa',
                    Colors.teal,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ANTREAN PASIEN
            _buildSectionTitle(
              'Antrean pasien',
              'Daftar pasien hari ini',
              trailing: const SizedBox.shrink(),
            ),

            const SizedBox(height: 16),

            if (pasienList.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 40,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text('Belum ada data pasien.'),
                  ],
                ),
              ),

            ...pasienList.map((pasien) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildPatientCard(
                  pasien: pasien,
                  onRekamMedis: () {
                    _bukaRekamMedis(context, pasien);
                  },
                  onBuatResep: () {
                    _bukaResep(context, pasien);
                  },
                  onSuratRujukan: () {
                    _bukaSuratRujukan(context);
                  },
                  onUbahStatus: (status) {
                    _ubahStatus(pasien, status);
                  },
                ),
              );
            }),

            const SizedBox(height: 24),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildTodayCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF176EB0),
            Color(0xFF128B9E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF176EB0).withOpacity(0.16),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF7CE6D1),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'PRAKTIK HARI INI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              const Text(
                'Detail',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ],
          ),

          const SizedBox(height: 26),

          const Text(
            'Pelayanan Kesehatan Pusling',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 18),

          const Wrap(
            spacing: 18,
            runSpacing: 10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.white70,
                    size: 20,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '08.00 – 12.00 WIB',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white70,
                    size: 20,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Balai RW 04',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 26),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: 16 / 24,
              minHeight: 6,
              backgroundColor: Color(0x6657C7D0),
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFF78E4D0),
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Row(
            children: [
              Expanded(
                child: Text(
                  'Progress pemeriksaan',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                '16 dari 24 pasien',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    String subtitle, {
    required Widget trailing,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: darkText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: mutedText,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: trailing,
        ),
      ],
    );
  }

  // BADGE LIVE
  Widget _buildLiveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F7F1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'LIVE',
        style: TextStyle(
          color: Color(0xFF319A8D),
          fontSize: 11,
        ),
      ),
    );
  }

  // KARTU STATISTIK
  Widget _buildStatCard(
    String number,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 20,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: mutedText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard({
    required Pasien pasien,
    required VoidCallback onRekamMedis,
    required VoidCallback onBuatResep,
    required VoidCallback onSuratRujukan,
    required ValueChanged<String> onUbahStatus,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF4FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Color(0xFF3994E8),
                  size: 26,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pasien.nomorAntrean,
                      style: const TextStyle(
                        fontSize: 11,
                        color: mutedText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pasien.nama,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: darkText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${pasien.umur} tahun • ${pasien.jenisKelamin}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: mutedText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${pasien.idPasien}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: mutedText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              const Text(
                'Status pasien',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: darkText,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: _backgroundStatus(pasien.status),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: pasien.status,
                    isDense: true,
                    style: TextStyle(
                      color: _warnaStatus(pasien.status),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Menunggu',
                        child: Text('Menunggu'),
                      ),
                      DropdownMenuItem(
                        value: 'Diperiksa',
                        child: Text('Diperiksa'),
                      ),
                      DropdownMenuItem(
                        value: 'Selesai',
                        child: Text('Selesai'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        onUbahStatus(value);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),

          const Text(
            'Aksi Pasien',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onRekamMedis,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF3994E8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 10,
                    ),
                    side: const BorderSide(
                      color: Color(0xFF3994E8),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.medical_information_outlined,
                        size: 18,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Rekam Medis',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 6),

              Expanded(
                child: OutlinedButton(
                  onPressed: onBuatResep,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD66C8B),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 10,
                    ),
                    side: const BorderSide(
                      color: Color(0xFFD66C8B),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.medication_outlined,
                        size: 18,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Buat Resep',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 6),

              Expanded(
                child: OutlinedButton(
                  onPressed: onSuratRujukan,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD99A30),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 10,
                    ),
                    side: const BorderSide(
                      color: Color(0xFFD99A30),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 18,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Surat Rujukan',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Row(
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Beranda',
                isActive: true,
                onTap: () {},
              ),

              _buildNavItem(
                icon: Icons.people_outline_rounded,
                label: 'Pasien',
                isActive: false,
                onTap: () {},
              ),

              _buildNavItem(
                icon: Icons.medication_outlined,
                label: 'Resep',
                isActive: false,
                onTap: () {
                  if (pasienList.isNotEmpty) {
                    _bukaResep(context, pasienList.first);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Belum ada pasien untuk dibuatkan resep.',
                        ),
                      ),
                    );
                  }
                },
              ),

              _buildNavItem(
                icon: Icons.person_outline_rounded,
                label: 'Profil',
                isActive: false,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Halaman Profil belum tersedia.',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ITEM BOTTOM NAVIGATION
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    const Color activeColor = Color(0xFF176EB0);
    const Color inactiveColor = Color(0xFF9AA6B2);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? activeColor : inactiveColor,
                size: 24,
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isActive
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: isActive
                      ? activeColor
                      : inactiveColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
