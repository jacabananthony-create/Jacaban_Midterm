import 'package:flutter_test/flutter_test.dart';

import 'package:campus_wellness_tracker/main.dart';

void main() {
  testWidgets('Home screen shows title and start button', (tester) async {
    await tester.pumpWidget(const CampusWellnessApp());

    expect(find.text('Campus Wellness Tracker'), findsOneWidget);
    expect(find.text('Start Assessment'), findsOneWidget);
  });
}