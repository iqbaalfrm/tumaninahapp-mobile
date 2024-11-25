import 'package:flutter/material.dart';

class PantauSholatScreen extends StatefulWidget {
  const PantauSholatScreen({Key? key}) : super(key: key);

  @override
  _PantauSholatScreenState createState() => _PantauSholatScreenState();
}

class _PantauSholatScreenState extends State<PantauSholatScreen> {
  // Milestone status untuk setiap sholat (contoh data awal)
  final Map<String, bool> sholatMilestones = {
    'Shubuh': false,
    'Dzuhur': false,
    'Ashar': false,
    'Maghrib': false,
    'Isya': false,
  };

  void toggleSholat(String sholat) {
    setState(() {
      sholatMilestones[sholat] = !sholatMilestones[sholat]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantau Sholat', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: sholatMilestones.entries.map((entry) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(
                entry.value ? Icons.check_circle : Icons.radio_button_unchecked,
                color: entry.value ? Colors.green : Colors.grey,
              ),
              title: Text(
                entry.key,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: entry.value ? Colors.green : Colors.black,
                ),
              ),
              trailing: Switch(
                value: entry.value,
                onChanged: (bool value) {
                  toggleSholat(entry.key);
                },
              ),
              onTap: () {
                toggleSholat(entry.key);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
