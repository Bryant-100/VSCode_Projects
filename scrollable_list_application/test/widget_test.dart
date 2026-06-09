// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:scrollable_list_application/main.dart';

void main() {
  testWidgets('Affirmation card displays message and image', (WidgetTester tester) async {
    // Create a sample affirmation
    final List<Affirmation> affirmations = [
      const Affirmation(
      message: 'You are amazing!',
      imageNetwork: 'https://i.pinimg.com/474x/9e/1b/56/9e1b567a5445db392298cd5affa4239e.jpg',
    ),
    const Affirmation(
      message: 'Consistency is my strength. I show up for my goals even when the initial excitement fades.',
      imageNetwork: 'https://images.squarespace-cdn.com/content/v1/5a5986b2cf81e095e172ce87/1581895479166-2OPMV4MIKFTM7OXTUFOG/flyingdawnmarie-red-rock-canyon-state-park-01-banner.jpg',
    ),
    const Affirmation(
      message: 'Only good things await me.',
      imageNetwork: 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=1200&q=80.jpg',
    ),
  ];

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: buildAffirmationCard(affirmations[0], tester.element(find.byType(Card))),
        ),
      ),
    );

    // Verify that the message is displayed
    expect(find.text(affirmations[0].message), findsOneWidget);

    // Verify that the image is displayed
    expect(find.byType(Image), findsOneWidget);
  });
}