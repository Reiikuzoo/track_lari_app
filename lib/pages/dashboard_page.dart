import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk tanggal dan waktu real-time
import 'package:geolocator/geolocator.dart'; // Untuk pelacakan lokasi
import 'goals_page.dart'; // Import halaman Goals
import 'mulai_page.dart'; // Import halaman Mulai
import 'package:permission_handler/permission_handler.dart'; // Untuk meminta izin lokasi
import 'package:geocoding/geocoding.dart'; // Untuk reverse geocoding

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _currentDate = DateFormat('EEEE, d MMM y').format(DateTime.now());
  String _currentTime = DateFormat('HH:mm').format(DateTime.now());
  String _location = "Belum dilacak";
  int _currentIndex = 0; // Index untuk BottomNavigationBar

  @override
  void initState() {
    super.initState();
    _updateTime();
    _trackLocation(); // Panggil untuk melacak lokasi saat halaman dimuat
  }

  void _updateTime() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _currentTime = DateFormat('HH:mm').format(DateTime.now());
      });
      _updateTime();
    });
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
        // Navigasi ke halaman Home
        break;
      case 1:
        // Navigasi ke halaman Personel
        break;
      case 2:
        // Navigasi ke halaman Akun
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menghapus AppBar
      backgroundColor: Color(0xFF161616),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF282828),
                    ),
                    onPressed: _onRunPressed,
                    child: Text(
                      'LARI',
                      style: TextStyle(color: Color(0xFFd9d9d9)),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF282828),
                    ),
                    onPressed: _onWalkPressed,
                    child: Text(
                      'JALAN',
                      style: TextStyle(color: Color(0xFFd9d9d9)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF282828),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _currentDate,
                        style: TextStyle(color: Color(0xFFd9d9d9), fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF282828),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _location,
                        style: TextStyle(color: Color(0xFFd9d9d9)),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF282828),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _currentTime,
                        style: TextStyle(color: Color(0xFFd9d9d9), fontSize: 24),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF282828),
                      ),
                      onPressed: _trackLocation,
                      child: Text(
                        'Lacak',
                        style: TextStyle(color: Color(0xFFd9d9d9)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF282828),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GoalsPage()),
                    );
                  },
                  child: Text(
                    'Goals',
                    style: TextStyle(color: Color(0xFFd9d9d9)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildProgressIndicator(Icons.directions_walk, '10000 Langkah', 0.8, Colors.blue),
            _buildProgressIndicator(Icons.local_fire_department, '500 Kkal', 0.6, Colors.orange),
            _buildProgressIndicator(Icons.timer, '20 Menit', 0.5, Colors.yellow),
            _buildProgressIndicator(Icons.map, '4000 m', 0.4, Colors.green),
            SizedBox(height: 20),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Color(0xFFd9d9d9),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MulaiPage()),
                  );
                },
                child: Text(
                  'MULAI',
                  style: TextStyle(color: Color(0xFF161616), fontSize: 20),
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
        SizedBox(width: 10),
        Expanded(
          child: LinearProgressIndicator(
            value: progress,
            color: color,
            backgroundColor: Color(0xFF555555),
          ),
        ),
        SizedBox(width: 10),
        Text(title, style: TextStyle(color: Color(0xFFd9d9d9))),
      ],
    );
  }
}
