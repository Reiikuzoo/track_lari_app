import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class MulaiPage extends StatefulWidget {
  @override
  _MulaiPageState createState() => _MulaiPageState();
}

class _MulaiPageState extends State<MulaiPage> {
  late Timer _timer;
  int _seconds = 0;
  String _formattedTime = "00:00:00";

  int _steps = 0;
  int _calories = 0;
  double _distance = 0.0;
  int _rank = 0;
  late StreamSubscription<StepCount> _stepCountSubscription;
  int _initialStepCount = 0;

  bool _isTracking = false;

  void _startStepCountStream() {
    _stepCountSubscription = Pedometer.stepCountStream.listen(
      _onStepCount,
      onError: (error) {
        print('Error: $error');
      },
    );
  }

  void _onStepCount(StepCount stepCount) {
    // If it's the first step count, store it as the initial step count
    if (_initialStepCount == 0) {
      _initialStepCount = stepCount.steps;
    }
    
    // Calculate steps taken since tracking started
    int stepsDuringSession = stepCount.steps - _initialStepCount;

    // Only update if steps during the session are greater than 0
    if (stepsDuringSession >= 0) {
      setState(() {
        _steps = stepsDuringSession;
        _calories = (_steps * 0.04).toInt(); // 0.04 calories per step
        _distance = _steps * 0.0008; // Assume 0.8 meters per step
      });
    }
  }

  void _startTracking() {
    if (_isTracking) return;

    setState(() {
      _isTracking = true;
    });

    _initialStepCount = 0; // Reset initial step count when starting
    _startStepCountStream();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        _formattedTime = _formatDuration(_seconds);
      });
    });
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
    });
    _timer.cancel();
    _stepCountSubscription.cancel();
  }

  String _formatDuration(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    return "${hours.toString().padLeft(2, '0')}:"
        "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer.cancel();
    _stepCountSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF161616),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Mulai Olahraga',
                    style: TextStyle(
                      color: Color(0xFFd9d9d9),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 48),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      _formattedTime,
                      style: TextStyle(
                        color: Color(0xFFd9d9d9),
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Durasi',
                      style: TextStyle(
                        color: Color(0xFFd9d9d9),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _buildMetricCard(Icons.directions_walk, 'Langkah', '$_steps', Colors.blue),
                        ),
                        Expanded(
                          child: _buildMetricCard(Icons.local_fire_department, 'Kalori', '$_calories', Colors.orange),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _buildMetricCard(Icons.map, 'Jarak', '${_distance.toStringAsFixed(2)} km', Colors.green),
                        ),
                        Expanded(
                          child: _buildMetricCard(Icons.emoji_events, 'Peringkat', '$_rank', Colors.yellow),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
                  onPressed: _isTracking ? _stopTracking : _startTracking,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isTracking ? Icons.pause : Icons.directions_run,
                        color: Color(0xFF161616),
                      ),
                      SizedBox(width: 8),
                      Text(
                        _isTracking ? 'STOP' : 'MULAI',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF161616),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Personel'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Aksi untuk navigasi
        },
      ),
    );
  }

  Widget _buildMetricCard(IconData icon, String label, String value, Color color) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
            Text(value, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
