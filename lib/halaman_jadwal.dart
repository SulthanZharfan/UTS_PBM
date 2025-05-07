import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HalamanJadwal extends StatelessWidget {
  final bool isDarkMode;

  const HalamanJadwal({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, String>>> jadwalKuliah = {
      'Senin': [
        {'matkul': 'Pemrograman Berbasis M. (A)', 'jam': '08:30 - 10:30 (ON-ON)'},
        {'matkul': 'E-Business(A)', 'jam': '10:30 - 13:00 (OFF-ON)'},
      ],
      'Selasa': [
        {'matkul': 'Metodologi Penelitian(A)', 'jam': '11:20 - 13:50 (ON-OFF)'},
        {'matkul': 'Prak. PBM(A)', 'jam': '13:50 - 16:20 (ON-OFF)'},
      ],
      'Rabu': [
        {'matkul': 'Manajemen Proyek(B)', 'jam': '09:40 - 12:10 (OFF-ON)'},
        {'matkul': 'AsDos Prak. Jarkom(B)', 'jam': '14:20 - 17:10 (ON-ON)'},
      ],
      'Kamis': [
        {'matkul': 'Enterprise Software E. (A)', 'jam': '10:30 - 13:00 (OFF-ON)'},
      ],
      'Jumat': [
        {'matkul': 'Geoinformatika(A)', 'jam': '08:00 - 09:40 (OFF-ON)'},
      ],
    };

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF6B4226) : const Color(0xFFF5E9DA),
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF8B5E3C) : const Color(0xFFD7A86E),
        title: Text('Jadwal Kuliah', style: GoogleFonts.baloo2()),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: jadwalKuliah.entries.map((entry) {
          String hari = entry.key;
          List<Map<String, String>> matkulList = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  hari,
                  style: GoogleFonts.baloo2(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              ...matkulList.map((item) => Card(
                color: isDarkMode ? const Color(0xFFD7A86E) : const Color(0xFFEAD7C2),
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  title: Text(
                    item['matkul']!,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.black : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    item['jam']!,
                    style: GoogleFonts.quicksand(
                      color: isDarkMode ? Colors.black87 : Colors.black87,
                    ),
                  ),
                ),
              )),
              const SizedBox(height: 10),
            ],
          );
        }).toList(),
      ),
    );
  }
}
