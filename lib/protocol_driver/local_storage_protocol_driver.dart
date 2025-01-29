import 'package:dentist_stock/domain/inventory/inventory_repository.dart';

class LocalStorageProtocolDriver {
  final List<String> _inventories = List.empty(growable: true);
  void addInventory(Inventory i) {
    _inventories.add(i.name);
  }

  List<String> get storedInventoryNames => _inventories;
}
