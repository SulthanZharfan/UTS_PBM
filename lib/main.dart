import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'halaman_home.dart';
import 'halaman_jadwal.dart';
import 'halaman_profil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HalamanHome(isDarkMode: _isDarkMode),
      HalamanJadwal(isDarkMode: _isDarkMode),
      HalamanProfil(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.quicksandTextTheme(),
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor:
          _isDarkMode ? const Color(0xFF8B5E3C) : const Color(0xFFD7A86E),
          selectedItemColor:
          _isDarkMode ? const Color(0xFFF5E9DA) : const Color(0xFF6B4226),
          unselectedItemColor: Colors.grey[600],
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }
}
