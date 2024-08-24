import 'package:my_finan/core/database/seeds/accounts.dart';
import 'package:my_finan/core/database/seeds/banks.dart';
import 'package:my_finan/core/database/seeds/groups.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  Db._();
  static final Db _instance = Db._();
  static Db get instance => _instance;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _init();
    return _database!;
  }

  Future<Database> _init() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'my_finan.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(_groupsTable);
    await db.execute(_accountsTable);
    await db.execute(_banksTable);
    final groups = groupsValues();
    for (var group in groups) {
      await db.insert('groups', group,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    final accounts = accountsValues();

    for (var account in accounts) {
      await db.insert('accounts', account,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    for (var bank in banksValues()) {
      await db.insert('banks', bank,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  String get _groupsTable => '''
  CREATE TABLE groups (
    id TEXT PRIMARY KEY,
    description TEXT,
    typeOperation TEXT,
    typeMethod TEXT,
    iconCode INT,
    createdAt INT,
    updatedAt INT
  )
''';

  String get _accountsTable => '''
  CREATE TABLE accounts (
    id TEXT PRIMARY KEY,
    description TEXT,
    iconCode INT,
    createdAt INT,
    updatedAt INT
  )
''';

  String get _banksTable => '''
  CREATE TABLE banks (
    id TEXT PRIMARY KEY,
    description TEXT,
    path TEXT,
    createdAt INT,
    updatedAt INT
  )
''';
}
