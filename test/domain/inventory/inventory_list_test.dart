import 'dart:async';

import 'package:dentist_stock/domain/inventory/inventory_list.dart';
import 'package:dentist_stock/domain/inventory/inventory_repository.dart';
import 'package:dentist_stock/main.dart';
import 'package:dentist_stock/data/local_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('emits new value when joins inventory', () {
    final sut = _makeSut();
    expect(
      sut.joinedInventories.skip(1).map((list) => list.first.name),
      emits('expected_inventory_name'),
    );
    sut.join(inventoryName: 'expected_inventory_name');
  }, timeout: Timeout(Duration(seconds: 1)));

  test('loads from local storage when starts listening', () {
    final localStorage = StubLocalStorageProtocolDriver(
      inventoryNames: ['expected_inventory_name'],
    );
    final sut = _makeSut(localStorage: localStorage);
    expect(
      sut.joinedInventories.map((list) => list.first.name),
      emits('expected_inventory_name'),
    );
  }, timeout: Timeout(Duration(seconds: 1)));
}

class StubLocalStorageProtocolDriver implements LocalStorage {
  final List<String> _inventoryNames;

  StubLocalStorageProtocolDriver({
    required List<String> inventoryNames,
  }) : _inventoryNames = inventoryNames;
  @override
  void addInventory(Inventory i) {}

  @override
  List<String> get storedInventoryNames => _inventoryNames;
}

InventoryList _makeSut({StubLocalStorageProtocolDriver? localStorage}) {
  return InventoryList(
    inventoryRepository: InventoryRepository(
        StreamController(sync: true), localStorage ?? EmptyLocalStorage()),
  );
}
