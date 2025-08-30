import 'package:flutter/material.dart';
import '../services/local_storage.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int points = 0;
  int drills = 0;
  int prepScore = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final storage = LocalStorage();
    points = await storage.getPoints();
    drills = await storage.getDrillsCount();
    prepScore = await storage.getPrepScore();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard (Demo)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _tile('Total Points (all users in this demo device)', points.toString()),
            _tile('Drills Completed (device)', drills.toString()),
            _tile('Preparedness Score (device)', prepScore.toString()),
            const SizedBox(height: 16),
            const Text('Note: In production, these metrics aggregate per school/grade using a backend.'),
          ],
        ),
      ),
    );
  }

  Widget _tile(String title, String value) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(value, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
