import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dentist_stock/main.dart';

class DentistStockTester {
  WidgetTester _tester;

  DentistStockTester._(this._tester);

  factory DentistStockTester.from(WidgetTester tester) {
    return DentistStockTester._(tester);
  }

  FutureOr<DentistStockTester> openApp() async {
    await _tester.pumpWidget(DentistStockApp());
    await _tester.pumpAndSettle();
    return this;
  }

  FutureOr<DentistStockTester> tapJoin() async {
    await _tester.tap(find.byIcon(Icons.add));
    await _tester.pumpAndSettle();
    return this;
  }

  FutureOr<DentistStockTester> findsAlert({required String title}) {
    expect(find.text('Digite o nome do estoque'), findsOneWidget);
    return this;
  }
}

void main() {
  testWidgets('''
  GIVEN app is open
  WHEN taps join button
  THEN join screen must appear
  ''', (WidgetTester t) async {
    DentistStockTester tester = DentistStockTester.from(t);
    await tester.openApp();
    await tester.tapJoin();
    await tester.findsAlert(title: 'Entrar em um estoque');
  });
}
