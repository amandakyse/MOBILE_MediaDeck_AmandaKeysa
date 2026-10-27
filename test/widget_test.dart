import 'package:flutter_test/flutter_test.dart';
import 'package:mediadeck/main.dart';

void main() {
  testWidgets('MediaDeck app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MediaDeckApp());

    expect(find.textContaining('MediaDeck'), findsWidgets);
  });
}
