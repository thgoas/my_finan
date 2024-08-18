import 'package:flutter_test/flutter_test.dart';
import 'package:my_finan/data/dtos/account_dto.dart';
import 'package:my_finan/data/dtos/group_dto.dart';
import 'package:my_finan/data/sources/local/account_data_source_sqlite.dart';
import 'package:my_finan/interactor/entities/type_method.dart';
import 'package:my_finan/interactor/entities/type_operation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;
  late AccountDataSourceSqlite accountDataSource;
  late List<AccountDto> resultAccount;
  setUpAll(() async {
    // Initialize ffi loader
    sqfliteFfiInit();

    // Change the default factory for unit tests calls.
    databaseFactory = databaseFactoryFfi;

    accountDataSource = AccountDataSourceSqlite();
    // accountDataSource.db = db;
    resultAccount = await accountDataSource.findAll();
  });

  tearDownAll(() async {
    await accountDataSource.closeDb();
  });

  group('AccountDataSourceSqlite', () {
    test('should return account by id', () async {
      final result = await accountDataSource.findById(resultAccount[0].id);

      expect(result?.id, resultAccount[0].id);
      expect(result?.description, 'Conta Corrente');
    });

    test('should return null when id is not found', () async {
      final result = await accountDataSource.findById('2');

      expect(result, isNull);
    });

    test('should return account by description', () async {
      final result = await accountDataSource
          .findByDescription(resultAccount[0].description);

      expect(result?.description, resultAccount[0].description);
      expect(result?.description, 'Conta Corrente');
    });

    test('should return null when description is not found', () async {
      final result = await accountDataSource.findByDescription('group');

      expect(result, isNull);
    });

    test('should return all accounts', () async {
      final result = await accountDataSource.findAll();

      expect(result.length, resultAccount.length);
    });

    test('should return a new account', () async {
      final account = AccountDto(
          id: '1',
          description: 'new account',
          iconCode: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());

      final result = await accountDataSource.save(account);

      expect(result.id, account.id);
    });

    test('should update account', () async {
      final account = AccountDto(
          id: '1',
          description: 'new account edited',
          iconCode: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
      final result = await accountDataSource.update(account);
      expect(result?.description, account.description);
    });
    test('should delete account', () async {
      const id = '1';
      await accountDataSource.remove(id);
      final result = await accountDataSource.findById(id);
      expect(result, null);
    });
  });
}
