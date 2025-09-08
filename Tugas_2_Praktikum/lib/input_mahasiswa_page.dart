import 'package:flutter/material.dart';

class InputMahasiswaPage extends StatefulWidget {
  const InputMahasiswaPage({super.key});

  @override
  State<InputMahasiswaPage> createState() => _InputMahasiswaPageState();
}

class _InputMahasiswaPageState extends State<InputMahasiswaPage> {
  final _namaController = TextEditingController();
  final _umurController = TextEditingController();
  final _alamatController = TextEditingController();
  final _kontakController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Mahasiswa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: _umurController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Umur"),
            ),
            TextField(
              controller: _alamatController,
              decoration: const InputDecoration(labelText: "Alamat"),
            ),
            TextField(
              controller: _kontakController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Kontak"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_namaController.text.isEmpty ||
                    _umurController.text.isEmpty ||
                    _alamatController.text.isEmpty ||
                    _kontakController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Semua field harus diisi!")),
                  );
                  return;
                }

                final mahasiswa = {
                  "nama": _namaController.text,
                  "umur": _umurController.text,
                  "alamat": _alamatController.text,
                  "kontak": _kontakController.text,
                };

                Navigator.pop(context, mahasiswa);
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
