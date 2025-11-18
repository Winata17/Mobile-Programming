import 'package:flutter/material.dart';
import 'kucing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Kucing kucing1;

  @override
  void initState() {
    super.initState();
    kucing1 = Kucing('BULBUL', 4.5, 'Coklat');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pertemuan 9'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nama: ${kucing1.nama}'),
              Text('Berat: ${kucing1.berat} kg'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    kucing1.makan(kucing1, 1000); 
                  });
                },
                child: const Text('Beri makan (+1 kg)'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    kucing1.lari(); 
                  });
                },
                child: const Text('Lari (-0.5 kg)'
              )),
            ],
          ),
        ),
      ),
    );
  }
}
// ...existing code...