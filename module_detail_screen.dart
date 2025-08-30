import 'package:flutter/material.dart';
import '../models/module.dart';
import '../services/local_storage.dart';

class ModuleDetailScreen extends StatelessWidget {
  final ModuleItem module;
  const ModuleDetailScreen({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(module.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(module.summary, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12),
            Expanded(child: SingleChildScrollView(child: Text(module.content))),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await LocalStorage().addPoints(10);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Completed module! +10 points')),
                    );
                  }
                },
                child: const Text('Mark as Completed'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
