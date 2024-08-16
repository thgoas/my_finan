import 'package:flutter_test/flutter_test.dart';
import 'package:my_finan/data/dtos/group_dto.dart';
import 'package:my_finan/data/sources/local/group_data_source_sqlite.dart';
import 'package:my_finan/interactor/entities/type_method.dart';
import 'package:my_finan/interactor/entities/type_operation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;
  late GroupDataSourceSqlite groupDataSource;
  late List<GroupDto> resultGroups;
  setUpAll(() async {
    // Initialize ffi loader
    sqfliteFfiInit();

    // Change the default factory for unit tests calls.
    databaseFactory = databaseFactoryFfi;

    groupDataSource = GroupDataSourceSqlite();
    // groupDataSource.db = db;
    resultGroups = await groupDataSource.findAll();
  });

  tearDownAll(() async {
    await groupDataSource.closeDb();
  });

  group('GroupDataSourceSqlite', () {
    test('should return group by id', () async {
      final result = await groupDataSource.findById(resultGroups[0].id);

      expect(result?.id, resultGroups[0].id);
      expect(result?.description, 'Super mercado');
    });

    test('should return null when id is not found', () async {
      final result = await groupDataSource.findById('2');

      expect(result, isNull);
    });

    test('should return group by description', () async {
      final result =
          await groupDataSource.findByDescription(resultGroups[0].description);

      expect(result?.description, resultGroups[0].description);
      expect(result?.description, 'Super mercado');
    });

    test('should return null when description is not found', () async {
      final result = await groupDataSource.findByDescription('group');

      expect(result, isNull);
    });

    test('should return all groups', () async {
      final result = await groupDataSource.findAll();

      expect(result.length, resultGroups.length);
    });

    test('should return a new group', () async {
      final group = GroupDto(
          id: '1',
          description: 'new group',
          typeOperation: TypeOperation.income,
          typeMethod: TypeMethod.essential,
          iconCode: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());

      final result = await groupDataSource.save(group);

      expect(result.id, group.id);
    });

    test('should update group', () async {
      final group = GroupDto(
          id: '1',
          description: 'new group edited',
          typeOperation: TypeOperation.expense,
          typeMethod: TypeMethod.noEssential,
          iconCode: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
      final result = await groupDataSource.update(group);
      expect(result?.description, group.description);
    });
    test('should delete group', () async {
      final id = '1';
      await groupDataSource.remove(id);
      final result = await groupDataSource.findById(id);
      expect(result, null);
    });
  });
}
