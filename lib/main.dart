import 'package:dentist_stock/domain/inventory/inventory.dart';
import 'package:dentist_stock/data/local_storage.dart';
import 'package:dentist_stock/widget/dentist_inventory_app.dart';
import 'package:flutter/material.dart';

void main() {
  final localStorage = EmptyLocalStorage();
  runApp(
    DentistInventoryApp.fromDependencies(localStorage: localStorage),
  );
}

class EmptyLocalStorage implements LocalStorage {
  @override
  void addInventory(Inventory i) {}

  @override
  // TODO: implement storedInventoryNames
  List<String> get storedInventoryNames => [];
}
