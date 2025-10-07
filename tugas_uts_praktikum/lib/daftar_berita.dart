import 'package:flutter/material.dart';

class DaftarBerita extends StatelessWidget {
  final List<Map<String, dynamic>> beritaList;

  const DaftarBerita({super.key, required this.beritaList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Berita di Kampus')),
      body: ListView.builder(
        itemCount: beritaList.length,
        itemBuilder: (context, index) {
          final berita = beritaList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              leading: Icon(
                berita['ikon'] as IconData,
                size: 40,
                color: Colors.teal,
              ),
              title: Text(
                berita['judul']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(berita['deskripsi']!),
              trailing: const Icon(Icons.bookmark_border),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mengalihkan ke halaman berita')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
