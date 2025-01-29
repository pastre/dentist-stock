import 'package:dentist_stock/domain/inventory/inventory.dart';
import 'package:dentist_stock/data/local_storage.dart';
import 'package:dentist_stock/widget/dentist_inventory_app.dart';
import 'package:dentist_stock/widget/inventory/inventory_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DentistInventoryTester {
  final WidgetTester _tester;
  final LocalStorage _localStorageProtocolDriver = LocalStorage();

  DentistInventoryTester._(this._tester);

  factory DentistInventoryTester.from(WidgetTester tester) {
    return DentistInventoryTester._(tester);
  }

  Finder get _joinInventoryButton => find.ancestor(
        of: find.text('Entrar'),
        matching: find.byType(TextButton),
      );

  Finder findInventory({required String name}) => find.ancestor(
        of: find.text(name),
        matching: find.byType(InventoryRow),
      );

  Future<void> openApp() async {
    await _tester.pumpWidget(DentistInventoryApp.fromDependencies(
      localStorage: _localStorageProtocolDriver,
    ));
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

  Future<void> verifyJoinedInventory({required String inventoryName}) async {
    await _tester.pumpAndSettle();
    expect(findInventory(name: inventoryName), findsOneWidget);
  }

  Future<void> verifyJoinInventoryClosed() async {
    await _tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  }

  void addJoinedInventory(Inventory inventory) {
    _localStorageProtocolDriver.addInventory(inventory);
  }
}
