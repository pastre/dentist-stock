import 'package:dentist_stock/domain/inventory_list/inventory.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dsl/dsl.dart';

void main() {
  testWidgets('''
  GIVEN an inventory is opened
  AND inventory is empty
  WHEN barcode is scanned
  AND an item name is typed
  AND add button is tapped
  THEN it should add item to list
  ''', (WidgetTester widgetTester) async {
    DentistInventoryTester tester = DentistInventoryTester.from(widgetTester);
    tester.addJoinedInventory(Inventory(name: 'Inventory Stub'));
    await tester.openApp();
    await tester.tapInventory(inventoryName: 'Inventory Stub');
    await tester.didScanBarcode('01');
    await tester.enterItemName('Item Stub');
    await tester.tapCreate();
    await tester.verifyItemExists(name: 'Item Stub', barcode: '01');
  });
}
