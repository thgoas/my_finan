import 'dart:convert';

import 'package:my_finan/interactor/entities/group_entity.dart';
import 'package:my_finan/interactor/entities/type_method.dart';
import 'package:my_finan/interactor/entities/type_operation.dart';

class GroupDto extends GroupEntity {
  GroupDto({
    required super.id,
    required super.description,
    required super.iconCode,
    required super.createdAt,
    required super.updatedAt,
    required super.typeOperation,
    required super.typeMethod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'typeOperation': typeOperation.toString().split('.').last,
      'typeMethod': typeMethod.toString().split('.').last,
      'iconCode': iconCode,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory GroupDto.fromMap(Map<String, dynamic> map) {
    return GroupDto(
      id: map['id'] as String,
      description: map['description'] as String,
      typeOperation: _stringToTypeOperation(map['typeOperation'] as String),
      typeMethod: _stringToTypeMethod(map['typeMethod'] as String),
      iconCode: map['iconCode'] as int?,
      createdAt: map['createdAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: map['updatedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  static TypeOperation _stringToTypeOperation(String type) {
    switch (type) {
      case 'income':
        return TypeOperation.income;
      case 'expense':
        return TypeOperation.expense;
      case 'transfer':
        return TypeOperation.transfer;
      default:
        throw Exception('Invalid typeOperation');
    }
  }

  static TypeMethod _stringToTypeMethod(String type) {
    switch (type) {
      case 'essential':
        return TypeMethod.essential;
      case 'noEssential':
        return TypeMethod.noEssential;
      case 'reserve':
        return TypeMethod.reserve;
      default:
        throw Exception('Invalid typeMethod');
    }
  }

  String toJson() => json.encode(toMap());

  factory GroupDto.fromJson(String source) =>
      GroupDto.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() {
    return toJson().toString();
  }
}
