import 'dart:async';

import 'package:dentist_stock/inventory_repository.dart';

class InventoryList {
  final InventoryRepository _inventoryRepository;

  InventoryList({
    required InventoryRepository inventoryRepository,
  }) : _inventoryRepository = inventoryRepository;

  Stream<List<Inventory>> get joinedInventories =>
      _inventoryRepository.joinedInventories();
  void join(Inventory inventory) {
    _inventoryRepository.join(inventory);
  }
}
