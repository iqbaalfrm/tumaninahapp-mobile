import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'belajar_sholat_screen.dart';
import 'login_screen.dart';
import 'waktu_sholat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tumaninah', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.black),
          onPressed: () {
            // Aksi logout, misalnya kembali ke LoginScreen
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildImageCard('assets/assetsHome/image1.png'),
                    _buildImageCard('assets/assetsHome/image2.png'),
                    _buildImageCard('assets/assetsHome/image3.png'),
                  ],
                ),
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMenuButton(Icons.book, 'Belajar Sholat', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BelajarSholatScreen(),
                      ),
                    );
                  }),
                  _buildMenuButton(Icons.monitor, 'Pantau Sholat'),
                  _buildMenuButton(Icons.access_time, 'Waktu Sholat', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WaktuSholatScreen(),
                      ),
                    );
                  }),
                  _buildMenuButton(Icons.chat, 'Chatbot', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen()),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text('Dhuhur'),
                  subtitle: Text('25 menit tersisa'),
                  trailing: Text('12:45 PM'),
                ),
              ),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation here
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
      ),
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

  // Checklist for prayers
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

  // List of short Ayat Al-Quran
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
