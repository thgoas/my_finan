import 'package:uuid/uuid.dart';

class AccountEntity {
  final String id;
  final String description;
  final int? iconCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AccountEntity({
    required this.id,
    required this.description,
    required this.iconCode,
    required this.createdAt,
    required this.updatedAt,
  });

  AccountEntity.newAccount({required this.description, required this.iconCode})
      : id = const Uuid().v4(),
        createdAt = DateTime.now(),
        updatedAt = null;

  AccountEntity.updateAccount({
    required this.id,
    required this.description,
    required this.iconCode,
    required this.createdAt,
  }) : updatedAt = DateTime.now();
}
