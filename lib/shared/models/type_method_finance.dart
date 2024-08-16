import 'package:flutter/material.dart';
import 'package:my_finan/interactor/entities/type_method.dart';

class TypeMethodFinance {
  TypeMethod? typeMethod;
  setTypeMethod(String type) {
    switch (type) {
      case 'Essencial':
        typeMethod = TypeMethod.essential;
        break;
      case 'Não essencial':
        typeMethod = TypeMethod.noEssential;
        break;
      case 'Reserva':
        typeMethod = TypeMethod.reserve;
        break;
    }
  }

  typeMethodToMap(TypeMethod? typeMethod) {
    switch (typeMethod) {
      case TypeMethod.essential:
        return {'name': 'Essencial', 'text': '50%', 'color': Colors.green};
      case TypeMethod.noEssential:
        return {'name': 'Não essencial', 'text': '30%', 'color': Colors.red};
      case TypeMethod.reserve:
        return {'name': 'Reserva', 'text': '20%', 'color': Colors.blue};
      default:
        return {'name': 'Escolha um metodo', 'text': '0%', 'color': Colors.red};
    }
  }
}
