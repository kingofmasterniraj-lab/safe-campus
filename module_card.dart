import 'package:flutter/material.dart';
import '../models/module.dart';

class ModuleCard extends StatelessWidget {
  final ModuleItem module;
  final VoidCallback onOpen;
  final VoidCallback onQuiz;

  const ModuleCard({super.key, required this.module, required this.onOpen, required this.onQuiz});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(module.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(module.summary),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('~${module.estimatedMinutes} min'),
                Row(
                  children: [
                    TextButton(onPressed: onOpen, child: const Text('Open')),
                    const SizedBox(width: 8),
                    ElevatedButton(onPressed: onQuiz, child: const Text('Quiz')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
