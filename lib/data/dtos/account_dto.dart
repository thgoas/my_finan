import 'dart:convert';

import 'package:my_finan/interactor/entities/account_entity.dart';

class AccountDto extends AccountEntity {
  AccountDto(
      {required super.id,
      required super.description,
      required super.iconCode,
      required super.createdAt,
      required super.updatedAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'iconCode': iconCode,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory AccountDto.fromMap(Map<String, dynamic> map) {
    return AccountDto(
      id: map['id'] as String,
      description: map['description'] as String,
      iconCode: map['iconCode'] as int?,
      createdAt: map['createdAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: map['updatedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountDto.fromJson(String source) =>
      AccountDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => toJson().toString();
}
