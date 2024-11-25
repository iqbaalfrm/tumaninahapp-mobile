import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WaktuSholatScreen extends StatefulWidget {
  const WaktuSholatScreen({Key? key}) : super(key: key);

  @override
  _WaktuSholatScreenState createState() => _WaktuSholatScreenState();
}

class _WaktuSholatScreenState extends State<WaktuSholatScreen> {
  Map<String, String> prayerTimes = {};

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    final url = Uri.parse(
        'http://api.aladhan.com/v1/timingsByCity?city=Tegal&country=Indonesia&method=4');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        prayerTimes = {
          'Subuh': data['data']['timings']['Fajr'],
          'Dzuhur': data['data']['timings']['Dhuhr'],
          'Ashar': data['data']['timings']['Asr'],
          'Maghrib': data['data']['timings']['Maghrib'],
          'Isya': data['data']['timings']['Isha'],
        };
      });
    } else {
      throw Exception('Failed to load prayer times');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waktu Sholat Tegal', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: prayerTimes.isNotEmpty
          ? ListView(
              children: prayerTimes.entries.map((entry) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: const Icon(Icons.access_time),
                    title: Text(entry.key),
                    trailing: Text(entry.value),
                  ),
                );
              }).toList(),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
