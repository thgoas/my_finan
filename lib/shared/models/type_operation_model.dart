import 'package:flutter/material.dart';
import 'package:my_finan/interactor/entities/type_operation.dart';

class TypeOperationModel {
  TypeOperation? typeOperation;

  setTypeOperation(String type) {
    switch (type) {
      case 'Receita':
        typeOperation = TypeOperation.income;
        break;
      case 'Despesa':
        typeOperation = TypeOperation.expense;
        break;
      case 'Transferencia':
        typeOperation = TypeOperation.transfer;
        break;
    }
  }

  typeOperationToMap(TypeOperation? typeOperation) {
    switch (typeOperation) {
      case TypeOperation.income:
        return {
          'name': 'Receita',
          'icon': Icons.call_received,
          'color': Colors.green
        };
      case TypeOperation.expense:
        return {
          'name': 'Despesa',
          'icon': Icons.call_made,
          'color': Colors.red
        };
      case TypeOperation.transfer:
        return {
          'name': 'Transferencia',
          'icon': Icons.import_export,
          'color': Colors.blue
        };
      default:
        return {
          'name': 'Escolha uma operação',
          'icon': Icons.close,
          'color': Colors.red
        };
    }
  }
}
