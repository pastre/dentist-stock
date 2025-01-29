import 'dart:async';

import 'package:dentist_stock/domain/inventory_list/inventory_list.dart';
import 'package:dentist_stock/domain/inventory_list/inventory.dart';
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

  test('stores to disk when joins inventory', () {
    final localStorage = InMemoryLocalStorage();
    final sut = _makeSut(localStorage: localStorage);
    sut.join(inventoryName: 'expected_inventory_name');
    expect(localStorage.storedInventoryNames, isNotEmpty);
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

  test('throws when joining an already joined inventory', () {
    final localStorage = StubLocalStorageProtocolDriver(
      inventoryNames: ['existing_inventory'],
    );
    final sut = _makeSut(localStorage: localStorage);
    expect(() => sut.join(inventoryName: 'existing_inventory'),
        throwsA(isA<InventoryAlreadyJoined>()));
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

InventoryList _makeSut({LocalStorage? localStorage}) {
  return InventoryList(
    StreamController(sync: true),
    localStorage ?? InMemoryLocalStorage(),
  );
}
