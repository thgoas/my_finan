import 'package:my_finan/interactor/entities/bank_entity.dart';
import 'package:my_finan/interactor/states/bank_state.dart';

abstract class BankRepository {
  Future<BankState> save(BankEntity bankEntity);
  Future<BankState> update(BankEntity bankEntity);
  Future<BankState> findById(String id);
  Future<BankState> findByDescription(String description);
  Future<BankState> findAll();
  Future<BankState> remove(String id);
}
