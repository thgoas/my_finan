import 'dart:convert';
import 'package:my_finan/interactor/entities/bank_entity.dart';

class BankDto extends BankEntity {
  BankDto(
      {required super.id,
      required super.description,
      required super.path,
      required super.createdAt,
      required super.updatedAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'path': path,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory BankDto.fromMap(Map<String, dynamic> map) {
    return BankDto(
      id: map['id'] as String,
      description: map['description'] as String,
      path: map['path'] as String,
      createdAt: map['createdAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: map['updatedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory BankDto.fromJson(String source) =>
      BankDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => toJson().toString();
}
