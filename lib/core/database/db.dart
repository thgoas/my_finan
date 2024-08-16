import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

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
    for (var group in _groupsValues) {
      await db.insert('groups', group,
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

  List<Map<String, Object?>> get _groupsValues {
    final createdAt = DateTime.now().millisecondsSinceEpoch;
    return [
      {
        'id': Uuid().v1(),
        'description': 'Super mercado',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58261
      },
      {
        'id': Uuid().v1(),
        'description': 'Manutenção Casa',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58098
      },
      {
        'id': Uuid().v1(),
        'description': 'Combustivel',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58260
      },
      {
        'id': Uuid().v1(),
        'description': 'Aluguel Casa',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58136
      },
      {
        'id': Uuid().v1(),
        'description': 'Dizimos e Ofertas',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 984269,
      },
      {
        'id': Uuid().v1(),
        'description': 'Energia',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 984988
      },
      {
        'id': Uuid().v1(),
        'description': 'Emprestimo',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 57522
      },
      {
        'id': Uuid().v1(),
        'description': 'Financiamento Moto',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58863
      },
      {
        'id': Uuid().v1(),
        'description': 'Internet',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 59111
      },
      {
        'id': Uuid().v1(),
        'description': 'Lazer',
        'typeMethod': 'noEssential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 57558
      },
      {
        'id': Uuid().v1(),
        'description': 'Plano de Saúde',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58328
      },
      {
        'id': Uuid().v1(),
        'description': 'Gastos com veiculos',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 57661
      },
      {
        'id': Uuid().v1(),
        'description': 'Departamento de trânsito',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58996
      },
      {
        'id': Uuid().v1(),
        'description': 'Seguro veículos',
        'typeMethod': 'noEssential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58774
      },
      {
        'id': Uuid().v1(),
        'description': 'Assinatura de Tv',
        'typeMethod': 'noEssential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58247
      },
      {
        'id': Uuid().v1(),
        'description': 'Drogaria',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 984378
      },
      {
        'id': Uuid().v1(),
        'description': 'Estacionamento',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58269
      },
      {
        'id': Uuid().v1(),
        'description': 'Lanche',
        'typeMethod': 'noEssential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58306
      },
      {
        'id': Uuid().v1(),
        'description': 'Salão de beleza / barbearia',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 57745
      },
      {
        'id': Uuid().v1(),
        'description': 'Outros',
        'typeMethod': 'noEssential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58500
      },
      {
        'id': Uuid().v1(),
        'description': 'INSS',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58671
      },
      {
        'id': Uuid().v1(),
        'description': 'Ticket Alimentação',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 57734
      },
      {
        'id': Uuid().v1(),
        'description': 'Pet',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58529
      },
      {
        'id': Uuid().v1(),
        'description': 'Plano celular',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58882
      },
      {
        'id': Uuid().v1(),
        'description': 'Conserto eletronicos',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 57623
      },
      {
        'id': Uuid().v1(),
        'description': 'Taxi / Uber',
        'typeMethod': 'noEssential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58279,
      },
      {
        'id': Uuid().v1(),
        'description': 'Passagens de onibus',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58813,
      },
      {
        'id': Uuid().v1(),
        'description': 'Escola crianças',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58713,
      },
      {
        'id': Uuid().v1(),
        'description': 'Faculdades / Cursos',
        'typeMethod': 'reserve',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58713,
      },
      {
        'id': Uuid().v1(),
        'description': 'Água',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 984482,
      },
      {
        'id': Uuid().v1(),
        'description': 'Stream Video / musica',
        'typeMethod': 'noEssential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58247,
      },
      {
        'id': Uuid().v1(),
        'description': 'Roupas / Acessorios',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 57693,
      },
      {
        'id': Uuid().v1(),
        'description': 'Hoby',
        'typeMethod': 'noEssential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58866,
      },
      {
        'id': Uuid().v1(),
        'description': 'Presentes',
        'typeMethod': 'noEssential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 57673,
      },
      {
        'id': Uuid().v1(),
        'description': 'Doação',
        'typeMethod': 'reserve',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': '59078',
      },
      {
        'id': Uuid().v1(),
        'description': 'Salario',
        'typeMethod': 'essential',
        'typeOperation': 'income',
        'createdAt': createdAt,
        'iconCode': 57522
      },
      {
        'id': Uuid().v1(),
        'description': 'Free Lancer',
        'typeMethod': 'essential',
        'typeOperation': 'income',
        'createdAt': createdAt,
        'iconCode': 58141
      },
      {
        'id': Uuid().v1(),
        'description': 'Entradas a Vulsa',
        'typeMethod': 'essential',
        'typeOperation': 'income',
        'createdAt': createdAt,
        'iconCode': 57522
      },
      {
        'id': Uuid().v1(),
        'description': 'Investimentos',
        'typeMethod': 'reserve',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58707
      },
      {
        'id': Uuid().v1(),
        'description': 'Padaria',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 57545
      },
      {
        'id': Uuid().v1(),
        'description': 'Rem Basica',
        'typeMethod': 'essential',
        'typeOperation': 'income',
        'createdAt': createdAt,
        'iconCode': 58671
      },
      {
        'id': Uuid().v1(),
        'description': 'Cred Juros',
        'typeMethod': 'essential',
        'typeOperation': 'income',
        'createdAt': createdAt,
        'iconCode': 58671
      },
      {
        'id': Uuid().v1(),
        'description': 'Imposto de renda',
        'typeMethod': 'essential',
        'typeOperation': 'income',
        'createdAt': createdAt,
        'iconCode': 58671
      },
      {
        'id': Uuid().v1(),
        'description': 'Juros Pag Atrasado',
        'typeMethod': 'essential',
        'typeOperation': 'expense',
        'createdAt': createdAt,
        'iconCode': 58671
      },
      {
        'id': Uuid().v1(),
        'description': 'FGTS',
        'typeMethod': 'essential',
        'typeOperation': 'income',
        'createdAt': createdAt,
        'iconCode': 58671
      },
    ];
  }
}
