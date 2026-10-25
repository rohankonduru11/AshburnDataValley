// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:datacenterapp/main.dart';

void main() {
  testWidgets('Data centers opens the Ashburn details page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AshburnImpactApp());

    final dataCenters = find.text('DATA CENTERS');
    await tester.tap(dataCenters);
    await tester.pumpAndSettle();

    expect(find.text('Exploring Ashburn'), findsNWidgets(2));
    final displayAll = find.text('DISPLAY ALL DATA CENTERS');
    expect(displayAll, findsOneWidget);
    await tester.tap(displayAll);
    await tester.pumpAndSettle();

    expect(find.text('ALL DATA CENTERS'), findsOneWidget);
    expect(find.text('108 data centers from the CSV'), findsOneWidget);
    expect(find.text('VIEW ALL 176 PUBLIC LISTINGS'), findsOneWidget);
    expect(find.text('LC1 - CloudHQ Data Center'), findsOneWidget);
  });

  testWidgets('Ashburn Data Valley home screen loads', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AshburnImpactApp());

    expect(find.text('ASHBURN DATA VALLEY'), findsOneWidget);
    expect(find.text('CIVIC • DATA • STEM'), findsNothing);

    expect(find.text('DATA CENTERS'), findsOneWidget);
    expect(find.text('HOW IT WORKS'), findsOneWidget);
    expect(find.text('ENERGY'), findsOneWidget);
    expect(find.text('COMMUNITY'), findsOneWidget);
  });

  testWidgets('the info dialog explains the app purpose', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AshburnImpactApp());

    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('My name is Rohan, and I live right here in Ashburn'),
      findsOneWidget,
    );
  });

  testWidgets('community impact page includes community benefit contributors', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AshburnImpactApp());

    await tester.tap(find.text('COMMUNITY'));
    await tester.pumpAndSettle();

    expect(find.text('Community benefit contributors'), findsOneWidget);
    expect(find.textContaining('parks'), findsWidgets);
    expect(find.textContaining('seniors'), findsWidgets);
    expect(find.textContaining('tax revenues'), findsWidgets);
    expect(find.textContaining('lsars.com'), findsWidgets);
  });
}
