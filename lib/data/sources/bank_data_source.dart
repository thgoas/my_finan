import 'package:my_finan/data/dtos/bank_dto.dart';
import 'package:my_finan/interactor/entities/bank_entity.dart';

abstract class BankDataSource {
  Future<BankDto> save(BankEntity bankEntity);
  Future<BankDto?> update(BankEntity bankEntity);
  Future<BankDto?> findById(String id);
  Future<BankDto?> findByDescription(String description);
  Future<List<BankDto>> findAll();
  Future<void> remove(String id);
}
