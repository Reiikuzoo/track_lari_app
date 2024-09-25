import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import '../services/database_helper.dart'; // Import DatabaseHelper

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper(); // Inisialisasi DatabaseHelper
  final TextEditingController _usernameController = TextEditingController(); // Controller untuk username
  final TextEditingController _passwordController = TextEditingController(); // Controller untuk password

  @override
  void dispose() {
    _usernameController.dispose(); // Bersihkan controller saat tidak digunakan
    _passwordController.dispose(); // Bersihkan controller saat tidak digunakan
    super.dispose();
  }

  void _login() async {
    String username = _usernameController.text.trim(); // Ambil username
    String password = _passwordController.text.trim(); // Ambil password

    // Cek jika username atau password kosong
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan Password tidak boleh kosong')),
      );
      return;
    }

    print("Attempting to log in with Username: $username and Password: $password");

    // Validasi menggunakan database
    bool isValidUser = await _databaseHelper.validateUser(username, password);
    
    if (isValidUser) {
      // Arahkan ke dashboard setelah login berhasil
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username atau password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Sesuaikan background dengan warna hitam
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/image/logo-pussimpur.png', // Sesuaikan dengan path logo Anda
                height: 150, // Atur ukuran logo
              ),
              const SizedBox(height: 40),

              // Teks 'masuk dengan akun'
              const Text(
                'masuk dengan akun',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),

              // Input Username dengan ikon
              TextField(
                controller: _usernameController, // Set controller untuk username
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'nama pengguna',
                  hintStyle: const TextStyle(color: Colors.white60),
                  prefixIcon: const Icon(Icons.person, color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[800], // Warna input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Input Password dengan ikon
              TextField(
                controller: _passwordController, // Set controller untuk password
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'kata sandi',
                  hintStyle: const TextStyle(color: Colors.white60),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[800], // Warna input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Tombol Masuk, ukurannya sama dengan TextField
              SizedBox(
                width: double.infinity, // Lebar penuh mengikuti TextField
                child: ElevatedButton(
                  onPressed: _login, // Panggil fungsi login saat tombol ditekan
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Warna tombol
                    padding: const EdgeInsets.symmetric(
                      vertical: 16, // Atur tinggi tombol
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Sudut tombol sama dengan input
                    ),
                  ),
                  child: const Text(
                    'MASUK',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
