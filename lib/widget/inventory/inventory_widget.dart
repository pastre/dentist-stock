import 'package:flutter/material.dart';

class InventoryWidget extends StatelessWidget {
  const InventoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [BarcodeScannerWidget()],
    );
  }
}

class BarcodeScannerWidget extends StatelessWidget {
  const BarcodeScannerWidget({super.key});

  @override
  Widget build(BuildContext context) {}
}
