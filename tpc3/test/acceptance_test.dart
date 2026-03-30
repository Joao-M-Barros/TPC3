import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tpc3/main.dart';

void main() {
  group('Acceptance Tests: Digital Prescription Creation (User Story 1)', () {
    testWidgets('Verify successful prescription creation and schedule generation', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that there are no prescriptions initially.
      expect(find.byType(ListTile), findsNothing);

      // 1. Fill in the required fields
      await tester.enterText(find.byKey(const Key('medication_field')), 'Paracetamol');
      await tester.enterText(find.byKey(const Key('dosage_field')), '500mg');
      await tester.enterText(find.byKey(const Key('schedule_field')), 'Every 8 hours');

      // 2. Submit the form
      await tester.tap(find.byKey(const Key('save_button')));
      await tester.pumpAndSettle(); // Wait for animations (SnackBar and list update) to complete

      // 3. Verify that the prescription is saved (SnackBar is shown)
      expect(find.text('Prescription saved to patient profile'), findsOneWidget);

      // 4. Verify that saving automatically generates the corresponding schedule in the patient's view
      // Checking the mock list view items
      expect(find.byKey(const Key('prescription_item_0')), findsOneWidget);
      expect(find.text('Paracetamol - 500mg'), findsOneWidget);
      expect(find.text('Schedule: Every 8 hours'), findsOneWidget);
    });

    testWidgets('Verify form validation blocks submission when fields are empty', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Attempt to save without filling fields
      await tester.tap(find.byKey(const Key('save_button')));
      await tester.pumpAndSettle();

      // Verify validation errors are shown
      expect(find.text('Required'), findsNWidgets(3));
      
      // Verify nothing was saved
      expect(find.byType(ListTile), findsNothing);
      expect(find.text('Prescription saved to patient profile'), findsNothing);
    });
  });
}
