import 'package:flutter/material.dart';
import '../services/local_storage.dart';

class DrillScreen extends StatefulWidget {
  const DrillScreen({super.key});

  @override
  State<DrillScreen> createState() => _DrillScreenState();
}

class _DrillScreenState extends State<DrillScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<double>(begin: 0, end: 10).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _startDrill() async {
    await _controller.forward();
    await _controller.reverse();
    await LocalStorage().incrementDrills();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Drill completed! +5 Prep Score')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Virtual Drill')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Earthquake Drill: Drop, Cover, Hold'),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _animation,
              builder: (_, child) => Transform.rotate(
                angle: _animation.value * 0.05,
                child: child,
              ),
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.school, size: 80),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _startDrill, child: const Text('Start Drill')),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('This demo simulates shaking. Practice: get under sturdy desk, protect head/neck, wait until shaking stops, evacuate calmly.'),
            )
          ],
        ),
      ),
    );
  }
}
