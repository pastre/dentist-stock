import 'dart:async';

import 'package:dentist_stock/domain/inventory/inventory_repository.dart';

class InventoryList {
  final InventoryRepository _inventoryRepository;

  const InventoryList({
    required InventoryRepository inventoryRepository,
  }) : _inventoryRepository = inventoryRepository;

  Stream<List<Inventory>> get joinedInventories =>
      _inventoryRepository.joinedInventories();

  void join({required String inventoryName}) {
    final inventory = Inventory(name: inventoryName);
    _inventoryRepository.join(inventory);
  }
}
