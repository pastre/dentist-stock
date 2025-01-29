import 'dart:async';

import 'package:dentist_stock/protocol_driver/local_storage_protocol_driver.dart';

class InventoryRepository {
  final StreamController<Inventory> _controller;
  final LocalStorageProtocolDriver _localStorage;

  const InventoryRepository(this._controller, this._localStorage);

  Stream<List<Inventory>> joinedInventories() async* {
    final List<Inventory> currentList = _localStorage.storedInventoryNames
        .map((name) => Inventory(name: name))
        .toList();
    yield currentList;
    await for (Inventory newInventory in _controller.stream) {
      currentList.add(newInventory);
      yield currentList;
    }
  }

  void join(Inventory inventory) {
    _controller.add(inventory);
  }
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

class Inventory {
  final String name;

  const Inventory({required this.name});
}
