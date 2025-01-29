import 'package:dentist_stock/domain/inventory/inventory.dart';

class LocalStorage {
  final List<String> _inventories = List.empty(growable: true);
  void addInventory(Inventory i) {
    _inventories.add(i.name);
  }

  List<String> get storedInventoryNames => _inventories;
}
