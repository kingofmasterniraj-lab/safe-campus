import 'package:flutter/material.dart';
import '../models/module.dart';
import '../widgets/module_card.dart';
import 'module_detail_screen.dart';
import 'quiz_screen.dart';

class ModuleListScreen extends StatelessWidget {
  final List<ModuleItem> modules;
  const ModuleListScreen({super.key, required this.modules});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Modules')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: modules.length,
        itemBuilder: (_, i) {
          final m = modules[i];
          return ModuleCard(
            module: m,
            onOpen: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ModuleDetailScreen(module: m))),
            onQuiz: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuizScreen(moduleId: m.id))),
          );
        },
      ),
    );
  }
}
