import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'antrean.dart';
import 'pendaftaran.dart';


class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  static const Color darkText = Color(0xFF243447);
  static const Color mutedText = Color(0xFF7B8794);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
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
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle_outlined),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SAPAAN
                const Text(
                  'Minggu, 27 September 2026',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),

                const Text(
                  'Selamat Pagi, Sari!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 4),

                const Text(
                  'Petugas Pusling',
                  style: TextStyle(color: Colors.blue),
                ),
                const SizedBox(height: 24),

                
                _buildTodayCard(),
                const SizedBox(height: 24),

                
                _buildSectionTitle(
                  'Ringkasan hari ini',
                  'Pembaruan secara real-time',
                  trailing: _buildLiveBadge(),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        '24',
                        'Total pasien',
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildStatCard(
                        '08',
                        'Menunggu pelayanan',
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildStatCard(
                        '16',
                        'Sudah dilayani',
                        Colors.teal,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                
                _buildSectionTitle(
                  'Akses cepat',
                  'Kelola layanan Pusling',
                  trailing: const SizedBox.shrink(),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child:_buildQuickMenu(
                        icon: Icons.person_add_alt_1,
                        title: 'Daftar & Asesmen',
                        color: const Color(0xFF3994E8),
                        backgroundColor: const Color(0xFFEAF4FF),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrasiScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildQuickMenu(
                        icon: Icons.monitor_heart_outlined,
                        title: 'Pasien hari ini',
                        color: const Color(0xFF36B49A),
                        backgroundColor: const Color(0xFFE6F8F2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildQuickMenu(
                        icon: Icons.favorite_border,
                        title: 'Layanan & biaya',
                        color: const Color(0xFFE47791),
                        backgroundColor: const Color(0xFFFFEEF2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildQuickMenu(
                        icon: Icons.receipt_long_outlined,
                        title: 'Buat laporan',
                        color: const Color(0xFFE6A637),
                        backgroundColor: const Color(0xFFFFF5DE),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ANTREAN TERBARU
                _buildSectionTitle(
                  'Antrean terbaru',
                  'Daftar pasien hari ini',
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AntreanPasienPage(),
                        ),
                      );
                    },
                    child: const Text('Lihat semua'),
                  ),
                ),
                const SizedBox(height: 16),

                _buildPatientCard(
                  queueNumber: 'A-017',
                  name: 'Budi Santoso',
                  details: '45 tahun • Laki-laki',
                  status: 'Selesai',
                  statusColor: const Color(0xFF269B7B),
                  statusBackground: const Color(0xFFE4F7EF),
                ),
                const SizedBox(height: 12),

                _buildPatientCard(
                  queueNumber: 'A-018',
                  name: 'Siti Aminah',
                  details: '32 tahun • Perempuan',
                  status: 'Dilayani',
                  statusColor: const Color(0xFF3478D4),
                  statusBackground: const Color(0xFFE8F1FF),
                ),
                const SizedBox(height: 12),

                _buildPatientCard(
                  queueNumber: 'A-019',
                  name: 'Andi Pratama',
                  details: '27 tahun • Laki-laki',
                  status: 'Menunggu',
                  statusColor: const Color(0xFFD99424),
                  statusBackground: const Color(0xFFFFF3D9),
                ),

                const SizedBox(height: 24),
              ],
            ),
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
                  'BERLANGSUNG HARI INI',
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
              const SizedBox(width: 4),

              const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),

          const SizedBox(height: 26),

          const Text(
            'Pusling Kelurahan Sukamaju',
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

          Row(
            children: [
              const Expanded(
                child: Text(
                  'Progress pelayanan',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ),
              const Text(
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
  
  
  Widget _buildQuickMenu({
    required IconData icon,
    required String title,
    required Color color,
    required Color backgroundColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 21,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: darkText,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: mutedText,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildPatientCard({
    required String queueNumber,
    required String name,
    required String details,
    required String status,
    required Color statusColor,
    required Color statusBackground,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
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
                  queueNumber,
                  style: const TextStyle(
                    fontSize: 11,
                    color: mutedText,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  details,
                  style: const TextStyle(
                    fontSize: 11,
                    color: mutedText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 6),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: statusBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 10,
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
            ),
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
                label: 'Antrean',
                isActive: false,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AntreanPasienPage(),
                    ),
                  );
                },
              ),
              _buildNavItem(
                icon: Icons.calendar_month_outlined,
                label: 'Jadwal',
                isActive: false,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Halaman Jadwal belum dibuat.'),
                    ),
                  );
                },
              ),
              _buildNavItem(
                icon: Icons.person_outline_rounded,
                label: 'Profil',
                isActive: false,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Halaman Profil belum dibuat.'),
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
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.normal,
                  color: isActive ? activeColor : inactiveColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}