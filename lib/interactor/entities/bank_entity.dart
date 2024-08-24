import 'package:uuid/uuid.dart';

class BankEntity {
  final String id;
  final String description;
  final String path;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BankEntity(
      {required this.id,
      required this.description,
      required this.path,
      required this.createdAt,
      required this.updatedAt});

  BankEntity.newBank({required this.description, required this.path})
      : id = const Uuid().v4(),
        createdAt = DateTime.now(),
        updatedAt = null;
  BankEntity.updateBank(
      {required this.id,
      required this.description,
      required this.path,
      required this.createdAt})
      : updatedAt = DateTime.now();
}
