import 'package:flutter/material.dart';

class AkunPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun'),
        backgroundColor: Color(0xFF161616), // Warna latar belakang AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi Akun
            Text(
              'Informasi Akun',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFd9d9d9),
              ),
            ),
            SizedBox(height: 20),
            // Nama Pengguna
            _buildAccountInfoRow('Nama', 'Nama Pengguna'),
            SizedBox(height: 10),
            // Email Pengguna
            _buildAccountInfoRow('Email', 'email@example.com'),
            SizedBox(height: 20),
            // Tombol Edit Profil
            ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol edit profil ditekan
                print('Tombol Edit Profil ditekan');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF282828),
              ),
              child: Text('Edit Profil'),
            ),
            SizedBox(height: 20),
            // Tombol Keluar
            ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol keluar ditekan
                print('Tombol Keluar ditekan');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF282828),
              ),
              child: Text('Keluar'),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF161616), // Warna latar belakang halaman
    );
  }

  // Widget untuk menampilkan informasi akun
  Widget _buildAccountInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFd9d9d9),
            fontSize: 18,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Color(0xFFd9d9d9),
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
