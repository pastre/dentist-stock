import 'package:dentist_stock/domain/inventory_list/inventory.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dsl/dsl.dart';

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
  AND the inventory should be displayed
  ''', (WidgetTester t) async {
    DentistInventoryTester tester = DentistInventoryTester.from(t);
    await tester.openApp();
    await tester.joinInventory(inventoryName: 'Stub inventory');
    await tester.verifyJoinInventoryClosed();
    await tester.verifyJoinedInventory(inventoryName: 'Stub inventory');
  });

  testWidgets('''
  GIVEN inventory is joined
  AND app is closed
  WHEN inventory list is opened
  THEN it should display joined inventory
  ''', (WidgetTester t) async {
    DentistInventoryTester tester = DentistInventoryTester.from(t);
    final inventory = Inventory(name: 'Stub inventory');
    tester.addJoinedInventory(inventory);
    await tester.openApp();
    await tester.verifyJoinedInventory(inventoryName: inventory.name);
  });

  testWidgets('''
  GIVEN inventory is joined
  AND inventory name is 'Existing Inventory'
  AND join inventory alert is open
  AND alert text is 'Existing Inventory'
  WHEN join inventory text is tapped
  THEN it should route to 'Existing Inventory'
  ''', (WidgetTester t) async {
    DentistInventoryTester tester = DentistInventoryTester.from(t);
    final inventory = Inventory(name: 'Existing Inventory');
    tester.addJoinedInventory(inventory);
    await tester.openApp();
    await tester.joinInventory(inventoryName: inventory.name);
    await tester.verifyInventoryIsOpen(inventory);
  });

  testWidgets('''
  GIVEN inventory is joined
  WHEN inventory is tapped
  THEN it should route to inventory
  ''', (WidgetTester t) async {
    DentistInventoryTester tester = DentistInventoryTester.from(t);
    final inventory = Inventory(name: 'Existing Inventory');
    tester.addJoinedInventory(inventory);
    await tester.openApp();
    await tester.tapInventory(inventoryName: inventory.name);
    await tester.verifyInventoryIsOpen(inventory);
  });
}
