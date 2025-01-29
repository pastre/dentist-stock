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

  Future<void> openApp() async {
    await _tester.pumpWidget(DentistInventoryApp());
    await _tester.pumpAndSettle();
  }

  Future<void> tapJoin() async {
    await _tester.tap(find.byIcon(Icons.add));
    await _tester.pumpAndSettle();
  }

  Future<void> findsAlert({required String title}) async {
    expect(find.text('Digite o nome do estoque'), findsOneWidget);
  }

  Future<void> findsDisabledJoinButton() async {
    expect(_tester.widget<TextButton>(_joinInventoryButton).enabled, false);
  }

  Future<void> joinInventory({required String inventoryName}) async {
    Finder inventoryNameTextField = find.byType(TextField);
    await tapJoin();
    await _tester.enterText(inventoryNameTextField, inventoryName);
    await _tester.pumpAndSettle();
    await _tester.tap(_joinInventoryButton);
    await _tester.pumpAndSettle();
  }

  Future<void> verifyJoinInventoryClosed() async {
    await _tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  }
}

class InventoryRow extends StatelessWidget {
  final String inventoryName;

  const InventoryRow({super.key, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    return Text(inventoryName);
  }
}

void main() {
  testWidgets('''
  GIVEN app is open
  WHEN taps join button
  THEN join inventory alert must appear
  BUT join button is disabled
  ''', (WidgetTester t) async {
    DentistInventoryTester tester = DentistInventoryTester.from(t);
    await tester.openApp();
    await tester.tapJoin();
    await tester.findsAlert(title: 'Entrar em um estoque');
    await tester.findsDisabledJoinButton();
  });

  testWidgets('''
  GIVEN join inventory alert is open
  AND an inventory name is typed
  AND the inventory exists
  WHEN taps join button
  THEN join inventory alert must disappear
  ''', (WidgetTester t) async {
    DentistInventoryTester tester = DentistInventoryTester.from(t);
    await tester.openApp();
    await tester.joinInventory(inventoryName: 'Stub inventory');
    await tester.verifyJoinInventoryClosed();
  });
}
