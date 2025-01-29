import 'package:dentist_stock/domain/inventory_list/inventory.dart';
import 'package:dentist_stock/data/local_storage.dart';
import 'package:dentist_stock/widget/dentist_inventory_app.dart';
import 'package:flutter/material.dart';

void main() {
  final localStorage = InMemoryLocalStorage();
  runApp(
    DentistInventoryApp.fromDependencies(localStorage: localStorage),
  );
}

class InMemoryLocalStorage implements LocalStorage {
  final List<String> _inventories = List.empty(growable: true);
  @override
  void addInventory(Inventory i) {
    _inventories.add(i.name);
  }

  @override
  // TODO: implement storedInventoryNames
  List<String> get storedInventoryNames => _inventories;
}
