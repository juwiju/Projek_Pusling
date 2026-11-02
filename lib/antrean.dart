import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'dashboard.dart';


class PuslingApp extends StatelessWidget {
  const PuslingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pusling+',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF3F7FA),
      ),
      home: const AntreanPasienPage(),
    );
  }
}

class Pasien {
  final String nomor;
  final String nama;
  final String umur;
  final String keterangan;
  String status;

  Pasien({
    required this.nomor,
    required this.nama,
    required this.umur,
    required this.keterangan,
    required this.status,
  });
}

class AntreanPasienPage extends StatefulWidget {
  final Function(Pasien pasien)? onPilihPasien;

  const AntreanPasienPage({
    super.key,
    this.onPilihPasien,
  });

  @override
  State<AntreanPasienPage> createState() => _AntreanPasienPageState();
}

class _AntreanPasienPageState extends State<AntreanPasienPage> {
  static const Color biru = Color(0xFF168CC4);
  static const Color biruTua = Color(0xFF147EA6);
  static const Color latar = Color(0xFFF3F7FA);
  static const Color abu = Color(0xFF8997A1);
  static const Color garis = Color(0xFFEAF0F4);

  final TextEditingController pencarianController =
      TextEditingController();

  String filterAktif = 'Semua';
  int halamanAktif = 1;
  int nomorAntreanBerikutnya = 21;

  final List<Pasien> daftarPasien = [
    Pasien(
      nomor: 'A-021',
      nama: 'Siti Aminah',
      umur: '62 th',
      keterangan: 'Lansia',
      status: 'Menunggu',
    ),
    Pasien(
      nomor: 'A-020',
      nama: 'Budi Santoso',
      umur: '45 th',
      keterangan: 'Dewasa',
      status: 'Asesmen selesai',
    ),
    Pasien(
      nomor: 'A-019',
      nama: 'Nadia Putri',
      umur: '28 th',
      keterangan: 'Ibu hamil',
      status: 'Diperiksa',
    ),
    Pasien(
      nomor: 'A-018',
      nama: 'Rafi Pratama',
      umur: '8 th',
      keterangan: 'Anak',
      status: 'Selesai',
    ),
    Pasien(
      nomor: 'A-017',
      nama: 'Kartini',
      umur: '71 th',
      keterangan: 'Lansia',
      status: 'Selesai',
    ),
  ];

  List<Pasien> get pasienTerfilter {
    final kataKunci = pencarianController.text.toLowerCase();

    return daftarPasien.where((pasien) {
      final cocokPencarian =
          pasien.nama.toLowerCase().contains(kataKunci) ||
          pasien.nomor.toLowerCase().contains(kataKunci);

      bool cocokStatus;

      if (filterAktif == 'Semua') {
        cocokStatus = true;
      } else if (filterAktif == 'Menunggu') {
        cocokStatus = pasien.status == 'Menunggu';
      } else {
        cocokStatus = pasien.status == 'Selesai';
      }

      return cocokPencarian && cocokStatus;
    }).toList();
  }

