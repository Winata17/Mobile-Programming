import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Halaman formulir',
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
  final cnpm = TextEditingController();
  final cEmail = TextEditingController();
  final cAlamat = TextEditingController();
  final cNoHP = TextEditingController();

  DateTime? tglLahir;
  TimeOfDay? jamBimbingan;
  String? jenisKelamin;

  String get tglLahirLabel => tglLahir == null
      ? 'Pilih Tanggal Lahir'
      : '${tglLahir!.day}/${tglLahir!.month}/${tglLahir!.year}';
  String get jamLabel => jamBimbingan == null
      ? 'Pilih Jam Bimbingan'
      : '${jamBimbingan!.hour}:${jamBimbingan!.minute.toString().padLeft(2, '0')}';

  @override
  void dispose() {
    cNama.dispose();
    cnpm.dispose();
    cEmail.dispose();
    cAlamat.dispose();
    cNoHP.dispose();
    super.dispose();
  }

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
    if (jam != null) {
      setState(() {
        jamBimbingan = jam;
      });
    }
  }

  void _simpan() {
    if (!_formkey.currentState!.validate() ||
        tglLahir == null ||
        jamBimbingan == null ||
        jenisKelamin == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data belum lengkap')));
      return;
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ringkasan Data'),
        content: Text(
          'Nama: ${cNama.text}\n'
          'NPM: ${cnpm.text}\n'
          'Email: ${cEmail.text}\n'
          'No HP: ${cNoHP.text}\n'
          'Alamat: ${cAlamat.text}\n'
          'Jenis Kelamin: $jenisKelamin\n'
          'Tanggal Lahir: $tglLahirLabel\n'
          'Jam Bimbingan: $jamLabel\n',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
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
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Nama harus diisi' : null,
                ),
                TextFormField(
                  controller: cnpm,
                  decoration: const InputDecoration(
                    labelText: 'NPM',
                    prefixIcon: Icon(Icons.badge),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'NPM harus diisi' : null,
                ),
                TextFormField(
                  controller: cEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email harus diisi';
                    final ok = RegExp(r'^[^@]+@unsika\.ac\.id$').hasMatch(v.trim());
                    return ok ? null : 'Gunakan email @unsika.ac.id';
                  },
                ),
                TextFormField(
                  controller: cNoHP,
                  decoration: const InputDecoration(
                    labelText: 'No HP',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'No HP harus diisi';
                    if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
                      return 'Hanya boleh angka';
                    }
                    if (v.length < 10) return 'Minimal 10 digit';
                    return null;
                  },
                ),
                TextFormField(
                  controller: cAlamat,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    prefixIcon: Icon(Icons.home),
                  ),
                  maxLines: 3,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Alamat harus diisi' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: jenisKelamin,
                  decoration: const InputDecoration(
                    labelText: 'Jenis Kelamin',
                    prefixIcon: Icon(Icons.people),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
                    DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
                  ],
                  onChanged: (val) => setState(() => jenisKelamin = val),
                  validator: (v) =>
                      v == null ? 'Pilih jenis kelamin' : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.date_range),
                  label: Text(tglLahirLabel),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickTime,
                  icon: const Icon(Icons.access_time),
                  label: Text(jamLabel),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _simpan,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      );
}
