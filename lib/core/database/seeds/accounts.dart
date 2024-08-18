import 'package:uuid/uuid.dart';

List<Map<String, Object?>> accountsValues() {
  final createdAt = DateTime.now().millisecondsSinceEpoch;
  return [
    {
      'id': const Uuid().v1(),
      'description': 'Conta Corrente',
      'iconCode': 58068,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'Conta Poupança',
      'iconCode': 58064,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'Cartão de Credito',
      'iconCode': 58060,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'Cartão de Debito',
      'iconCode': 58062,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'Pix',
      'iconCode': 58060,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'Carteira',
      'iconCode': 58060,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'Boleto',
      'iconCode': 58060,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'TED',
      'iconCode': 58060,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'DOC',
      'iconCode': 58060,
      'createdAt': createdAt,
      'updatedAt': null
    },
  ];
}
