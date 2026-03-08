import 'package:flutter_test/flutter_test.dart';
import 'package:pottypal/main.dart';

void main() {
  testWidgets('PottyPal home screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PottyPalApp());
    expect(find.text('PottyPal'), findsOneWidget);
  });
}
