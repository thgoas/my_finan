import 'package:my_finan/core/database/db.dart';
import 'package:my_finan/data/dtos/account_dto.dart';
import 'package:my_finan/data/sources/account_data_source.dart';
import 'package:my_finan/interactor/entities/account_entity.dart';
import 'package:sqflite/sqflite.dart';

class AccountDataSourceSqlite implements AccountDataSource {
  late Database db;

  @override
  Future<List<AccountDto>> findAll() async {
    db = await Db.instance.database;
    final result = await db.query('accounts');

    if (result.isEmpty) {
      return [];
    }

    return result.map((e) => AccountDto.fromMap(e)).toList();
  }

  @override
  Future<AccountDto?> findByDescription(String description) async {
    db = await Db.instance.database;

    final result = await db
        .query('accounts', where: 'description = ?', whereArgs: [description]);
    if (result.isEmpty) {
      return null;
    }

    return AccountDto.fromMap(result.first);
  }

  @override
  Future<AccountDto?> findById(String id) async {
    db = await Db.instance.database;

    final result = await db.query('accounts', where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) {
      return null;
    }

    return AccountDto.fromMap(result.first);
  }

  @override
  Future<void> remove(String id) async {
    db = await Db.instance.database;

    await db.delete('accounts', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<AccountDto> save(AccountEntity accountEntity) async {
    db = await Db.instance.database;
    final accountDto = AccountDto(
        id: accountEntity.id,
        description: accountEntity.description,
        iconCode: accountEntity.iconCode,
        createdAt: accountEntity.createdAt,
        updatedAt: accountEntity.updatedAt);

    await db.insert('accounts', accountDto.toMap());

    return accountDto;
  }

  @override
  Future<AccountDto?> update(AccountEntity accountEntity) async {
    db = await Db.instance.database;
    final accountDto = AccountDto(
        id: accountEntity.id,
        description: accountEntity.description,
        iconCode: accountEntity.iconCode,
        createdAt: accountEntity.createdAt,
        updatedAt: accountEntity.updatedAt);
    await db.update(
      'accounts',
      accountDto.toMap(),
      where: 'id = ?',
      whereArgs: [accountEntity.id],
    );
    return accountDto;
  }

  Future<void> closeDb() async {
    db = await Db.instance.database;
    db.close();
  }
}
