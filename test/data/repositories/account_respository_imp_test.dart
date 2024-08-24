import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finan/data/dtos/account_dto.dart';
import 'package:my_finan/data/errors/account_data_source_erros.dart';
import 'package:my_finan/data/repositories/account_repository_imp.dart';
import 'package:my_finan/data/sources/account_data_source.dart';
import 'package:my_finan/interactor/states/account_state.dart';

class AccountDataSourceMock extends Mock implements AccountDataSource {}

void main() {
  group('Repository Group', () {
    late AccountDataSourceMock accountDataSource;
    late AccountRepositoryImp repository;
    final resultAccount = [
      AccountDto(
          id: '1',
          description: 'description',
          iconCode: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now())
    ];

    setUpAll(() {
      registerFallbackValue('');
    });
    setUp(() {
      accountDataSource = AccountDataSourceMock();
      repository = AccountRepositoryImp(accountDataSource);
    });
    group('account repository', () {
      group('find all account repository', () {
        test('should return all accounts', () async {
          when(() => accountDataSource.findAll())
              .thenAnswer((_) async => resultAccount);
          final result = await repository.findAll();

          expect(result, isA<AccountSuccessfulState>());
          expect(
              (result as AccountSuccessfulState).accounts[0], resultAccount[0]);
        });
      });
      group('find by ID account repository', () {
        test('should return a account by id', () async {
          when(() => accountDataSource.findById(any()))
              .thenAnswer((_) async => resultAccount[0]);
          final result = await repository.findById('1');

          expect(result, isA<AccountSuccessfulState>());
          expect(
              (result as AccountSuccessfulState).accounts[0], resultAccount[0]);
        });
        test('should return NoElementDataSourceError', () async {
          when(() => accountDataSource.findById(any()))
              .thenAnswer((_) async => null);
          final result = await repository.findById('1');

          expect(result, isA<AccountErrorState>());
          expect((result as AccountErrorState).failure,
              isA<NoElementDataSourceError>());
        });

        test('should return DataSourceException', () async {
          when(() => accountDataSource.findById(any())).thenThrow(Exception());
          final result = await repository.findById('1');

          expect(result, isA<AccountErrorState>());
          expect((result as AccountErrorState).failure,
              isA<DataSourceException>());
        });
      });

      group('find by description account repository', () {
        test('should return a account by description', () async {
          when(() => accountDataSource.findByDescription(any()))
              .thenAnswer((_) async => resultAccount[0]);
          final result = await repository.findByDescription('description');

          expect(result, isA<AccountSuccessfulState>());
          expect(
              (result as AccountSuccessfulState).accounts[0], resultAccount[0]);
        });

        test('should return NoElementDataSourceError', () async {
          when(() => accountDataSource.findByDescription(any()))
              .thenAnswer((_) async => null);
          final result = await repository.findByDescription('description');

          expect(result, isA<AccountErrorState>());
          expect((result as AccountErrorState).failure,
              isA<NoElementDataSourceError>());
        });

        test('should return DataSourceException', () async {
          when(() => accountDataSource.findByDescription(any()))
              .thenAnswer((_) async => null);
          final result = await repository.findByDescription('description');

          expect(result, isA<AccountErrorState>());
          expect((result as AccountErrorState).failure,
              isA<NoElementDataSourceError>());
        });
      });
      group('save account repository', () {
        test('should return a new account', () async {
          when(() => accountDataSource.save(resultAccount[0]))
              .thenAnswer((_) async => resultAccount[0]);
          final result = await repository.save(resultAccount[0]);

          expect(result, isA<AccountSuccessfulState>());
          expect(
              (result as AccountSuccessfulState).accounts[0], resultAccount[0]);
        });

        test('should return DataSourceException', () async {
          when(() => accountDataSource.save(resultAccount[0]))
              .thenThrow(Exception());
          final result = await repository.save(resultAccount[0]);

          expect(result, isA<AccountErrorState>());
          expect((result as AccountErrorState).failure,
              isA<DataSourceException>());
        });
      });
      group('update account repository', () {
        test('should return updated account', () async {
          when(() => accountDataSource.update(resultAccount[0]))
              .thenAnswer((_) async => resultAccount[0]);
          final result = await repository.update(resultAccount[0]);

          expect(result, isA<AccountSuccessfulState>());
          expect(
              (result as AccountSuccessfulState).accounts[0], resultAccount[0]);
        });
        test('should return DataSourceException', () async {
          when(() => accountDataSource.update(resultAccount[0]))
              .thenThrow(Exception());
          final result = await repository.update(resultAccount[0]);

          expect(result, isA<AccountErrorState>());
          expect((result as AccountErrorState).failure,
              isA<DataSourceException>());
        });
      });
      group('remove account repository', () {
        test('should return removed account', () async {
          when(() => accountDataSource.findById(resultAccount[0].id))
              .thenAnswer((_) async => resultAccount[0]);
          when(() => accountDataSource.remove(resultAccount[0].id))
              .thenAnswer((_) async => resultAccount[0]);
          final result = await repository.remove(resultAccount[0].id);

          expect(result, isA<AccountSuccessfulState>());
          expect(
              (result as AccountSuccessfulState).accounts[0], resultAccount[0]);
        });
        test(
            'should return NoElementDataSourceError if account id is not found',
            () async {
          when(() => accountDataSource.findById(resultAccount[0].id))
              .thenAnswer((_) async => null);
          when(() => accountDataSource.remove(resultAccount[0].id))
              .thenAnswer((_) async => null);
          final result = await repository.remove(resultAccount[0].id);

          expect(result, isA<AccountErrorState>());
          expect((result as AccountErrorState).failure,
              isA<NoElementDataSourceError>());
        });
        test('should return DataSourceException', () async {
          when(() => accountDataSource.findById(resultAccount[0].id))
              .thenThrow(Exception());
          when(() => accountDataSource.remove(resultAccount[0].id))
              .thenThrow(Exception());
          final result = await repository.remove(resultAccount[0].id);

          expect(result, isA<AccountErrorState>());
          expect((result as AccountErrorState).failure,
              isA<DataSourceException>());
        });
      });
    });
  });
}
