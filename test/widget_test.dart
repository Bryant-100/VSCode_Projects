// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mortgage_calculator_app/main.dart';

void main() {
  testWidgets('Mortgage calculator computes monthly payment', (WidgetTester tester) async {
    await tester.pumpWidget(const MortgageApp());

    await tester.enterText(find.byKey(const Key('principalField')), '200000');
    await tester.enterText(find.byKey(const Key('rateField')), '3.5');
    await tester.enterText(find.byKey(const Key('termField')), '30');

    await tester.tap(find.byKey(const Key('calculateButton')));
    await tester.pumpAndSettle();

    expect(find.textContaining('Total monthly payment'), findsOneWidget);
    expect(find.textContaining('\$898.09'), findsOneWidget);
  });
}
