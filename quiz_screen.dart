import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/quiz.dart';
import '../services/local_storage.dart';
import '../widgets/quiz_option.dart';

class QuizScreen extends StatefulWidget {
  final String moduleId;
  const QuizScreen({super.key, required this.moduleId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuizQuestion> questions = [];
  int current = 0;
  int? selected;
  int correct = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final str = await rootBundle.loadString('lib/data/quizzes.json');
    final list = jsonDecode(str) as List;
    final entry = list.firstWhere((e) => e['moduleId'] == widget.moduleId, orElse: () => null);
    if (entry == null) return;
    questions = (entry['questions'] as List).map((q) => QuizQuestion(
      question: q['q'],
      options: (q['options'] as List).map((e) => e.toString()).toList(),
      answerIndex: q['answerIndex'],
    )).toList();
    if (mounted) setState(() {});
  }

  void _submit() async {
    if (selected == null) return;
    if (selected == questions[current].answerIndex) correct++;
    if (current < questions.length - 1) {
      setState(() {
        current++;
        selected = null;
      });
    } else {
      final points = correct * 5;
      await LocalStorage().addPoints(points);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Quiz Completed'),
          content: Text('Score: $correct/${questions.length}\nYou earned $points points.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(appBar: AppBar(title: const Text('Quiz')), body: const Center(child: Text('No quiz available.')));
    }
    final q = questions[current];
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Q${current + 1}. ${q.question}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            ...List.generate(q.options.length, (i) => QuizOption(
              text: q.options[i],
              selected: selected == i,
              onTap: () => setState(() => selected = i),
            )),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: _submit, child: Text(current == questions.length - 1 ? 'Finish' : 'Next')),
            )
          ],
        ),
      ),
    );
  }
}
