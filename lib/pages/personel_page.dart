import 'package:flutter/material.dart';

class PersonelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Personel'),
      ),
      body: Center(
        child: Text(
          'Ini adalah halaman Personel',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
