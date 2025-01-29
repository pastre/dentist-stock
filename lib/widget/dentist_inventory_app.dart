import 'package:dentist_stock/main.dart';
import 'package:dentist_stock/widget/inventory/joined_inventory_list_widget.dart';
import 'package:flutter/material.dart';

class DentistInventoryApp extends StatelessWidget {
  const DentistInventoryApp({super.key});

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
