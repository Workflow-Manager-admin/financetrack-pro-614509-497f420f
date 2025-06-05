import 'package:flutter_test/flutter_test.dart';

import 'package:financetrack_pro/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build FinanceTrackProApp and trigger a frame.
    await tester.pumpWidget(const FinanceTrackProApp());

    // Check for app title in the AppBar.
    expect(find.text('FinanceTrack Pro'), findsOneWidget);

    // Check for tab titles.
    expect(find.text('Expenses'), findsOneWidget);
    expect(find.text('Income'), findsOneWidget);
    expect(find.text('Reports'), findsOneWidget);
  });
}
