import 'package:my_finan/interactor/entities/type_method.dart';
import 'package:my_finan/interactor/entities/type_operation.dart';
import 'package:uuid/uuid.dart';

class GroupEntity {
  final String id;
  final String description;
  final int? iconCode;
  final TypeOperation typeOperation;
  final TypeMethod typeMethod;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupEntity(
      {required this.id,
      required this.description,
      required this.iconCode,
      required this.typeOperation,
      required this.typeMethod,
      required this.createdAt,
      required this.updatedAt});

  GroupEntity.newGroup({
    required this.description,
    required this.typeOperation,
    required this.typeMethod,
    required this.iconCode,
  })  : id = const Uuid().v4(),
        createdAt = DateTime.now(),
        updatedAt = null;

  GroupEntity.updateGroup({
    required this.id,
    required this.description,
    required this.typeOperation,
    required this.typeMethod,
    required this.iconCode,
    required this.createdAt,
  }) : updatedAt = DateTime.now();
}
