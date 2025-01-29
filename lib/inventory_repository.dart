import 'dart:async';

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
