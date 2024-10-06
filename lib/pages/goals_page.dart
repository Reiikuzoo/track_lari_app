import 'package:flutter/material.dart';

class GoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Goals'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tujuan Harian Anda',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildGoalProgress('Langkah', '10000 Langkah', 8000, Colors.blue),
            _buildGoalProgress('Kalori', '500 Kkal', 300, Colors.orange),
            _buildGoalProgress('Waktu', '20 Menit', 15, Colors.yellow),
            _buildGoalProgress('Jarak', '4000 m', 2500, Colors.green),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Kembali ke dashboard
                },
                child: Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalProgress(String label, String goal, int current, Color color) {
    double progress = current / 10000; // Contoh hitungan progress (ubah sesuai logika yang dibutuhkan)
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: $current / $goal',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey,
            color: color,
            minHeight: 10,
          ),
        ],
      ),
    );
  }
}
