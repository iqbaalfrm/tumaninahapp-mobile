import 'package:flutter/material.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset('assets/logo/Logo1.png', width: 150, height: 150), // Logo
              const SizedBox(height: 30),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nama lengkap',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Kata sandi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                // Navigasi ke HomeScreen saat tombol 'Masuk' ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
                child: const Text(
                  'Daftar',
                  style: TextStyle(
                    fontSize:
                        18, // Ukuran teks yang lebih besar agar lebih jelas
                    fontWeight: FontWeight.bold, // Teks tebal agar menonjol
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 28, 222, 170), padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 8), // Padding lebih lebar dan tinggi
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30), // Radius lebih besar untuk efek tombol bulat
                  ), // Warna teks tombol
                  shadowColor: const Color.fromARGB(255, 105, 226, 240)
                      .withOpacity(0.5), // Warna bayangan tombol
                  elevation: 8, // Efek bayangan 3D
                ),
              ),

              const SizedBox(height: 20),
              const SizedBox(height: 20),
              const Text('Atau daftar dengan'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                     icon: Image.asset('assets/logo/google.png', width: 40, height: 40),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                     icon: Image.asset('assets/logo/fb.png', width: 30, height: 30),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Kembali ke login
                },
                child: const Text(
                  'Sudah punya akun? Masuk',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
