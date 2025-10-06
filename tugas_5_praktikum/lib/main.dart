import 'package:flutter/material.dart';

void main() => runApp(const DaftarBeritaApp());

class DaftarBeritaApp extends StatelessWidget {
  const DaftarBeritaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Berita',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DaftarBeritaPage(),
    );
  }
}

class DaftarBeritaPage extends StatelessWidget {
  const DaftarBeritaPage({super.key});

  final List<Map<String, String>> berita = const [
    {
      'judul': 'HEBOH! Burung Hantu kepalanya bisa muter 180 derajat',
      'deskripsi': 'Liat gaess burung hantu bisa nengok 180 derajat gitu, amazing.',
      'gambar': 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    },
    {
      'judul': 'AI',
      'deskripsi': 'Kecerdasan buatan akan menggantikan manusia atau tidak ya?.',
      'gambar': 'https://images.unsplash.com/photo-1518770660439-4636190af475',
    },
    {
      'judul': 'Tangan robot ditemukan di antartika',
      'deskripsi': 'Tangan robot ini bisa menembakan laser? titisan iron man?.',
      'gambar': 'https://images.unsplash.com/photo-1581090464777-f3220bbe1b8b',
    },
    {
      'judul': 'Startup UNSIKA',
      'deskripsi': 'HEBOHHHH, UNSIKA mendirikan start up dibanding gedung.',
      'gambar': 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Berita / Artikel')),
      body: ListView.builder(
        itemCount: berita.length,
        itemBuilder: (context, index) {
          final item = berita[index];
          return ListTile(
            leading: Image.network(
              item['gambar']!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(
              item['judul']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item['deskripsi']!),
            trailing: const Icon(Icons.bookmark_border),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mengalihkan ke halaman berita')),
              );
            },
          );
        },
      ),
    );
  }
}
