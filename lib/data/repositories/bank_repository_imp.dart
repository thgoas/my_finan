import 'package:my_finan/data/errors/bank_data_source_erros.dart';
import 'package:my_finan/data/sources/bank_data_source.dart';
import 'package:my_finan/interactor/entities/bank_entity.dart';
import 'package:my_finan/interactor/repositories/bank_repository.dart';
import 'package:my_finan/interactor/states/bank_state.dart';

class BankRepositoryImp implements BankRepository {
  final BankDataSource _bankDataSource;
  BankRepositoryImp(this._bankDataSource);
  @override
  Future<BankState> findAll() async {
    try {
      final result = await _bankDataSource.findAll();
      if (result.isEmpty) {
        return BankErrorState(NoElementDataSourceError('No data found'));
      }
      return BankSuccessfulState(result);
    } catch (e) {
      return BankErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<BankState> findByDescription(String description) async {
    try {
      final result = await _bankDataSource.findByDescription(description);

      if (result == null) {
        return BankErrorState(NoElementDataSourceError('No data found'));
      }

      return BankSuccessfulState([result]);
    } catch (e) {
      return BankErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<BankState> findById(String id) async {
    try {
      final result = await _bankDataSource.findById(id);

      if (result == null) {
        return BankErrorState(NoElementDataSourceError('No data found'));
      }

      return BankSuccessfulState([result]);
    } catch (e) {
      return BankErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<BankState> remove(String id) async {
    try {
      final group = await _bankDataSource.findById(id);

      if (group == null) {
        return BankErrorState(NoElementDataSourceError('No data found'));
      }
      await _bankDataSource.remove(id);

      return BankSuccessfulState([group]);
    } catch (e) {
      return BankErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<BankState> save(BankEntity bankEntity) async {
    try {
      final result = await _bankDataSource.save(bankEntity);

      return BankSuccessfulState([result]);
    } catch (e) {
      return BankErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<BankState> update(BankEntity bankEntity) async {
    try {
      final result = await _bankDataSource.update(bankEntity);
      if (result == null) {
        return BankErrorState(NoElementDataSourceError('No data found'));
      }
      return BankSuccessfulState([result]);
    } catch (e) {
      return BankErrorState(DataSourceException(e.toString()));
    }
  }
}
