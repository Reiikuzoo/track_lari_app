import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk tanggal dan waktu real-time
import 'package:geolocator/geolocator.dart'; // Untuk pelacakan lokasi

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _currentDate = DateFormat('EEEE, d MMM y').format(DateTime.now());
  String _currentTime = DateFormat('HH:mm').format(DateTime.now());
  String _location = "Belum dilacak";

  @override
  void initState() {
    super.initState();
    _updateTime();
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
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _location = "${position.latitude}, ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: null, child: Text('LARI')),
                ElevatedButton(onPressed: null, child: Text('JALAN')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_currentDate, style: TextStyle(color: Colors.white, fontSize: 18)),
                    Text("Lokasi: $_location", style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Text(_currentTime, style: TextStyle(color: Colors.white, fontSize: 24)),
                    ElevatedButton(onPressed: _trackLocation, child: Text('Lacak')),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () { /* Arahkan ke halaman goals */ }, child: Text('Goals')),
            SizedBox(height: 20),
            // Tambahkan widget bar progress untuk langkah, kalori, waktu, dan jarak
            _buildProgressIndicator(Icons.directions_walk, '10000 Langkah', 0.8, Colors.blue),
            _buildProgressIndicator(Icons.local_fire_department, '500 Kkal', 0.6, Colors.orange),
            _buildProgressIndicator(Icons.timer, '20 Menit', 0.5, Colors.yellow),
            _buildProgressIndicator(Icons.map, '4000 m', 0.4, Colors.green),
            SizedBox(height: 20),
            ElevatedButton(onPressed: null, child: Text('MULAI')),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Data'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profile'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {},
      ),
    );
  }

  Widget _buildProgressIndicator(IconData icon, String label, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: progress,
              color: color,
              backgroundColor: Colors.grey,
            ),
          ),
          SizedBox(width: 10),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
