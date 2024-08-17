import 'package:my_finan/interactor/entities/account_entity.dart';
import 'package:my_finan/interactor/states/account_state.dart';

abstract class AccountRepository {
  Future<AccountState> save(AccountEntity accountEntity);
  Future<AccountState> update(AccountEntity accountEntity);
  Future<AccountState> findById(String id);
  Future<AccountState> findByDescription(String description);
  Future<AccountState> findAll();
  Future<AccountState> remove(String id);
}
