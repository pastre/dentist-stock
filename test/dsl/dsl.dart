import 'package:dentist_stock/domain/inventory_list/inventory.dart';
import 'package:dentist_stock/data/local_storage.dart';
import 'package:dentist_stock/widget/dentist_inventory_app.dart';
import 'package:dentist_stock/widget/inventory/inventory_widget.dart';
import 'package:dentist_stock/widget/inventory_list/inventory_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DentistInventoryTester {
  final WidgetTester _tester;
  final LocalStorage _localStorageProtocolDriver = LocalStorage();
  final BarcodeReader _barcodeReaderProtocolDriver = BarcodeReader();

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

  Future<void> verifyInventoryIsOpen(Inventory inventory) async {
    expect(find.byType(InventoryWidget), findsOneWidget);
  }

  Future<void> tapInventory({required String inventoryName}) async {
    await _tester.tap(findInventory(name: inventoryName));
    await _tester.pumpAndSettle();
  }

  Future<void> didScanBarcode(String s) async {
    _barcodeReaderProtocolDriver.didScanBarcode(s);
  }

  Future<void> enterItemName(String s) async {
    await _tester.enterText(find.byType(TextField), s);
  }

  Future<void> tapCreate() async {
    await _tester.tap(find.byIcon(Icons.add));
  }

  Future<void> verifyItemExists({
    required String name,
    required String barcode,
  }) async {
    expect(findInventoryRow(name: name), findsOneWidget);
  }

  Finder findInventoryRow({required String name}) => find.ancestor(
        of: find.text(name),
        matching: find.byType(InventoryItemRowWidget),
      );
}

class BarcodeReader {
  void didScanBarcode(String s) {}
}

class InventoryItemRowWidget {}
