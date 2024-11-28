import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Contoh Gambar Asset")),
        body: Center(
          child: Image.asset(
            'assets/images/Enemy.png', // Path relatif ke gambar dalam folder assets
            width: 150,
            height: 150,
            fit: BoxFit.cover, // Menyesuaikan gambar dengan area widget
          ),
        ),
      ),
    );
  }
}
