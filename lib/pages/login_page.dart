import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import '../services/database_helper.dart'; // Import DatabaseHelper

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //hide pw
  bool _hide = true;

  void _hidepw() {
    setState(() {
      _hide = !_hide;
    });
  }

  //confoig database
  final DatabaseHelper _databaseHelper =
      DatabaseHelper(); // Inisialisasi DatabaseHelper
  final TextEditingController _usernameController =
      TextEditingController(); // Controller untuk username
  final TextEditingController _passwordController =
      TextEditingController(); // Controller untuk password

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
        const SnackBar(
            content: Text('Username dan Password tidak boleh kosong')),
      );
      return;
    }

    print(
        "Attempting to log in with Username: $username and Password: $password");

    // Validasi menggunakan database
    bool isValidUser = await _databaseHelper.validateUser(username, password);

    if (isValidUser) {
      // Arahkan ke dashboard setelah login berhasil
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
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
      backgroundColor: const Color(0xFF161616), // Sesuaikan background dengan warna hitam
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/image/logo_pussimpur.png', // Sesuaikan dengan path logo Anda
                height: 125, // Atur ukuran logo
              ),
              const SizedBox(height: 25),


              // Teks 'masuk dengan akun'
              const Text(
                'Log In With Your Account',
                style: TextStyle(
                  color: Color(0xFFd9d9d9),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Input Username dengan ikon
              TextField(
                controller:
                    _usernameController, // Set controller untuk username
                style: const TextStyle(color:  Color(0xFFd9d9d9),),
                decoration: InputDecoration(
                  hintText: 'username',
                  hintStyle: const TextStyle(
                      color:  Color(0xFFd9d9d9), fontWeight: FontWeight.w900),
                  prefixIcon: const Icon(Icons.person, color: Color(0xFFd9d9d9)),
                  filled: true,
                  fillColor: Colors.grey[800], // Warna input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Input Password dengan ikon
              // Input Password dengan ikon
              TextField(
                controller:
                    _passwordController, // Set controller untuk password
                obscureText: _hide,
                style: const TextStyle(color:  Color(0xFFd9d9d9)),
                decoration: InputDecoration(
                  hintText: 'password',
                  hintStyle: const TextStyle(
                      color: Color(0xFFd9d9d9), fontWeight: FontWeight.w900),
                  prefixIcon:
                      const Icon(Icons.lock_outline, color:  Color(0xFFd9d9d9)),
                  suffixIcon: IconButton(
                    onPressed: _hidepw,
                    icon: Icon(_hide ? Icons.visibility_off : Icons.visibility),
                    color: const Color(0xFFd9d9d9),
                  ),
                  filled: true,
                  fillColor: Colors.grey[800], // Warna input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tombol Masuk, ukurannya sama dengan TextField
              SizedBox(
                width: double.infinity, // Lebar penuh mengikuti TextField
                child: ElevatedButton(
                  onPressed: _login, // Panggil fungsi login saat tombol ditekan
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 206, 202, 202), // Warna tombol
                    padding: const EdgeInsets.symmetric(
                      vertical: 16, // Atur tinggi tombol
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15), // Sudut tombol sama dengan input
                    ),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 20),
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
