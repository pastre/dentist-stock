import 'package:dentist_stock/widget/inventory/inventory_widget.dart';
import 'package:flutter/material.dart';

class InventoryRow extends StatelessWidget {
  final String inventoryName;

  const InventoryRow({super.key, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(inventoryName),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InventoryWidget(),
        ),
      ),
    );
  }
}
