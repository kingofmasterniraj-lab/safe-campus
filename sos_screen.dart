import 'package:flutter/material.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SOS & Contacts (Demo)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.local_fire_department),
            title: Text('Fire Brigade'),
            subtitle: Text('101'),
          ),
          ListTile(
            leading: Icon(Icons.local_police),
            title: Text('Police'),
            subtitle: Text('100'),
          ),
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text('Ambulance'),
            subtitle: Text('108'),
          ),
          ListTile(
            leading: Icon(Icons.warning_amber),
            title: Text('NDMA Helpline'),
            subtitle: Text('011-26701728'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text('Tip: Long-press power button on many phones for emergency settings.'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('SOS pressed (demo). Implement dial/SMS in production.')));
        },
        icon: const Icon(Icons.sos),
        label: const Text('SOS'),
      ),
    );
  }
}
