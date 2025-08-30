import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user.dart';
import '../services/local_storage.dart';
import '../services/alert_service.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  String _role = 'Student';
  String _region = 'Punjab / Ludhiana';

  final storage = LocalStorage();
  final alertService = AlertService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SafeCampus - Onboarding')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select your role:'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _role,
                items: const [
                  DropdownMenuItem(value: 'Student', child: Text('Student')),
                  DropdownMenuItem(value: 'Teacher', child: Text('Teacher')),
                  DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                ],
                onChanged: (v) => setState(() => _role = v ?? 'Student'),
              ),
              const SizedBox(height: 16),
              const Text('Region (State / City):'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _region,
                onChanged: (v) => _region = v,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'e.g., Punjab / Ludhiana'),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final user = AppUser(role: _role, region: _region);
                    await storage.saveUser(user.toJson());
                    if (!mounted) return;
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => HomeScreen(alertService: alertService),
                    ));
                  },
                  child: const Text('Continue'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
