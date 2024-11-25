import 'package:flutter/material.dart';

class SholatScreen extends StatelessWidget {
  const SholatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> sholatMovements = [
      {'movement': 'Takbiratul Ihram', 'image': 'assets/pilihGerakan/takbir.png'},
      {'movement': 'Ruku\'', 'image': 'assets/pilihGerakan/ruku.png'},
      {'movement': 'I\'tidal', 'image': 'assets/pilihGerakan/itidal.png'},
      {'movement': 'Sujud', 'image': 'assets/pilihGerakan/sujud.png'},
      {'movement': 'Duduk di Antara Dua Sujud', 'image': 'assets/pilihGerakan/duduk.png'},
      {'movement': 'Tasyahud Akhir', 'image': 'assets/pilihGerakan/tasyahud.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Gerakan Sholat', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dua kolom
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8, // Mengatur proporsi lebar dan tinggi kotak
          ),
          itemCount: sholatMovements.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Aksi ketika kotak ditekan
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      sholatMovements[index]['image']!,
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      sholatMovements[index]['movement']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
