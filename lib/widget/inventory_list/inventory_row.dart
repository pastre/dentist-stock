import 'package:flutter/material.dart';

class InventoryRow extends StatelessWidget {
  final String inventoryName;

  const InventoryRow({super.key, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    return Text(inventoryName);
  }
}
