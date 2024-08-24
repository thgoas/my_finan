import 'package:flutter/foundation.dart';
import 'package:my_finan/interactor/entities/bank_entity.dart';
import 'package:my_finan/interactor/errors/failure_bank.dart';
import 'package:my_finan/interactor/repositories/bank_repository.dart';
import 'package:my_finan/interactor/states/bank_state.dart';

class BankController {
  final BankRepository repository;
  var state = ValueNotifier<BankState>(BankStartState());

  BankController(this.repository);

  getBanks() async {
    try {
      final result = await repository.findAll();
      state.value = result;
    } catch (e) {
      state.value = BankErrorState(GenericError(e.toString()));
    }
  }

  getBankById(String id) async {
    if (id.isEmpty) {
      state.value = BankErrorState(InvalidIdError('Invalid id'));
      return;
    }

    try {
      final result = await repository.findById(id);
      state.value = result;
    } catch (e) {
      state.value = BankErrorState(GenericError(e.toString()));
    }
  }

  getBankByDescription(String description) async {
    if (description.isEmpty) {
      state.value = BankErrorState(InvalidIdError('Invalid description'));
      return;
    }
    try {
      final result = await repository.findByDescription(description);
      state.value = result;
    } catch (e) {
      state.value = BankErrorState(GenericError(e.toString()));
    }
  }

  saveBank(InputNewBank bank) async {
    final newBank =
        BankEntity.newBank(description: bank.description, path: bank.path);
    try {
      await repository.save(newBank);
      await getBanks();
    } catch (e) {
      state.value = BankErrorState(GenericError(e.toString()));
    }
  }

  updateBank(InputUpdateBank bank) async {
    final updateBank = BankEntity.updateBank(
      id: bank.id,
      description: bank.description,
      path: bank.path,
      createdAt: bank.createdAt,
    );

    try {
      await repository.update(updateBank);
      await getBanks();
    } catch (e) {
      state.value = BankErrorState(GenericError(e.toString()));
    }
  }

  removeBank(String id) async {
    if (id.isEmpty) {
      state.value = BankErrorState(InvalidIdError('Invalid id'));
      return;
    }
    try {
      await repository.remove(id);
      await getBanks();
    } catch (e) {
      state.value = BankErrorState(GenericError(e.toString()));
    }
  }
}

class InputNewBank {
  final String description;
  final String path;
  InputNewBank({
    required this.description,
    required this.path,
  });
}

class InputUpdateBank {
  final String id;
  final String description;
  final String path;
  final DateTime? createdAt;
  InputUpdateBank({
    required this.id,
    required this.description,
    required this.path,
    required this.createdAt,
  });
}
