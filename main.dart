import 'package:flutter/material.dart';

void main() {
  runApp(const SafeCampusApp());
}

class SafeCampusApp extends StatelessWidget {
  const SafeCampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Campus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safe Campus Demo'),
      ),
      body: const Center(
        child: Text(
          'Hello, Safe Campus!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
