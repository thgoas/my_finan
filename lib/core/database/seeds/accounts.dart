import 'package:uuid/uuid.dart';

List<Map<String, Object?>> accountsValues() {
  final createdAt = DateTime.now().millisecondsSinceEpoch;
  return [
    {
      'id': const Uuid().v1(),
      'description': 'Conta Corrente',
      'iconCode': 57408,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'Conta Poupança',
      'iconCode': 57408,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'Cartão de Credito',
      'iconCode': 57759,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'Cartão de Debito',
      'iconCode': 57759,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'Pix',
      'iconCode': 984398,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'Carteira',
      'iconCode': 57409,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'Boleto',
      'iconCode': 58671,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'TED',
      'iconCode': 984284,
      'createdAt': createdAt,
      'updatedAt': null
    },
    {
      'id': const Uuid().v1(),
      'description': 'DOC',
      'iconCode': 984284,
      'createdAt': createdAt,
      'updatedAt': null
    },
  ];
}
