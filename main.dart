import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const SafeCampusApp());
}

class SafeCampusApp extends StatelessWidget {
  const SafeCampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeCampus',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}
