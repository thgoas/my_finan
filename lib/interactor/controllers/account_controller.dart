import 'package:flutter/foundation.dart';
import 'package:my_finan/interactor/entities/account_entity.dart';
import 'package:my_finan/interactor/errors/failure_account.dart';
import 'package:my_finan/interactor/repositories/account_repository.dart';
import 'package:my_finan/interactor/states/account_state.dart';

class AccountController {
  final AccountRepository repository;
  var state = ValueNotifier<AccountState>(AccountStartState());

  AccountController(this.repository);

  getAccounts() async {
    state.value = AccountLoadingState();
    try {
      final result = await repository.findAll();
      state.value = result;
    } catch (e) {
      state.value = AccountErrorState(GenericError(e.toString()));
    }
  }

  getAccountById(String id) async {
    state.value = AccountLoadingState();
    if (id.isEmpty) {
      state.value = AccountErrorState(InvalidIdError('Invalid id'));
      return;
    }

    try {
      final result = await repository.findById(id);
      state.value = result;
    } catch (e) {
      state.value = AccountErrorState(GenericError(e.toString()));
    }
  }

  getAccountByDescription(String description) async {
    state.value = AccountLoadingState();
    if (description.isEmpty) {
      state.value = AccountErrorState(InvalidIdError('Invalid description'));
      return;
    }
    try {
      final result = await repository.findByDescription(description);
      state.value = result;
    } catch (e) {
      state.value = AccountErrorState(GenericError(e.toString()));
    }
  }

  saveAccount(InputNewAccount account) async {
    state.value = AccountLoadingState();
    final newAccount = AccountEntity.newAccount(
        description: account.description, iconCode: account.iconCode);
    try {
      await repository.save(newAccount);
      await getAccounts();
    } catch (e) {
      state.value = AccountErrorState(GenericError(e.toString()));
    }
  }

  updateAccount(InputUpdateAccount account) async {
    state.value = AccountLoadingState();
    final updateAccount = AccountEntity.updateAccount(
      id: account.id,
      description: account.description,
      iconCode: account.iconCode,
      createdAt: account.createdAt,
    );

    try {
      await repository.update(updateAccount);
      await getAccounts();
    } catch (e) {
      state.value = AccountErrorState(GenericError(e.toString()));
    }
  }

  removeAccount(String id) async {
    state.value = AccountLoadingState();
    if (id.isEmpty) {
      state.value = AccountErrorState(InvalidIdError('Invalid id'));
      return;
    }
    try {
      await repository.remove(id);
      await getAccounts();
    } catch (e) {
      state.value = AccountErrorState(GenericError(e.toString()));
    }
  }
}

class InputNewAccount {
  final String description;
  final int? iconCode;
  InputNewAccount({
    required this.description,
    required this.iconCode,
  });
}

class InputUpdateAccount {
  final String id;
  final String description;
  final int? iconCode;
  final DateTime? createdAt;
  InputUpdateAccount({
    required this.id,
    required this.description,
    required this.iconCode,
    required this.createdAt,
  });
}
