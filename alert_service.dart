import 'dart:async';

class AlertService {
  final _controller = StreamController<String>.broadcast();
  Stream<String> get alerts => _controller.stream;

  Timer? _timer;

  void startMockRegionAlerts(String region) {
    _timer?.cancel();
    // Emit a demo alert every 30 seconds to simulate region-specific updates
    _timer = Timer.periodic(const Duration(seconds: 30), (t) {
      final now = DateTime.now().toLocal().toIso8601String();
      _controller.add('Demo Alert for $region at $now: Practice evacuation route to the nearest safe assembly point.');
    });
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}
