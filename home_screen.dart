import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/module.dart';
import '../services/local_storage.dart';
import '../services/alert_service.dart';
import 'module_list_screen.dart';
import 'drill_screen.dart';
import 'admin_dashboard_screen.dart';
import 'sos_screen.dart';

class HomeScreen extends StatefulWidget {
  final AlertService alertService;
  const HomeScreen({super.key, required this.alertService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ModuleItem> modules = [];
  int points = 0;
  int drills = 0;
  int prepScore = 0;
  String region = 'Unknown';

  final storage = LocalStorage();
  Stream<String>? alertStream;
  List<String> alerts = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final userJson = await storage.getUser();
    if (userJson != null) {
      region = userJson['region'] as String;
      widget.alertService.startMockRegionAlerts(region);
      alertStream = widget.alertService.alerts;
      alertStream!.listen((msg) {
        setState(() {
          alerts.insert(0, msg);
          if (alerts.length > 10) alerts.removeLast();
        });
      });
    }
    final modsStr = await rootBundle.loadString('lib/data/modules.json');
    final List list = jsonDecode(modsStr);
    modules = list.map((e) => ModuleItem.fromJson(e)).toList();
    points = await storage.getPoints();
    drills = await storage.getDrillsCount();
    prepScore = await storage.getPrepScore();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.alertService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeCampus Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await storage.reset();
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Local data cleared.')));
              setState(() { points = 0; drills = 0; prepScore = 0; });
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset demo data',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _statCard('Points', points.toString(), Icons.emoji_events)),
                const SizedBox(width: 8),
                Expanded(child: _statCard('Drills', drills.toString(), Icons.engineering)),
                const SizedBox(width: 8),
                Expanded(child: _statCard('Prep Score', prepScore.toString(), Icons.shield)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => ModuleListScreen(modules: modules)));
                    },
                    icon: const Icon(Icons.menu_book),
                    label: const Text('Learning Modules'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DrillScreen()));
                    },
                    icon: const Icon(Icons.security),
                    label: const Text('Virtual Drill'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminDashboardScreen()));
                    },
                    icon: const Icon(Icons.dashboard),
                    label: const Text('Admin Dashboard'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SosScreen()));
                    },
                    icon: const Icon(Icons.sos),
                    label: const Text('SOS & Contacts'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Region: $region'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: alerts.length,
                itemBuilder: (_, i) => ListTile(
                  leading: const Icon(Icons.notifications_active),
                  title: Text(alerts[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelMedium),
                Text(value, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
