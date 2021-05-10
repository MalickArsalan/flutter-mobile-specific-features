// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:globoscript/main.dart';

void main() {
  testWidgets('Default tab is glyph list', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(GlobomanticsTabHome());

    // Verify that our counter starts at 0.
    expect(find.text('あ'), findsOneWidget);
    expect(find.text('い'), findsOneWidget);
    expect(find.text('う'), findsOneWidget);
    expect(find.text('え'), findsOneWidget);
    expect(find.text('お'), findsOneWidget);
  });

/*
  testWidgets('Click on lesson tab', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(GlobomanticsTabHome());

    var v = find.byType(Tab).at(1);
    await tester.tap(v);
    await tester.pump();

    expect(find.text('L1'), findsOneWidget);
    expect(find.text('L2'), findsOneWidget);
    expect(find.text('L3'), findsOneWidget);
    expect(find.text('L4'), findsOneWidget);
  });
*/
}
