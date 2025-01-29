import 'dart:async';

import 'package:dentist_stock/inventory_list.dart';
import 'package:dentist_stock/inventory_repository.dart';
import 'package:dentist_stock/widget/dentist_inventory_app.dart';
import 'package:flutter/material.dart';

final controller = StreamController<Inventory>.broadcast(sync: true);
final inventoryRepository = InventoryRepository(controller);
final inventoryList = InventoryList(inventoryRepository: inventoryRepository);

void main() {
  runApp(
    const DentistInventoryApp(),
  );
}
