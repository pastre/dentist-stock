import 'dart:async';

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

class InventoryItem {
  final String name, barCode;
  final int amount;

  InventoryItem({
    required this.name,
    required this.barCode,
    required this.amount,
  });
}

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

class InventoryRepository {
  final StreamController<Inventory> _controller;

  const InventoryRepository(this._controller);

  Stream<List<Inventory>> joinedInventories() async* {
    final List<Inventory> currentList = List.empty(growable: true);
    await for (Inventory newInventory in _controller.stream) {
      currentList.add(newInventory);
      yield currentList;
    }
  }

  void join(Inventory inventory) {
    _controller.add(inventory);
  }
}

class Inventory {}
