import 'package:my_finan/data/errors/account_data_source_erros.dart';
import 'package:my_finan/data/sources/account_data_source.dart';
import 'package:my_finan/interactor/entities/account_entity.dart';
import 'package:my_finan/interactor/repositories/account_repository.dart';
import 'package:my_finan/interactor/states/account_state.dart';

class AccountRepositoryImp implements AccountRepository {
  final AccountDataSource _groupDataSource;
  AccountRepositoryImp(this._groupDataSource);
  @override
  Future<AccountState> findAll() async {
    try {
      final result = await _groupDataSource.findAll();
      if (result.isEmpty) {
        return AccountErrorState(NoElementDataSourceError('No data found'));
      }
      return AccountSuccessfulState(result);
    } catch (e) {
      return AccountErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<AccountState> findByDescription(String description) async {
    try {
      final result = await _groupDataSource.findByDescription(description);

      if (result == null) {
        return AccountErrorState(NoElementDataSourceError('No data found'));
      }

      return AccountSuccessfulState([result]);
    } catch (e) {
      return AccountErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<AccountState> findById(String id) async {
    try {
      final result = await _groupDataSource.findById(id);

      if (result == null) {
        return AccountErrorState(NoElementDataSourceError('No data found'));
      }

      return AccountSuccessfulState([result]);
    } catch (e) {
      return AccountErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<AccountState> remove(String id) async {
    try {
      final group = await _groupDataSource.findById(id);

      if (group == null) {
        return AccountErrorState(NoElementDataSourceError('No data found'));
      }
      await _groupDataSource.remove(id);

      return AccountSuccessfulState([group]);
    } catch (e) {
      return AccountErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<AccountState> save(AccountEntity accountEntity) async {
    try {
      final result = await _groupDataSource.save(accountEntity);

      return AccountSuccessfulState([result]);
    } catch (e) {
      return AccountErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<AccountState> update(AccountEntity accountEntity) async {
    try {
      final result = await _groupDataSource.update(accountEntity);
      if (result == null) {
        return AccountErrorState(NoElementDataSourceError('No data found'));
      }
      return AccountSuccessfulState([result]);
    } catch (e) {
      return AccountErrorState(DataSourceException(e.toString()));
    }
  }
}
