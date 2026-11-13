import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef DataMap = Map<String, dynamic>;

void showDetailResepModal(
  BuildContext context, {
  required DataMap pasien,
  VoidCallback? onVerifikasi,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DetailResepBottomSheet(
      pasien: pasien,
      onVerifikasi: onVerifikasi,
    ),
  );
}

class DetailResepBottomSheet extends StatelessWidget {
  final DataMap pasien;
  final VoidCallback? onVerifikasi;

  const DetailResepBottomSheet({
    super.key,
    required this.pasien,
    this.onVerifikasi,
  });

  static const Color primaryBlue = Color(0xFF1686D2);
  static const Color darkText = Color(0xFF0F172A);
  static const Color mutedText = Color(0xFF64748B);
  static const Color softBg = Color(0xFFF4F8FB);
  static const Color lightBlue = Color(0xFFEAF4FF);

  @override
  Widget build(BuildContext context) {
    final List<dynamic> rawList = (pasien['obatList'] as List<dynamic>?) ?? [];
    final List<DataMap> daftarObat =
        rawList.map((e) => DataMap.from(e as Map)).toList();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.90,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // DRAG HANDLE BAR
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFCBD5E1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),

          // HEADER PASIEN & TOMBOL CLOSE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DETAIL RESEP',
                        style: GoogleFonts.inter(
                          color: primaryBlue,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pasien['nama'] ?? 'Siti Aminah',
                        style: GoogleFonts.inter(
                          color: darkText,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${pasien['nomorAntrean'] ?? 'A-021'} • ${pasien['umur'] ?? '62 th'} • ${pasien['kategori'] ?? 'Lansia'}',
                        style: GoogleFonts.inter(
                          color: mutedText,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFF475569),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // KONTEN SCROLLABLE
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // BOX INFO RESEP, DOKTER & DIAGNOSIS
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: softBg,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nomor resep',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: mutedText,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    pasien['nomorResep'] ?? 'RX-250618-021',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: darkText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dokter',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: mutedText,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    pasien['dokter'] ?? 'dr. Raka Pratama',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: darkText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Diagnosis',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: mutedText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pasien['diagnosis'] ?? 'Demam dan nyeri ringan',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // JUDUL SECTION OBAT YANG DIRESEPKAN
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Obat yang diresepkan',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${daftarObat.length} jenis obat dari stok apotek',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: mutedText,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: lightBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${daftarObat.length} item',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryBlue,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // LIST KARTU OBAT
                  ...daftarObat.map((obat) => _buildObatResepCard(obat)),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // TOMBOL BAWAH (KEMBALI & VERIFIKASI RESEP)
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade100),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Kembali',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [primaryBlue, Color(0xFF0E88BA)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            if (onVerifikasi != null) {
                              onVerifikasi!();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Verifikasi resep',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
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
    );
  }

  Widget _buildObatResepCard(DataMap obat) {
    final int stokAwal = obat['stokTersedia'] ?? 0;
    final int jumlah = obat['jumlahAngka'] ?? 0;
    final int sisaStok = stokAwal - jumlah;
    final String satuan = obat['satuan'] ?? 'tablet';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER KODE OBAT (BIRU MUDA)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(19)),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.medication_outlined,
                    color: primaryBlue,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KODE OBAT',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: mutedText,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      obat['kodeObat'] ?? '-',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // BODY DETAIL OBAT
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            obat['nama'] ?? '',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Merek: ${obat['merek']} • ${obat['kategori']}',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: mutedText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4F7EF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$stokAwal tersedia',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F9D7A),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // JUMLAH DIBERIKAN & ATURAN PAKAI
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jumlah diberikan',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: mutedText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$jumlah $satuan',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: darkText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aturan pakai',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: mutedText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              obat['aturanPakai'] ?? '-',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: darkText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const Divider(height: 22, color: Color(0xFFF1F5F9)),

                // STOK SETELAH DISERAHKAN
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Stok setelah diserahkan',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: mutedText,
                      ),
                    ),
                    Text(
                      '$stokAwal → $sisaStok $satuan',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: darkText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}