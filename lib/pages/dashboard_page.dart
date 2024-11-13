import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart'; // Untuk tanggal dan waktu real-time
import 'package:geolocator/geolocator.dart'; // Untuk pelacakan lokasi
import 'akun_page.dart';
import 'goals_page.dart'; // Import halaman Goals
import 'mulai_page.dart'; // Import halaman Mulai
import 'package:permission_handler/permission_handler.dart'; // Untuk meminta izin lokasi
import 'package:geocoding/geocoding.dart';
import 'personel_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _currentDate = '';
  String _currentTime = '';
  String _location = "Belum dilacak";
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null).then((_) {
      setState(() {
        _currentDate = DateFormat('EEEE, d MMM y', 'id_ID').format(DateTime.now());
        _currentTime = DateFormat('HH:mm', 'id_ID').format(DateTime.now());
      });
      _updateTime();
    });
    _trackLocation();
  }

  void _updateTime() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _currentTime = DateFormat('HH:mm', 'id_ID').format(DateTime.now());
      });
    }
  }

  
  Future<void> _trackLocation() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      // Meminta izin
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Lakukan reverse geocoding untuk mendapatkan nama lokasi
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        Placemark place = placemarks[0];

        setState(() {
          // Tampilkan nama lokasi, misalnya kota, provinsi
          _location = "${place.thoroughfare}";
        });
      } catch (e) {
        print("Error saat mendapatkan lokasi: $e");
      }
    } else if (status.isPermanentlyDenied) {
      print("Izin lokasi ditolak. Silakan berikan izin untuk menggunakan fitur ini.");
      openAppSettings();
    }
  }

  void _onRunPressed() {
    print("Tombol LARI ditekan");
  }

  void _onWalkPressed() {
    print("Tombol JALAN ditekan");
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Implementasikan navigasi ke halaman yang sesuai
    switch (index) {
      case 0:
        // kosong
        break;
      case 1:
        // Navigasi ke halaman Personel
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PersonelPage()),
      );
        break;
      case 2:
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AkunPage()),
      );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menghapus AppBar
      backgroundColor: const Color(0xFF161616),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF282828),
                    ),
                    onPressed: _onRunPressed,
                    child: const Text(
                      'LARI',
                      style: TextStyle(color: Color(0xFFd9d9d9)),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF282828),
                    ),
                    onPressed: _onWalkPressed,
                    child: const Text(
                      'JALAN',
                      style: TextStyle(color: Color(0xFFd9d9d9)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF282828),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _currentDate,
                        style: const TextStyle(color: Color(0xFFd9d9d9), fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF282828),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _location,
                        style: const TextStyle(color: Color(0xFFd9d9d9)),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF282828),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _currentTime,
                        style: const TextStyle(color: Color(0xFFd9d9d9), fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF282828),
                      ),
                      onPressed: _trackLocation,
                      child: const Text(
                        'Lacak',
                        style: TextStyle(color: Color(0xFFd9d9d9)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF282828),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GoalsPage()),
                    );
                    
                  },
                  child: const Text(
                    'Pencapaian >',
                    style: TextStyle(color: Color(0xFFd9d9d9)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildProgressIndicator(Icons.map, '4000 Meter', 0.4, Colors.green),
            const SizedBox(height: 20),
            _buildProgressIndicator(Icons.directions_walk, '8000 Langkah', 0.8, Colors.blue),
            const SizedBox(height: 20),
            _buildProgressIndicator(Icons.local_fire_department, '500 Kkal', 0.5, Colors.orange),
            const SizedBox(height: 20),
            _buildProgressIndicator(Icons.timer, '20 Menit', 0.2, Colors.yellow),
            const SizedBox(height: 20),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFFd9d9d9),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MulaiPage()),
                  );
                },
                child: const Text(
                  'MULAI',
                  style: TextStyle(color: Color(0xFF161616), fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Personel'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
        currentIndex: _currentIndex, // Gunakan _currentIndex untuk mengatur item yang dipilih
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavTapped, // Panggil fungsi saat item ditekan
      ),
    );
  }

  Widget _buildProgressIndicator(IconData icon, String title, double progress, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: LinearProgressIndicator(
            value: progress,
            color: color,
            backgroundColor: const Color(0xFF555555),
          ),
        ),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(color: Color(0xFFd9d9d9))),
      ],
    );
  }
}
