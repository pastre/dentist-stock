import 'package:dentist_stock/domain/inventory_list/inventory_list.dart';
import 'package:dentist_stock/widget/inventory/inventory_widget.dart';
import 'package:flutter/material.dart';

class JoinInventoryAlert extends StatefulWidget {
  final InventoryList inventoryList;
  const JoinInventoryAlert({
    super.key,
    required this.inventoryList,
  });

  @override
  State<JoinInventoryAlert> createState() => _JoinInventoryAlertState();
}

class _JoinInventoryAlertState extends State<JoinInventoryAlert> {
  String _currentInventoryName = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Digite o nome do estoque'),
      content: TextField(
        onChanged: (value) => setState(() {
          _currentInventoryName = value;
        }),
      ),
      actions: [
        TextButton(
          onPressed: _currentInventoryName.isEmpty ? null : () => _onPressed(),
          child: Text('Entrar'),
        ),
      ],
    );
  }

  void _onPressed() {
    try {
      widget.inventoryList.join(inventoryName: _currentInventoryName);
      Navigator.of(context).pop();
    } on InventoryAlreadyJoined {
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => InventoryWidget()),
      );
    }
  }
}
