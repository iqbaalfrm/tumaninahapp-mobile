import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'waktu_sholat_screen.dart';
import 'chat_screen.dart';
import 'belajar_sholat_screen.dart';
import 'login_screen.dart';
import 'pantau_sholat_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, String> prayerTimes = {};
  String nextPrayer = '';
  String timeRemaining = '';

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
        calculateNextPrayer();
      });
    } else {
      throw Exception('Failed to load prayer times');
    }
  }

  void calculateNextPrayer() {
    final now = DateTime.now();
    DateTime? nearestTime;
    String nearestPrayer = '';

    prayerTimes.forEach((prayer, time) {
      final prayerTimeToday = DateFormat('HH:mm').parse(time);
      final prayerDateTime = DateTime(
          now.year, now.month, now.day, prayerTimeToday.hour, prayerTimeToday.minute);

      if (prayerDateTime.isAfter(now) && (nearestTime == null || prayerDateTime.isBefore(nearestTime!))) {
        nearestTime = prayerDateTime;
        nearestPrayer = prayer;
      }
    });

    if (nearestTime != null) {
      setState(() {
        nextPrayer = nearestPrayer;
        final difference = nearestTime!.difference(now);
        timeRemaining = '${difference.inHours} jam ${difference.inMinutes % 60} menit Menuju Waktu Sholat';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSlider(),
              const SizedBox(height: 20),
              const Text(
                'Assalamu\'alaikum',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                'Semangat para penghuni surga',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              _buildMenuRow(context),
              const SizedBox(height: 20),
              _buildNextPrayerCard(),
              const SizedBox(height: 20),
              const Text('Sudah Sholat?', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              _buildPrayerChecklist(),
              const SizedBox(height: 20),
              const Text(
                'Ayat-ayat Pendek Al-Qur\'an',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              _buildAyatList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Tumaninah', style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.logout, color: Colors.black),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.notifications, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildImageSlider() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildImageCard('assets/assetsHome/image1.png'),
          _buildImageCard('assets/assetsHome/image2.png'),
          _buildImageCard('assets/assetsHome/image3.png'),
        ],
      ),
    );
  }

  Widget _buildMenuRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMenuButton(Icons.book, 'Belajar Sholat', onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BelajarSholatScreen()),
          );
        }),
        _buildMenuButton(Icons.monitor, 'Pantau Sholat', onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PantauSholatScreen()),
          );
        }),
        _buildMenuButton(Icons.access_time, 'Waktu Sholat', onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WaktuSholatScreen()),
          );
        }),
        _buildMenuButton(Icons.chat, 'Chatbot', onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        }),
      ],
    );
  }

  Widget _buildNextPrayerCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.access_time),
        title: Text(nextPrayer.isNotEmpty ? nextPrayer : 'Mengambil data...'),
        subtitle: Text(timeRemaining.isNotEmpty ? timeRemaining : 'Menghitung waktu...'),
        trailing: nextPrayer.isNotEmpty ? Text(prayerTimes[nextPrayer] ?? '') : null,
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {
        if (index == 2) { 
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        } else if (index == 1) {
          // Tambahkan aksi untuk Pengaturan jika diperlukan
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Pengaturan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }

  Widget _buildImageCard(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String label, {void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildPrayerChecklist() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPrayerItem('Shubuh'),
            _buildPrayerItem('Dzuhur'),
            _buildPrayerItem('Ashar'),
            _buildPrayerItem('Maghrib'),
            _buildPrayerItem('Isya'),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerItem(String label) {
    return Column(
      children: [
        const Icon(Icons.check_circle, color: Colors.green),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildAyatList() {
    List<Map<String, String>> ayatList = [
      {'surah': 'Al-Ikhlas', 'ayat': 'قُلْ هُوَ ٱللَّهُ أَحَدٌ'},
      {'surah': 'Al-Falaq', 'ayat': 'قُلْ أَعُوذُ بِرَبِّ ٱلۡفَلَقِ'},
      {'surah': 'An-Nas', 'ayat': 'قُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ'},
    ];

    return Column(
      children: ayatList.map((ayat) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: const Icon(Icons.book),
            title: Text(ayat['surah']!),
            subtitle: Text(ayat['ayat']!),
          ),
        );
      }).toList(),
    );
  }
}
