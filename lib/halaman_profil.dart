import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HalamanProfil extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const HalamanProfil({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<HalamanProfil> createState() => _HalamanProfilState();
}

class _HalamanProfilState extends State<HalamanProfil> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      widget.isDarkMode ? const Color(0xFF6B4226) : const Color(0xFFF5E9DA),
      appBar: AppBar(
        backgroundColor:
        widget.isDarkMode ? const Color(0xFF8B5E3C) : const Color(0xFFD7A86E),
        title: Text('Profil Akun', style: GoogleFonts.baloo2()),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          color:
          widget.isDarkMode ? const Color(0xFFD7A86E) : const Color(0xFFEAD7C2),
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/zharfan.jpg', // pastikan file ini ada di folder assets/images
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Nama: Muhammad Sulthan Zharfan',
                  style:
                  GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'NIM: 4522210016',
                  style: GoogleFonts.quicksand(fontSize: 18),
                ),
                Text(
                  'Gmail: zharfan223@gmail.com',
                  style: GoogleFonts.quicksand(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ganti Mode', style: GoogleFonts.quicksand(fontSize: 18)),
                    Switch(
                      value: _isDark,
                      activeColor: widget.isDarkMode
                          ? const Color(0xFFF5E9DA)
                          : const Color(0xFF6B4226),
                      onChanged: (value) {
                        setState(() {
                          _isDark = value;
                        });
                        widget.toggleTheme();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
