import 'dart:async';

import 'package:dentist_stock/inventory_list.dart';
import 'package:dentist_stock/inventory_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('emits new value when joins inventory', () {
    final StreamController<Inventory> controller = StreamController(sync: true);
    final expectedInventory = Inventory();
    InventoryList list = InventoryList(
      inventoryRepository: InventoryRepository(controller),
    );
    expect(
      list.joinedInventories.map((list) => list.first),
      emits(expectedInventory),
    );
    list.join(expectedInventory);
  }, timeout: Timeout(Duration(seconds: 1)));
}