  @override
  void dispose() {
    pencarianController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latar,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 20),
                children: [
                  _buildJudul(),
                  const SizedBox(height: 20),
                  _buildPencarian(),
                  const SizedBox(height: 10),
                  _buildFilter(),
                  const SizedBox(height: 14),
                  _buildPanggilAntrean(),
                  const SizedBox(height: 18),
                  _buildDaftarAntrean(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 13,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.favorite_border,
            color: biruTua,
            size: 23,
          ),
          const SizedBox(width: 6),
          const Text(
            'Pusling+',
            style: TextStyle(
              color: biruTua,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F6F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications_none,
                  color: Color(0xFF46535C),
                  size: 23,
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.pinkAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [biru, biruTua],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'PE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _buildJudul() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PELAYANAN HARI INI',
          style: TextStyle(
            color: biruTua,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.7,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Antrean pasien',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
            color: Color(0xFF273540),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${pasienTerfilter.length} data ditampilkan',
          style: const TextStyle(
            fontSize: 11,
            color: abu,
          ),
        ),
      ],
    );
  }

  
  Widget _buildPencarian() {
    return Container(
      height: 43,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: pencarianController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(
          hintText: 'Cari nama atau nomor antrean',
          hintStyle: TextStyle(
            fontSize: 11,
            color: Color(0xFFA4AFB7),
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 19,
            color: Color(0xFFA4AFB7),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  
  Widget _buildFilter() {
    final pilihan = ['Semua', 'Menunggu', 'Selesai'];

    return Row(
      children: pilihan.map((pilihanFilter) {
        final aktif = filterAktif == pilihanFilter;

        return Padding(
          padding: const EdgeInsets.only(right: 7),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              setState(() {
                filterAktif = pilihanFilter;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: aktif ? const Color(0xFFE5F4FB) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: aktif ? const Color(0xFFB4D9E8) : garis,
                  width: aktif ? 1.4 : 1,
                ),
              ),
              child: Text(
                pilihanFilter,
                style: TextStyle(
                  fontSize: 10,
                  color: aktif ? biruTua : abu,
                  fontWeight:
                      aktif ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  
  Widget _buildPanggilAntrean() {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: _panggilBerikutnya,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF1685D0),
              Color(0xFF1396A5),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: biru.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.17),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Panggil antrean berikutnya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Antrean berikutnya A-${nomorAntreanBerikutnya.toString().padLeft(3, '0')}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 21,
            ),
          ],
        ),
      ),
    );
  }

  void _panggilBerikutnya() {
    final indeks = daftarPasien.indexWhere(
      (pasien) => pasien.status == 'Menunggu',
    );

    setState(() {
      if (indeks != -1) {
        daftarPasien[indeks].status = 'Diperiksa';
        nomorAntreanBerikutnya++;
      } else {
        nomorAntreanBerikutnya++;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          indeks != -1
              ? 'Antrean berhasil dipanggil.'
              : 'Nomor antrean berikutnya telah diperbarui.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  
  Widget _buildDaftarAntrean() {
    final data = pasienTerfilter;

    return Container(
      padding: const EdgeInsets.only(top: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFF0F3F5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Daftar antrean',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF34414A),
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Urut berdasarkan waktu kedatangan',
              style: TextStyle(
                fontSize: 10,
                color: abu,
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (data.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Data antrean tidak ditemukan.',
                  style: TextStyle(
                    color: abu,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          else
            ...data.map(_buildItemPasien),
        ],
      ),
    );
  }

  Widget _buildItemPasien(Pasien pasien) {
    return InkWell(
      onTap: () {
        if (widget.onPilihPasien != null) {
          widget.onPilihPasien!(pasien);
        } else {
          _tampilkanDetail(pasien);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 13,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFF0F3F5)),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F3FC),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                pasien.nomor,
                style: const TextStyle(
                  color: biruTua,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pasien.nama,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF35414A),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${pasien.umur} · ${pasien.keterangan}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: abu,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: _labelStatus(pasien.status),
            ),
            const SizedBox(width: 3),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF697781),
              size: 19,
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _labelStatus(String status) {
    Color warna;
    Color teks;

    switch (status) {
      case 'Menunggu':
        warna = const Color(0xFFFFF3D5);
        teks = const Color(0xFFAE8629);
        break;
      case 'Asesmen selesai':
        warna = const Color(0xFFE3F7F2);
        teks = const Color(0xFF319D8A);
        break;
      case 'Diperiksa':
        warna = const Color(0xFFE1F3FA);
        teks = const Color(0xFF3186A5);
        break;
      case 'Selesai':
        warna = const Color(0xFFE1F5ED);
        teks = const Color(0xFF39977B);
        break;
      default:
        warna = const Color(0xFFF0F0F0);
        teks = abu;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        status,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: teks,
          fontSize: 8,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  
  void _tampilkanDetail(Pasien pasien) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Detail Antrean Pasien',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 18),
              _barisDetail('Nomor antrean', pasien.nomor),
              _barisDetail('Nama pasien', pasien.nama),
              _barisDetail('Umur', pasien.umur),
              _barisDetail('Keterangan', pasien.keterangan),
              _barisDetail('Status', pasien.status),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: biru,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _barisDetail(String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              judul,
              style: const TextStyle(
                color: abu,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            isi,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _buildBottomNavigation() {
    final menu = [
      [Icons.home_outlined, 'Beranda'],
      [Icons.person_add_alt_1_outlined, 'Antrean'],
      [Icons.calendar_month_outlined, 'Jadwal'],
      [Icons.person_outline, 'Profil'],
    ];

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 7),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEAF0F4)),
        ),
      ),
      child: Row(
        children: List.generate(menu.length, (index) {
          final aktif = halamanAktif == index;

          return Expanded(
            child: InkWell(
              onTap: () {
                if (index == 0) {
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Main(),
                    ),
                    );
                } else if (index == 1) {
                    setState(() {
                    halamanAktif = 1;
                    });
                } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                        '${menu[index][1]} belum dihubungkan.',
                        ),
                        duration: const Duration(seconds: 1),
                    ),
                    );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      menu[index][0] as IconData,
                      size: 21,
                      color: aktif ? biruTua : abu,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      menu[index][1] as String,
                      style: TextStyle(
                        fontSize: 9,
                        color: aktif ? biruTua : abu,
                        fontWeight:
                            aktif ? FontWeight.w800 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}