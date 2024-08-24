import 'package:my_finan/interactor/entities/bank_entity.dart';
import 'package:my_finan/interactor/errors/failure_bank.dart';

abstract class BankState {}

class BankLoadingState extends BankState {}

class BankStartState extends BankState {}

class BankSuccessfulState extends BankState {
  final List<BankEntity> banks;

  BankSuccessfulState(this.banks);
}

class BankErrorState extends BankState {
  final FailureBank failure;

  BankErrorState(this.failure);
}
