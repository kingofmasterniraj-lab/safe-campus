import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('dummy test', (WidgetTester tester) async {
    expect(1 + 1, 2);
  });
}
