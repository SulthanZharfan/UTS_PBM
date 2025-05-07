import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HalamanHome extends StatefulWidget {
  final bool isDarkMode;

  const HalamanHome({super.key, required this.isDarkMode});

  @override
  State<HalamanHome> createState() => _HalamanHomeState();
}

class _HalamanHomeState extends State<HalamanHome> {
  final List<Map<String, dynamic>> tugasList = [];
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('tasks');
    if (data != null) {
      setState(() {
        tugasList.clear();
        tugasList.addAll(List<Map<String, dynamic>>.from(jsonDecode(data)));
      });
    }
  }

  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(tugasList);
    await prefs.setString('tasks', encodedData);
  }

  void _tambahTugas() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: widget.isDarkMode ? const Color(0xFF6B4226) : const Color(0xFFF5E9DA),
          title: Text('Tambah Tugas', style: GoogleFonts.baloo2()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Tugas'),
              ),
              TextField(
                controller: _deadlineController,
                decoration: const InputDecoration(labelText: 'Deadline (misal: 20:00)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _namaController.clear();
                _deadlineController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_namaController.text.isNotEmpty) {
                  setState(() {
                    tugasList.add({
                      'nama': _namaController.text,
                      'deadline': _deadlineController.text,
                      'selesai': false,
                    });
                  });
                  _saveTasks();
                  _namaController.clear();
                  _deadlineController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _resetTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('tasks');
    setState(() {
      tugasList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? const Color(0xFF6B4226) : const Color(0xFFF5E9DA),
      appBar: AppBar(
        backgroundColor: widget.isDarkMode ? const Color(0xFF8B5E3C) : const Color(0xFFD7A86E),
        title: Text('Home', style: GoogleFonts.baloo2()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _resetTasks,
            tooltip: 'Reset Semua Tugas',
          ),
        ],
      ),
      body: tugasList.isEmpty
          ? Center(
        child: Text(
          'Belum ada tugas.\nKlik tombol + di bawah untuk menambah.',
          textAlign: TextAlign.center,
          style: GoogleFonts.quicksand(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: tugasList.length,
        padding: const EdgeInsets.only(bottom: 80),
        itemBuilder: (context, index) {
          var item = tugasList[index];
          return Card(
            color: widget.isDarkMode ? const Color(0xFFD7A86E) : const Color(0xFFEAD7C2),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: ListTile(
              leading: Checkbox(
                value: item['selesai'] ?? false,
                activeColor: widget.isDarkMode ? const Color(0xFFF5E9DA) : const Color(0xFF6B4226),
                onChanged: (bool? value) {
                  setState(() {
                    item['selesai'] = value ?? false;
                  });
                  _saveTasks();
                },
              ),
              title: Text(
                item['nama'] ?? '',
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  decoration: (item['selesai'] ?? false) ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                'Deadline: ${item['deadline'] ?? ''}',
                style: GoogleFonts.quicksand(),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: _tambahTugas,
          backgroundColor: widget.isDarkMode ? const Color(0xFF8B5E3C) : const Color(0xFFD7A86E),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
