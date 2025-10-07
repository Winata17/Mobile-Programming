import 'package:flutter/material.dart';
import 'daftar_berita.dart';
import 'tambah_berita.dart';

void main() {
  runApp(const BeritaApp());
}

class BeritaApp extends StatelessWidget {
  const BeritaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita Kampus UNSIKA',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _beritaList = [
    {
      'judul': 'Kucing Kampus Mendapat Rumah Baru',
      'deskripsi': 'Mahasiswa merawat kucing liar dan membangun rumah mini untuknya.',
      'ikon': Icons.pets
    },
    {
      'judul': 'Burung Hantu Nongol di Gedung Rektorat',
      'deskripsi': 'Burung hantu terlihat bertengger di atap gedung rektorat malam tadi.',
      'ikon': Icons.visibility
    },
    {
      'judul': 'Kelinci di Taman Menjadi Daya Tarik Baru',
      'deskripsi': 'Beberapa mahasiswa memelihara kelinci di taman baca kampus.',
      'ikon': Icons.grass
    },
  ];

  void _tambahBerita(String judul, String deskripsi, IconData ikon) {
    setState(() {
      _beritaList.add({
        'judul': judul,
        'deskripsi': deskripsi,
        'ikon': ikon,
      });
      _selectedIndex = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Berita berhasil ditambahkan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DaftarBerita(beritaList: _beritaList),
      TambahBerita(onAddBerita: _tambahBerita),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Daftar'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Tambah'),
        ],
      ),
    );
  }
}
