import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finan/data/dtos/bank_dto.dart';
import 'package:my_finan/data/errors/bank_data_source_erros.dart';
import 'package:my_finan/data/repositories/bank_repository_imp.dart';
import 'package:my_finan/data/sources/bank_data_source.dart';
import 'package:my_finan/interactor/states/bank_state.dart';

class BankDataSourceMock extends Mock implements BankDataSource {}

void main() {
  group('Repository Bank', () {
    late BankDataSourceMock dataSource;
    late BankRepositoryImp repository;
    final resultList = [
      BankDto(
          id: '1',
          description: 'description',
          path: 'path',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now())
    ];

    setUpAll(() {
      registerFallbackValue('');
    });
    setUp(() {
      dataSource = BankDataSourceMock();
      repository = BankRepositoryImp(dataSource);
    });
    group('bank repository', () {
      group('find all bank repository', () {
        test('should return all banks', () async {
          when(() => dataSource.findAll()).thenAnswer((_) async => resultList);
          final result = await repository.findAll();

          expect(result, isA<BankSuccessfulState>());
          expect((result as BankSuccessfulState).banks[0], resultList[0]);
        });
      });
      group('find by ID bank repository', () {
        test('should return a bank by id', () async {
          when(() => dataSource.findById(any()))
              .thenAnswer((_) async => resultList[0]);
          final result = await repository.findById('1');

          expect(result, isA<BankSuccessfulState>());
          expect((result as BankSuccessfulState).banks[0], resultList[0]);
        });
        test('should return NoElementDataSourceError', () async {
          when(() => dataSource.findById(any())).thenAnswer((_) async => null);
          final result = await repository.findById('1');

          expect(result, isA<BankErrorState>());
          expect((result as BankErrorState).failure,
              isA<NoElementDataSourceError>());
        });

        test('should return DataSourceException', () async {
          when(() => dataSource.findById(any())).thenThrow(Exception());
          final result = await repository.findById('1');

          expect(result, isA<BankErrorState>());
          expect(
              (result as BankErrorState).failure, isA<DataSourceException>());
        });
      });

      group('find by description bank repository', () {
        test('should return a bank by description', () async {
          when(() => dataSource.findByDescription(any()))
              .thenAnswer((_) async => resultList[0]);
          final result = await repository.findByDescription('description');

          expect(result, isA<BankSuccessfulState>());
          expect((result as BankSuccessfulState).banks[0], resultList[0]);
        });

        test('should return NoElementDataSourceError', () async {
          when(() => dataSource.findByDescription(any()))
              .thenAnswer((_) async => null);
          final result = await repository.findByDescription('description');

          expect(result, isA<BankErrorState>());
          expect((result as BankErrorState).failure,
              isA<NoElementDataSourceError>());
        });

        test('should return DataSourceException', () async {
          when(() => dataSource.findByDescription(any()))
              .thenAnswer((_) async => null);
          final result = await repository.findByDescription('description');

          expect(result, isA<BankErrorState>());
          expect((result as BankErrorState).failure,
              isA<NoElementDataSourceError>());
        });
      });
      group('save bank repository', () {
        test('should return a new account', () async {
          when(() => dataSource.save(resultList[0]))
              .thenAnswer((_) async => resultList[0]);
          final result = await repository.save(resultList[0]);

          expect(result, isA<BankSuccessfulState>());
          expect((result as BankSuccessfulState).banks[0], resultList[0]);
        });

        test('should return DataSourceException', () async {
          when(() => dataSource.save(resultList[0])).thenThrow(Exception());
          final result = await repository.save(resultList[0]);

          expect(result, isA<BankErrorState>());
          expect(
              (result as BankErrorState).failure, isA<DataSourceException>());
        });
      });
      group('update bank repository', () {
        test('should return updated bank', () async {
          when(() => dataSource.update(resultList[0]))
              .thenAnswer((_) async => resultList[0]);
          final result = await repository.update(resultList[0]);

          expect(result, isA<BankSuccessfulState>());
          expect((result as BankSuccessfulState).banks[0], resultList[0]);
        });
        test('should return DataSourceException', () async {
          when(() => dataSource.update(resultList[0])).thenThrow(Exception());
          final result = await repository.update(resultList[0]);

          expect(result, isA<BankErrorState>());
          expect(
              (result as BankErrorState).failure, isA<DataSourceException>());
        });
      });
      group('remove bank repository', () {
        test('should return removed bank', () async {
          when(() => dataSource.findById(resultList[0].id))
              .thenAnswer((_) async => resultList[0]);
          when(() => dataSource.remove(resultList[0].id))
              .thenAnswer((_) async => resultList[0]);
          final result = await repository.remove(resultList[0].id);

          expect(result, isA<BankSuccessfulState>());
          expect((result as BankSuccessfulState).banks[0], resultList[0]);
        });
        test('should return NoElementDataSourceError if bank id is not found',
            () async {
          when(() => dataSource.findById(resultList[0].id))
              .thenAnswer((_) async => null);
          when(() => dataSource.remove(resultList[0].id))
              .thenAnswer((_) async {});
          final result = await repository.remove(resultList[0].id);

          expect(result, isA<BankErrorState>());
          expect((result as BankErrorState).failure,
              isA<NoElementDataSourceError>());
        });
        test('should return DataSourceException', () async {
          when(() => dataSource.findById(resultList[0].id))
              .thenThrow(Exception());
          when(() => dataSource.remove(resultList[0].id))
              .thenThrow(Exception());
          final result = await repository.remove(resultList[0].id);

          expect(result, isA<BankErrorState>());
          expect(
              (result as BankErrorState).failure, isA<DataSourceException>());
        });
      });
    });
  });
}
