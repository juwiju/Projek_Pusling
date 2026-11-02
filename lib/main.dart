import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_preview/device_preview.dart';
import 'dashboard.dart';
import '../apoteker/manajemenObat.dart';
import '../apoteker/dashboard_apoteker.dart';
import '../dokter/dashboard_dokter.dart';


void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const PuslingPlusApp(),
    ),
  );
}

class PuslingPlusApp extends StatelessWidget {
  const PuslingPlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pusling+',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1689D3),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

enum UserRole { petugas, dokter, apoteker, puskesmas }

class RoleInfo {
  final String title;
  final String subtitle;
  final IconData icon;

  const RoleInfo({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

const Map<UserRole, RoleInfo> roleData = {
  UserRole.petugas: RoleInfo(
    title: 'Petugas',
    subtitle: 'Registrasi & asesmen',
    icon: Icons.person_add_alt_1_rounded,
  ),
  UserRole.dokter: RoleInfo(
    title: 'Dokter',
    subtitle: 'Pemeriksaan pasien',
    icon: Icons.favorite_border_rounded,
  ),
  UserRole.apoteker: RoleInfo(
    title: 'Apoteker',
    subtitle: 'Obat & resep',
    icon: Icons.medication_outlined,
  ),
  UserRole.puskesmas: RoleInfo(
    title: 'Puskesmas',
    subtitle: 'Jadwal & laporan',
    icon: Icons.insert_drive_file_outlined,
  ),
};

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserRole selectedRole = UserRole.petugas;
  bool obscurePassword = true;
  bool rememberMe = true;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String get selectedRoleName => roleData[selectedRole]!.title;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showMessage(String message) { 
    ScaffoldMessenger.of(context) 
    ..hideCurrentSnackBar() 
    ..showSnackBar( 
      SnackBar( 
        content: Text( 
          message, 
          style: GoogleFonts.inter( 
            color: Colors.white, 
            fontSize: 13, 
            fontWeight: FontWeight.w500, 
          ), 
        ), 
        backgroundColor: const Color(0xFF1689D3).withOpacity(0.5),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          bottom: 40,
          left: 16,
          right: 16,
        ), 
        elevation: 4, 
        shape: RoundedRectangleBorder( 
          borderRadius: BorderRadius.circular(12), 
        ), 
        duration: const Duration(seconds: 2), 
      ), 
    ); 
  }

  void showForgotPassword() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(
                  color: const Color(0x990B1728),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9DEE7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF4FF),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: const Icon(
                          Icons.mail_outline_rounded,
                          size: 40,
                          color: Color(0xFF247BC7),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Text(
                        'Pulihkan kata sandi',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF18243A),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        'Tautan pemulihan akan dikirim ke email '
                        'yang terdaftar pada akun Anda.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          height: 1.7,
                          color: const Color(0xFF748094),
                        ),
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 66,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF217DD0),
                                Color(0xFF0C91A7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
                            child: Text(
                              'Mengerti',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final headerHeight = constraints.maxHeight * 0.29;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  height: headerHeight,
                  child: const _Header(),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                  child: _LoginForm(
                    selectedRole: selectedRole,
                    onRoleChanged: (role) {
                      setState(() => selectedRole = role);
                    },
                    usernameController: usernameController,
                    passwordController: passwordController,
                    obscurePassword: obscurePassword,
                    onPasswordVisibilityChanged: () {
                      setState(() => obscurePassword = !obscurePassword);
                    },
                    rememberMe: rememberMe,
                    onRememberChanged: (value) {
                      setState(() => rememberMe = value);
                    },
                    selectedRoleName: selectedRoleName,
                    onForgotPassword: showForgotPassword,
                    onLogin: () {
                      Widget destinationPage;

                      switch (selectedRole) {
                        case UserRole.apoteker:
                          destinationPage = DashboardApoteker();
                          break;
                        case UserRole.dokter:
                          destinationPage = const DashboardDokter();
                          break;
                        case UserRole.petugas:
                          destinationPage = const Main();
                          break;
                        case UserRole.puskesmas:
                          destinationPage = const Main();
                          break;
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => destinationPage,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0875C1),
            Color(0xFF0D8FC8),
            Color(0xFF12B3A8),
          ],
          stops: [0.0, 0.58, 1.0],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            right: -38,
            top: -72,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(.14)),
              ),
            ),
          ),
          Positioned(
            right: -27,
            bottom: -60,
            child: Container(
              width: 116,
              height: 116,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(.18)),
              ),
            ),
          ),
          const Positioned(
            left: 24,
            right: 24,
            top: 39,
            child: _HeaderContent(),
          ),
        ],
      ),
    );
  }
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.14),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: Colors.white.withOpacity(.28)),
          ),
          child: const Icon(
            Icons.favorite_outline_rounded,
            color: Colors.white,
            size: 27,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'SISTEM LAYANAN KESEHATAN',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.55,
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Pusling',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 33,
                  height: 1,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -1.2,
                ),
              ),
              TextSpan(
                text: '+',
                style: GoogleFonts.inter(
                  color: const Color(0xFF57E1C4),
                  fontSize: 33,
                  height: 1,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 9),
        SizedBox(
          width: 255,
          child: Text(
            'Pelayanan kesehatan keliling yang lebih\n'
            'cepat, terhubung, dan transparan.',
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(.84),
              fontSize: 13,
              height: 1.65,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  final UserRole selectedRole;
  final ValueChanged<UserRole> onRoleChanged;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onPasswordVisibilityChanged;
  final bool rememberMe;
  final ValueChanged<bool> onRememberChanged;
  final String selectedRoleName;
  final VoidCallback onForgotPassword;
  final VoidCallback onLogin;

  const _LoginForm({
    required this.selectedRole,
    required this.onRoleChanged,
    required this.usernameController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onPasswordVisibilityChanged,
    required this.rememberMe,
    required this.onRememberChanged,
    required this.selectedRoleName,
    required this.onForgotPassword,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Masuk ke akun',
          style: GoogleFonts.inter(
            color: const Color(0xFF172B4D),
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: -.35,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Pilih peran Anda untuk melanjutkan',
          style: GoogleFonts.inter(
            color: const Color(0xFF7A8799),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 0),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: UserRole.values.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 9,
            mainAxisSpacing: 8,
            childAspectRatio: 2.42,
          ),
          itemBuilder: (context, index) {
            final role = UserRole.values[index];
            return _RoleCard(
              info: roleData[role]!,
              selected: selectedRole == role,
              onTap: () => onRoleChanged(role),
            );
          },
        ),
        const SizedBox(height: 18),
        const _FieldLabel(label: 'Email atau username'),
        const SizedBox(height: 6),
        _InputBox(
          controller: usernameController,
          hintText: 'Email atau username',
          prefixIcon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 13),
        const _FieldLabel(label: 'Kata sandi'),
        const SizedBox(height: 6),
        _InputBox(
          controller: passwordController,
          hintText: 'Kata sandi',
          prefixIcon: Icons.lock_outline_rounded,
          obscureText: obscurePassword,
          suffix: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onPasswordVisibilityChanged,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 11,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                widthFactor: 1,
                child: Text(
                  obscurePassword ? 'Lihat' : 'Sembunyikan',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF1686D2),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),
        Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: Checkbox(
                value: rememberMe,
                onChanged: (value) => onRememberChanged(value ?? false),
                activeColor: const Color(0xFF1686D2),
                side: const BorderSide(color: Color(0xFFD2DAE4)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              'Ingat saya',
              style: GoogleFonts.inter(
                color: const Color(0xFF8190A5),
                fontSize: 12,
              ),
            ),
            const Spacer(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onForgotPassword,
              child: Text(
                'Lupa kata sandi?',
                style: GoogleFonts.inter(
                  color: const Color(0xFF1686D2),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 43,
          child: ElevatedButton(
            onPressed: onLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF128FD0),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Masuk sebagai $selectedRoleName',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right_rounded, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_outline_rounded,
              size: 11,
              color: Color(0xFF9BA9B9),
            ),
            const SizedBox(width: 5),
            Text(
              'Data Anda dilindungi dan terenkripsi',
              style: GoogleFonts.inter(
                color: const Color(0xFF9BA9B9),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  final RoleInfo info;
  final bool selected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.info,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 9),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEAF5FF) : Colors.white,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: selected
                  ? const Color(0xFF1689E0)
                  : const Color(0xFFE0E6ED),
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF5FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  info.icon,
                  color: const Color(0xFF1686D2),
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF1D2D44),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      info.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8A96A6),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1689E0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
        color: const Color(0xFF53647A),
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _InputBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffix;

  const _InputBox({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFFBFCFD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E6ED)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: GoogleFonts.inter(
          color: const Color(0xFF34445B),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: const Color(0xFF1686D2),
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 11),
          prefixIcon: Icon(
            prefixIcon,
            color: const Color(0xFF94A3B5),
            size: 15,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 39,
            minHeight: 40,
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF9AA6B5),
            fontSize: 12,
          ),
          suffixIcon: suffix,
          suffixIconConstraints: const BoxConstraints( minWidth: 0, minHeight: 40, ),
        ),
      ),
    );
  }
}
