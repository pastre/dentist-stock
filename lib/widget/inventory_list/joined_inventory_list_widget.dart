import 'package:dentist_stock/domain/inventory_list/inventory_list.dart';
import 'package:dentist_stock/widget/inventory_list/join_inventory_alert.dart';
import 'package:dentist_stock/widget/inventory_list/inventory_row.dart';
import 'package:flutter/material.dart';

class JoinedInventoryListWidget extends StatelessWidget {
  final InventoryList inventoryList;
  const JoinedInventoryListWidget({
    super.key,
    required this.inventoryList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Entrar em um estoque',
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) => JoinInventoryAlert(
                  inventoryList: inventoryList,
                ),
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: inventoryList.joinedInventories,
          builder: (context, snap) {
            final inventoryList = snap.data ?? [];
            return ListView.builder(
              itemBuilder: (context, index) => InventoryRow(
                inventoryName: inventoryList[index].name,
              ),
              itemCount: inventoryList.length,
            );
          }),
    );
  }
}
