import 'package:my_finan/data/dtos/account_dto.dart';
import 'package:my_finan/interactor/entities/account_entity.dart';

abstract class AccountDataSource {
  Future<AccountDto> save(AccountEntity accountEntity);
  Future<AccountDto?> update(AccountEntity accountEntity);
  Future<AccountDto?> findById(String id);
  Future<AccountDto?> findByDescription(String description);
  Future<List<AccountDto>> findAll();
  Future<void> remove(String id);
}
