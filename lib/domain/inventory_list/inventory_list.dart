import 'dart:async';

import 'package:dentist_stock/data/local_storage.dart';
import 'package:dentist_stock/domain/inventory_list/inventory.dart';

class InventoryAlreadyJoined {}

class InventoryList {
  final StreamController<Inventory> _controller;
  final LocalStorage _localStorage;

  const InventoryList(this._controller, this._localStorage);

  Stream<List<Inventory>> get joinedInventories => _joinedInventories();
  Stream<List<Inventory>> _joinedInventories() async* {
    final List<Inventory> currentList = _localStorage.storedInventoryNames
        .map((name) => Inventory(name: name))
        .toList();
    yield currentList;
    await for (Inventory newInventory in _controller.stream) {
      currentList.add(newInventory);
      yield currentList;
    }
  }

  void join({required String inventoryName}) {
    if (_localStorage.storedInventoryNames.contains(inventoryName)) {
      throw InventoryAlreadyJoined();
    }
    final inventory = Inventory(name: inventoryName);
    _localStorage.addInventory(inventory);
    _controller.add(inventory);
  }
}
