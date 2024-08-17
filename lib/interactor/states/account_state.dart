import 'package:my_finan/interactor/entities/account_entity.dart';
import 'package:my_finan/interactor/errors/failure_account.dart';

abstract class AccountState {}

class AccountLoadingState extends AccountState {}

class AccountStartState extends AccountState {}

class AccountSuccessfulState extends AccountState {
  final List<AccountEntity> accounts;

  AccountSuccessfulState(this.accounts);
}

class AccountErrorState extends AccountState {
  final FailureAccount failure;

  AccountErrorState(this.failure);
}
