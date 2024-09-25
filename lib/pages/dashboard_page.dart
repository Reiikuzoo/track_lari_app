import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat datang di aplikasi track lari!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aksi untuk memulai lari
                // Navigator.push(context, MaterialPageRoute(builder: (context) => RunPage()));
              },
              child: Text('Mulai Lari'),
            ),
            SizedBox(height: 20),
            Text(
              'Statistik Terakhir:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            // Tambahkan widget untuk menampilkan statistik lari
            // Misalnya, ListView atau Card untuk menampilkan data statistik
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        currentIndex: 0, // Indeks item yang sedang dipilih
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Navigasi berdasarkan indeks yang dipilih
          // Misalnya, Navigator.push untuk halaman lain
        },
      ),
    );
  }
}
