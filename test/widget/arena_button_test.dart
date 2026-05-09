import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_project/core/components/arena_button.dart';

void main() {
  group('ArenaButton', () {
    testWidgets('should render text correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ArenaButton(text: 'Submit'),
          ),
        ),
      );

      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('should trigger onPressed when tapped', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ArenaButton(
              text: 'Tap Me',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('should show loading indicator and disable tap when isLoading is true', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ArenaButton(
              text: 'Loading',
              isLoading: true,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      // Verify CircularProgressIndicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Try to tap
      await tester.tap(find.byType(ArenaButton));
      await tester.pump();

      expect(pressed, isFalse);
    });

    testWidgets('should render outline variant correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ArenaButton(
              text: 'Outline',
              variant: ArenaButtonVariant.outline,
            ),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });
}
