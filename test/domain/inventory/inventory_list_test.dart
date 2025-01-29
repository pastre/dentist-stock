import 'dart:async';

import 'package:dentist_stock/domain/inventory/inventory_list.dart';
import 'package:dentist_stock/domain/inventory/inventory_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('emits new value when joins inventory', () {
    final StreamController<Inventory> controller = StreamController(sync: true);
    InventoryList list = InventoryList(
      inventoryRepository: InventoryRepository(controller),
    );
    expect(
      list.joinedInventories.map((list) => list.first.name),
      emits('expected_inventory_name'),
    );
    list.join(inventoryName: 'expected_inventory_name');
  }, timeout: Timeout(Duration(seconds: 1)));
}
