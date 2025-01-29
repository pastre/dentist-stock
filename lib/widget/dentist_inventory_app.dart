import 'dart:async';

import 'package:dentist_stock/domain/inventory/inventory_list.dart';
import 'package:dentist_stock/domain/inventory/inventory_repository.dart';
import 'package:dentist_stock/protocol_driver/local_storage_protocol_driver.dart';
import 'package:dentist_stock/widget/inventory/joined_inventory_list_widget.dart';
import 'package:flutter/material.dart';

class DentistInventoryApp extends StatelessWidget {
  final InventoryList inventoryList;
  const DentistInventoryApp._({required this.inventoryList});

  factory DentistInventoryApp.fromDependencies({
    required LocalStorageProtocolDriver localStorage,
  }) {
    final controller = StreamController<Inventory>.broadcast(sync: true);
    final inventoryRepository = InventoryRepository(controller, localStorage);
    final inventoryList =
        InventoryList(inventoryRepository: inventoryRepository);
    return DentistInventoryApp._(inventoryList: inventoryList);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: JoinedInventoryListWidget(
        inventoryList: inventoryList,
      ),
    );
  }
}
