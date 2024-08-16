import 'package:my_finan/core/database/db.dart';
import 'package:my_finan/data/dtos/group_dto.dart';
import 'package:my_finan/data/sources/group_data_source.dart';
import 'package:my_finan/interactor/entities/group_entity.dart';
import 'package:sqflite/sqflite.dart';

class GroupDataSourceSqlite implements GroupDataSource {
  late Database db;

  @override
  Future<List<GroupDto>> findAll() async {
    db = await Db.instance.database;
    final result = await db.query('groups');

    if (result.isEmpty) {
      return [];
    }

    return result.map((e) => GroupDto.fromMap(e)).toList();
  }

  @override
  Future<GroupDto?> findByDescription(String description) async {
    db = await Db.instance.database;

    final result = await db
        .query('groups', where: 'description = ?', whereArgs: [description]);
    if (result.isEmpty) {
      return null;
    }

    return GroupDto.fromMap(result.first);
  }

  @override
  Future<GroupDto?> findById(String id) async {
    db = await Db.instance.database;

    final result = await db.query('groups', where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) {
      return null;
    }

    return GroupDto.fromMap(result.first);
  }

  @override
  Future<void> remove(String id) async {
    db = await Db.instance.database;

    await db.delete('groups', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<GroupDto> save(GroupEntity groupEntity) async {
    db = await Db.instance.database;
    final groupDto = GroupDto(
        id: groupEntity.id,
        description: groupEntity.description,
        typeOperation: groupEntity.typeOperation,
        typeMethod: groupEntity.typeMethod,
        iconCode: groupEntity.iconCode,
        createdAt: groupEntity.createdAt,
        updatedAt: groupEntity.updatedAt);
    print('data source ${groupDto}');
    await db.insert('groups', groupDto.toMap());

    return groupDto;
  }

  @override
  Future<GroupDto?> update(GroupEntity groupEntity) async {
    db = await Db.instance.database;
    final groupDto = GroupDto(
        id: groupEntity.id,
        description: groupEntity.description,
        typeOperation: groupEntity.typeOperation,
        typeMethod: groupEntity.typeMethod,
        iconCode: groupEntity.iconCode,
        createdAt: groupEntity.createdAt,
        updatedAt: groupEntity.updatedAt);
    await db.update(
      'groups',
      groupDto.toMap(),
      where: 'id = ?',
      whereArgs: [groupEntity.id],
    );
    return groupDto;
  }

  Future<void> closeDb() async {
    db = await Db.instance.database;
    db.close();
  }
}
