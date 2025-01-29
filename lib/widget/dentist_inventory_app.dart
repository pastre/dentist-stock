import 'dart:async';

import 'package:dentist_stock/domain/inventory_list/inventory_list.dart';
import 'package:dentist_stock/data/local_storage.dart';
import 'package:dentist_stock/domain/inventory_list/inventory.dart';
import 'package:dentist_stock/widget/inventory_list/joined_inventory_list_widget.dart';
import 'package:flutter/material.dart';

class DentistInventoryApp extends StatelessWidget {
  final InventoryList inventoryList;
  const DentistInventoryApp._({required this.inventoryList});

  factory DentistInventoryApp.fromDependencies({
    required LocalStorage localStorage,
  }) {
    final controller = StreamController<Inventory>.broadcast(sync: true);
    final inventoryList = InventoryList(controller, localStorage);
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
