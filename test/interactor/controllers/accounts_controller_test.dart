import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finan/interactor/controllers/account_controller.dart';
import 'package:my_finan/interactor/entities/account_entity.dart';
import 'package:my_finan/interactor/errors/failure_account.dart';
import 'package:my_finan/interactor/repositories/account_repository.dart';
import 'package:my_finan/interactor/states/account_state.dart';

class AccountRepositoryMock extends Mock implements AccountRepository {}

main() {
  late AccountRepositoryMock repository;
  late AccountController controller;
  final newAccount = InputNewAccount(
    description: 'description',
    iconCode: null,
  );
  final updateAccount = InputUpdateAccount(
    id: '1',
    description: 'description edited',
    iconCode: null,
    createdAt: DateTime.now(),
  );
  final accounts = [
    AccountEntity(
      id: '1',
      description: 'description',
      iconCode: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    AccountEntity(
      id: '2',
      description: 'description 2',
      iconCode: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  setUpAll(() {
    registerFallbackValue(accounts[0]);
  });
  setUp(() {
    repository = AccountRepositoryMock();
    controller = AccountController(repository);
  });
  group('ModelAccounts', () {
    test('should return model accounts', () async {
      when(() => repository.findAll())
          .thenAnswer((_) async => AccountSuccessfulState(accounts));
      await controller.getAccounts();
      final state = controller.state.value;
      expect(state, isA<AccountSuccessfulState>());
      expect((state as AccountSuccessfulState).accounts, accounts);
    });

    test('should return model account by id', () async {
      when(() => repository.findById('1'))
          .thenAnswer((_) async => AccountSuccessfulState([accounts[0]]));
      await controller.getAccountById('1');
      final state = controller.state.value;
      expect(state, isA<AccountSuccessfulState>());
      expect((state as AccountSuccessfulState).accounts[0], accounts[0]);
    });

    test('should return exception if id is invalid', () async {
      when(() => repository.findById('1'))
          .thenAnswer((_) async => AccountErrorState(InvalidIdError('1')));
      await controller.getAccountById('1');
      final state = controller.state.value;
      expect(state, isA<AccountErrorState>());
      expect((state as AccountErrorState).failure, isA<InvalidIdError>());
    });
    test('should return exception generic', () async {
      when(() => repository.findById('1'))
          .thenAnswer((_) async => AccountErrorState(GenericError('1')));
      await controller.getAccountById('1');
      final state = controller.state.value;
      expect(state, isA<AccountErrorState>());
      expect((state as AccountErrorState).failure, isA<GenericError>());
    });

    test('should return model account by description', () async {
      when(() => repository.findByDescription('description'))
          .thenAnswer((_) async => AccountSuccessfulState([accounts[0]]));
      await controller.getAccountByDescription('description');
      final state = controller.state.value;
      expect(state, isA<AccountSuccessfulState>());
      expect((state as AccountSuccessfulState).accounts[0], accounts[0]);
    });

    test('should return exception if description is invalid', () async {
      when(() => repository.findByDescription('description'))
          .thenAnswer((_) async => AccountErrorState(InvalidIdError('1')));
      await controller.getAccountByDescription('description');
      final state = controller.state.value;
      expect(state, isA<AccountErrorState>());
      expect((state as AccountErrorState).failure, isA<InvalidIdError>());
    });

    test('should return exception generic', () async {
      when(() => repository.findByDescription('description'))
          .thenAnswer((_) async => AccountErrorState(GenericError('1')));
      await controller.getAccountByDescription('description');
      final state = controller.state.value;
      expect(state, isA<AccountErrorState>());
      expect((state as AccountErrorState).failure, isA<GenericError>());
    });

    test('should return a new account', () async {
      when(() => repository.save(any()))
          .thenAnswer((_) async => AccountSuccessfulState([accounts[0]]));
      when(() => repository.findAll())
          .thenAnswer((_) async => AccountSuccessfulState(accounts));
      await controller.saveAccount(newAccount);
      final state = controller.state.value;
      expect(state, isA<AccountSuccessfulState>());
      expect(
          (state as AccountSuccessfulState).accounts.length, accounts.length);
    });
    test('shoud return generic exception', () async {
      when(() => repository.save(any()))
          .thenAnswer((_) async => AccountErrorState(GenericError('1')));
      await controller.saveAccount(newAccount);
      final state = controller.state.value;
      expect(state, isA<AccountErrorState>());
      expect((state as AccountErrorState).failure, isA<GenericError>());
    });

    test('should return update account', () async {
      when(() => repository.update(any()))
          .thenAnswer((_) async => AccountSuccessfulState([accounts[0]]));
      when(() => repository.findAll())
          .thenAnswer((_) async => AccountSuccessfulState(accounts));
      await controller.updateAccount(updateAccount);
      final state = controller.state.value;
      expect(state, isA<AccountSuccessfulState>());
      expect(
          (state as AccountSuccessfulState).accounts.length, accounts.length);
    });

    test('shoud return generic exception', () async {
      when(() => repository.update(any()))
          .thenAnswer((_) async => AccountErrorState(GenericError('1')));
      await controller.updateAccount(updateAccount);
      final state = controller.state.value;
      expect(state, isA<AccountErrorState>());
      expect((state as AccountErrorState).failure, isA<GenericError>());
    });

    test('should return remove account', () async {
      when(() => repository.remove('1'))
          .thenAnswer((_) async => AccountSuccessfulState([accounts[0]]));
      when(() => repository.findAll())
          .thenAnswer((_) async => AccountSuccessfulState(accounts));
      await controller.removeAccount('1');
      final state = controller.state.value;
      expect(state, isA<AccountSuccessfulState>());
      expect(
          (state as AccountSuccessfulState).accounts.length, accounts.length);
    });

    test('shoud return generic exception', () async {
      when(() => repository.remove('1'))
          .thenAnswer((_) async => AccountErrorState(GenericError('1')));
      await controller.removeAccount('1');
      final state = controller.state.value;
      expect(state, isA<AccountErrorState>());
      expect((state as AccountErrorState).failure, isA<GenericError>());
    });
  });
}
