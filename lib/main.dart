import 'dart:async';

import 'package:dentist_stock/inventory_list.dart';
import 'package:dentist_stock/inventory_repository.dart';
import 'package:flutter/material.dart';

final controller = StreamController<Inventory>.broadcast(sync: true);
final inventoryRepository = InventoryRepository(controller);
final inventoryList = InventoryList(inventoryRepository: inventoryRepository);

void main() {
  runApp(
    const DentistInventoryApp(),
  );
}

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

class InventoryRow extends StatelessWidget {
  final String inventoryName;

  const InventoryRow({super.key, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    return Text(inventoryName);
  }
}

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
    widget.inventoryList.join(inventoryName: _currentInventoryName);
    Navigator.of(context).pop();
  }
}
