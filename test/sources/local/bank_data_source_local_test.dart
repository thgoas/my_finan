import 'package:flutter_test/flutter_test.dart';
import 'package:my_finan/data/dtos/bank_dto.dart';

import 'package:my_finan/data/sources/local/bank_data_source_sqlite.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late BankDataSourceSqlite bankDataSource;
  late List<BankDto> resultBank;
  setUpAll(() async {
    // Initialize ffi loader
    sqfliteFfiInit();

    // Change the default factory for unit tests calls.
    databaseFactory = databaseFactoryFfi;

    bankDataSource = BankDataSourceSqlite();
    // bankDataSource.db = db;
    resultBank = await bankDataSource.findAll();
  });

  tearDownAll(() async {
    await bankDataSource.closeDb();
  });

  group('BankDataSourceSqlite', () {
    test('should return bank by id', () async {
      final result = await bankDataSource.findById(resultBank[0].id);

      expect(result?.id, resultBank[0].id);
      expect(result?.description, 'ABC Brasil');
    });

    test('should return null when id is not found', () async {
      final result = await bankDataSource.findById('2');

      expect(result, isNull);
    });

    test('should return bank by description', () async {
      final result =
          await bankDataSource.findByDescription(resultBank[0].description);

      expect(result?.description, resultBank[0].description);
      expect(result?.description, 'ABC Brasil');
    });

    test('should return null when description is not found', () async {
      final result = await bankDataSource.findByDescription('group');

      expect(result, isNull);
    });

    test('should return all banks', () async {
      final result = await bankDataSource.findAll();

      expect(result.length, resultBank.length);
    });

    test('should return a new bank', () async {
      final bank = BankDto(
          id: '1',
          description: 'new bank',
          path: 'path',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());

      final result = await bankDataSource.save(bank);

      expect(result.id, bank.id);
    });

    test('should update bank', () async {
      final bank = BankDto(
          id: '1',
          description: 'new bank edited',
          path: 'path',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
      final result = await bankDataSource.update(bank);
      expect(result?.description, bank.description);
    });
    test('should delete bank', () async {
      const id = '1';
      await bankDataSource.remove(id);
      final result = await bankDataSource.findById(id);
      expect(result, null);
    });
  });
}
