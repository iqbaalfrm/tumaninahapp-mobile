import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart'; // Import file RegisterScreen

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              Image.asset('assets/logo/Logo1.png',
                  width: 150, height: 150), // Logo PNG
              const SizedBox(height: 30),
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

              // Tombol "Masuk"
              ElevatedButton(
              onPressed: () {
                // Navigasi ke HomeScreen saat tombol 'Masuk' ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text(
                'Masuk',
                style: TextStyle(
                  fontSize: 18, // Ukuran teks yang lebih besar agar lebih jelas
                  fontWeight: FontWeight.bold, // Teks tebal agar menonjol
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 69, 176, 233),
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: const Color.fromARGB(255, 105, 226, 240).withOpacity(0.5),
                elevation: 8,
              ),
            ),

              const SizedBox(height: 20),
              const Text('Atau masuk dengan'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset('assets/logo/google.png',
                        width: 40, height: 40),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Image.asset('assets/logo/fb.png',
                        width: 30, height: 30),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Arahkan ke halaman register
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text(
                  'Belum memiliki akun? Daftar',
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
