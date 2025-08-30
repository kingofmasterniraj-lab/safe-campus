import 'package:flutter/material.dart';

class QuizOption extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const QuizOption({super.key, required this.text, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: selected ? Colors.blue : Colors.grey.shade300),
        ),
        child: Text(text),
      ),
    );
  }
}
