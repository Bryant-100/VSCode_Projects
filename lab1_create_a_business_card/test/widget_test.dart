// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab1_create_business_card/main.dart';

void main() {
  testWidgets('Business card UI renders key content', (WidgetTester tester) async {
    await tester.pumpWidget(const BusinessCardApp());

    expect(find.text('Bryant Nguyen'), findsOneWidget);
    expect(find.text('Computer Science College Student'), findsOneWidget);
    expect(find.text('bryant.nguyen@example.com'), findsOneWidget);
  });
}
