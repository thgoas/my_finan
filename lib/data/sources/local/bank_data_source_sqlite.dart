import 'package:my_finan/core/database/db.dart';
import 'package:my_finan/data/dtos/bank_dto.dart';
import 'package:my_finan/data/sources/bank_data_source.dart';
import 'package:my_finan/interactor/entities/bank_entity.dart';
import 'package:sqflite/sqflite.dart';

class BankDataSourceSqlite implements BankDataSource {
  late Database db;

  @override
  Future<List<BankDto>> findAll() async {
    db = await Db.instance.database;
    final result = await db.query('banks');

    if (result.isEmpty) {
      return [];
    }

    return result.map((e) => BankDto.fromMap(e)).toList();
  }

  @override
  Future<BankDto?> findByDescription(String description) async {
    db = await Db.instance.database;

    final result = await db
        .query('banks', where: 'description = ?', whereArgs: [description]);
    if (result.isEmpty) {
      return null;
    }

    return BankDto.fromMap(result.first);
  }

  @override
  Future<BankDto?> findById(String id) async {
    db = await Db.instance.database;

    final result = await db.query('banks', where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) {
      return null;
    }

    return BankDto.fromMap(result.first);
  }

  @override
  Future<void> remove(String id) async {
    db = await Db.instance.database;

    await db.delete('banks', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<BankDto> save(BankEntity bankEntity) async {
    db = await Db.instance.database;
    final bankDto = BankDto(
        id: bankEntity.id,
        description: bankEntity.description,
        path: bankEntity.path,
        createdAt: bankEntity.createdAt,
        updatedAt: bankEntity.updatedAt);

    await db.insert('banks', bankDto.toMap());

    return bankDto;
  }

  @override
  Future<BankDto?> update(BankEntity bankEntity) async {
    db = await Db.instance.database;
    final bankDto = BankDto(
        id: bankEntity.id,
        description: bankEntity.description,
        path: bankEntity.path,
        createdAt: bankEntity.createdAt,
        updatedAt: bankEntity.updatedAt);
    await db.update(
      'banks',
      bankDto.toMap(),
      where: 'id = ?',
      whereArgs: [bankEntity.id],
    );
    return bankDto;
  }

  Future<void> closeDb() async {
    db = await Db.instance.database;
    db.close();
  }
}
