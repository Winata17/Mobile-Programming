import 'package:flutter/material.dart';

class TambahBerita extends StatefulWidget {
  final Function(String, String, IconData) onAddBerita;
  const TambahBerita({super.key, required this.onAddBerita});

  @override
  State<TambahBerita> createState() => _TambahBeritaState();
}

class _TambahBeritaState extends State<TambahBerita> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  IconData? _selectedIcon;

  final List<Map<String, dynamic>> _iconOptions = [
    {'label': 'Kucing', 'icon': Icons.pets},
    {'label': 'Burung', 'icon': Icons.emoji_nature},
    {'label': 'Kelinci', 'icon': Icons.grass},
    {'label': 'Harimau', 'icon': Icons.filter_hdr},
    {'label': 'Ikan', 'icon': Icons.bubble_chart},
  ];

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedIcon != null) {
      widget.onAddBerita(
        _judulController.text,
        _deskripsiController.text,
        _selectedIcon!,
      );
      _judulController.clear();
      _deskripsiController.clear();
      _selectedIcon = null;
    } else if (_selectedIcon == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih ikon terlebih dahulu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Berita')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul Berita',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Judul wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Berita',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Deskripsi wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<IconData>(
                decoration: const InputDecoration(
                  labelText: 'Pilih Ikon Hewan',
                  border: OutlineInputBorder(),
                ),
                items: _iconOptions.map((item) {
                  return DropdownMenuItem<IconData>(
                    value: item['icon'],
                    child: Row(
                      children: [
                        Icon(item['icon'], color: Colors.teal),
                        const SizedBox(width: 8),
                        Text(item['label']),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedIcon = value),
                validator: (value) =>
                    value == null ? 'Ikon harus dipilih' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.save),
                label: const Text('Simpan Berita'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
