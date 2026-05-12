import 'package:flutter_test/flutter_test.dart';
import 'package:squash_clash/app.dart';

void main() {
  testWidgets('App loads and displays', (WidgetTester tester) async {
    await tester.pumpWidget(const SquashClashApp());
    expect(find.text('SQUASH CLASH'), findsOneWidget);
  });
}
