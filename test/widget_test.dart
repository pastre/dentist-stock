import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dentist_stock/main.dart';

class DentistInventoryTester {
  WidgetTester _tester;

  DentistInventoryTester._(this._tester);

  factory DentistInventoryTester.from(WidgetTester tester) {
    return DentistInventoryTester._(tester);
  }

  Finder get _joinInventoryButton => find.ancestor(
        of: find.text('Entrar'),
        matching: find.byType(TextButton),
      );

  FutureOr<DentistInventoryTester> openApp() async {
    await _tester.pumpWidget(DentistInventoryApp());
    await _tester.pumpAndSettle();
    return this;
  }

  FutureOr<DentistInventoryTester> tapJoin() async {
    await _tester.tap(find.byIcon(Icons.add));
    await _tester.pumpAndSettle();
    return this;
  }

  FutureOr<DentistInventoryTester> findsAlert({required String title}) {
    expect(find.text('Digite o nome do estoque'), findsOneWidget);
    return this;
  }

  FutureOr<DentistInventoryTester> findsDisabledJoinButton() {
    expect(_tester.widget<TextButton>(_joinInventoryButton).enabled, false);
    return this;
  }
}

void main() {
  testWidgets('''
  GIVEN app is open
  WHEN taps join button
  THEN join screen must appear
  BUT join button is disabled
  ''', (WidgetTester t) async {
    DentistInventoryTester tester = DentistInventoryTester.from(t);
    await tester.openApp();
    await tester.tapJoin();
    await tester.findsAlert(title: 'Entrar em um estoque');
    await tester.findsDisabledJoinButton();
  });
}
