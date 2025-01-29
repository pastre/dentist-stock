import 'package:dentist_stock/domain/inventory/inventory_repository.dart';
import 'package:dentist_stock/protocol_driver/local_storage_protocol_driver.dart';
import 'package:dentist_stock/widget/dentist_inventory_app.dart';
import 'package:flutter/material.dart';

void main() {
  final localStorage = EmptyLocalStorage();
  runApp(
    DentistInventoryApp.fromDependencies(localStorage: localStorage),
  );
}

class EmptyLocalStorage implements LocalStorageProtocolDriver {
  @override
  void addInventory(Inventory i) {}

  @override
  // TODO: implement storedInventoryNames
  List<String> get storedInventoryNames => [];
}
