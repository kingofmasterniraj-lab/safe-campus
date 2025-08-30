import 'package:flutter_test/flutter_test.dart';
import 'package:safe_campus/main.dart';

void main() {
  testWidgets('SafeCampusApp has title', (WidgetTester tester) async {
    await tester.pumpWidget(const SafeCampusApp());
    expect(find.text('Hello, Safe Campus!'), findsOneWidget);
  });
}
