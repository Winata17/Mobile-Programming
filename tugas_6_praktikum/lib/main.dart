import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Formulir Mahasiswa',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const FormMahasiswaPage(),
      );
}

class FormMahasiswaPage extends StatefulWidget {
  const FormMahasiswaPage({super.key});

  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  final _formkey = GlobalKey<FormState>();
  final cNama = TextEditingController();
  final cNpm = TextEditingController();
  final cEmail = TextEditingController();
  final cAlamat = TextEditingController();

  DateTime? tglLahir;
  TimeOfDay? jamBimbingan;

  String get tglLahirLabel => tglLahir == null
      ? 'Pilih Tanggal Lahir'
      : '${tglLahir!.day}/${tglLahir!.month}/${tglLahir!.year}';

  String get jamLabel => jamBimbingan == null
      ? 'Pilih Jam Bimbingan'
      : '${jamBimbingan!.hour}:${jamBimbingan!.minute}';

  Future<void> _pickDate() async {
    final res = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (res != null) setState(() => tglLahir = res);
  }

  Future<void> _pickTime() async {
    final jam = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (jam != null) setState(() => jamBimbingan = jam);
  }

  void _kirimData() {
    if (!_formkey.currentState!.validate() ||
        tglLahir == null ||
        jamBimbingan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data belum lengkap')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HasilPage(
          nama: cNama.text,
          npm: cNpm.text,
          email: cEmail.text,
          alamat: cAlamat.text,
          tglLahir: tglLahirLabel,
          jamBimbingan: jamLabel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Formulir Mahasiswa')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                TextFormField(
                  controller: cNama,
                  decoration: const InputDecoration(labelText: 'Nama'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Nama harus diisi' : null,
                ),
                TextFormField(
                  controller: cNpm,
                  decoration: const InputDecoration(labelText: 'NPM'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'NPM harus diisi' : null,
                ),
                TextFormField(
                  controller: cEmail,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email harus diisi';
                    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
                    return ok ? null : 'Format email salah';
                  },
                ),
                TextFormField(
                  controller: cAlamat,
                  decoration: const InputDecoration(labelText: 'Alamat'),
                  maxLines: 3,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Alamat harus diisi' : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickDate,
                  child: Text(tglLahirLabel),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickTime,
                  child: Text(jamLabel),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _kirimData,
                  child: const Text('Kirim Data'),
                ),
              ],
            ),
          ),
        ),
      );
}

class HasilPage extends StatelessWidget {
  final String nama;
  final String npm;
  final String email;
  final String alamat;
  final String tglLahir;
  final String jamBimbingan;

  const HasilPage({
    super.key,
    required this.nama,
    required this.npm,
    required this.email,
    required this.alamat,
    required this.tglLahir,
    required this.jamBimbingan,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Hasil Data Mahasiswa')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama: $nama'),
                  Text('NPM: $npm'),
                  Text('Email: $email'),
                  Text('Alamat: $alamat'),
                  Text('Tanggal Lahir: $tglLahir'),
                  Text('Jam Bimbingan: $jamBimbingan'),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Kembali'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
