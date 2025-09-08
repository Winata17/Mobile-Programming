import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'input_mahasiswa_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String, dynamic>? mahasiswa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Page")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: const Text("Profile Page"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InputMahasiswaPage(),
                  ),
                );

                if (result != null) {
                  setState(() {
                    mahasiswa = result;
                  });
                }
              },
              child: const Text("Input Mahasiswa"),
            ),
            const SizedBox(height: 16),
            if (mahasiswa != null) ...[
              Text("Nama: ${mahasiswa!['nama']}"),
              Text("Umur: ${mahasiswa!['umur']}"),
              Text("Alamat: ${mahasiswa!['alamat']}"),
              Text("Kontak: ${mahasiswa!['kontak']}"),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final kontak = mahasiswa!['kontak'];
                  final uri = Uri.parse("tel:$kontak");

                  if (!await launchUrl(uri)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Tidak bisa membuka aplikasi telepon"),
                      ),
                    );
                  }
                },
                child: const Text("Call"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
