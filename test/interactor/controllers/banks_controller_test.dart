import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finan/interactor/controllers/bank_controller.dart';
import 'package:my_finan/interactor/entities/bank_entity.dart';
import 'package:my_finan/interactor/errors/failure_bank.dart';
import 'package:my_finan/interactor/repositories/bank_repository.dart';
import 'package:my_finan/interactor/states/bank_state.dart';

class BankRepositoryMock extends Mock implements BankRepository {}

main() {
  late BankRepositoryMock repository;
  late BankController controller;
  final newBanks = InputNewBank(
    description: 'description',
    path: 'path',
  );
  final updateBanks = InputUpdateBank(
    id: '1',
    description: 'description edited',
    path: 'path edited',
    createdAt: DateTime.now(),
  );
  final banks = [
    BankEntity(
      id: '1',
      description: 'description',
      path: 'path',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    BankEntity(
      id: '2',
      description: 'description 2',
      path: 'path 2',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  setUpAll(() {
    registerFallbackValue(banks[0]);
  });
  setUp(() {
    repository = BankRepositoryMock();
    controller = BankController(repository);
  });
  group('bank controller', () {
    test('should return banks', () async {
      when(() => repository.findAll())
          .thenAnswer((_) async => BankSuccessfulState(banks));
      await controller.getBanks();
      final state = controller.state.value;
      expect(state, isA<BankSuccessfulState>());
      expect((state as BankSuccessfulState).banks, banks);
    });

    test('should return bank by id', () async {
      when(() => repository.findById('1'))
          .thenAnswer((_) async => BankSuccessfulState([banks[0]]));
      await controller.getBankById('1');
      final state = controller.state.value;
      expect(state, isA<BankSuccessfulState>());
      expect((state as BankSuccessfulState).banks[0], banks[0]);
    });

    test('should return exception if id is invalid', () async {
      when(() => repository.findById('1'))
          .thenAnswer((_) async => BankErrorState(InvalidIdError('1')));
      await controller.getBankById('1');
      final state = controller.state.value;
      expect(state, isA<BankErrorState>());
      expect((state as BankErrorState).failure, isA<InvalidIdError>());
    });
    test('should return exception generic', () async {
      when(() => repository.findById('1'))
          .thenAnswer((_) async => BankErrorState(GenericError('1')));
      await controller.getBankById('1');
      final state = controller.state.value;
      expect(state, isA<BankErrorState>());
      expect((state as BankErrorState).failure, isA<GenericError>());
    });

    test('should return Banks by description', () async {
      when(() => repository.findByDescription('description'))
          .thenAnswer((_) async => BankSuccessfulState([banks[0]]));
      await controller.getBankByDescription('description');
      final state = controller.state.value;
      expect(state, isA<BankSuccessfulState>());
      expect((state as BankSuccessfulState).banks[0], banks[0]);
    });

    test('should return exception if description is invalid', () async {
      when(() => repository.findByDescription('description'))
          .thenAnswer((_) async => BankErrorState(InvalidIdError('1')));
      await controller.getBankByDescription('description');
      final state = controller.state.value;
      expect(state, isA<BankErrorState>());
      expect((state as BankErrorState).failure, isA<InvalidIdError>());
    });

    test('should return exception generic', () async {
      when(() => repository.findByDescription('description'))
          .thenAnswer((_) async => BankErrorState(GenericError('1')));
      await controller.getBankByDescription('description');
      final state = controller.state.value;
      expect(state, isA<BankErrorState>());
      expect((state as BankErrorState).failure, isA<GenericError>());
    });

    test('should return a new Bank', () async {
      when(() => repository.save(any()))
          .thenAnswer((_) async => BankSuccessfulState([banks[0]]));
      when(() => repository.findAll())
          .thenAnswer((_) async => BankSuccessfulState(banks));
      await controller.saveBank(newBanks);
      final state = controller.state.value;
      expect(state, isA<BankSuccessfulState>());
      expect((state as BankSuccessfulState).banks.length, banks.length);
    });
    test('shoud return generic exception', () async {
      when(() => repository.save(any()))
          .thenAnswer((_) async => BankErrorState(GenericError('1')));
      await controller.saveBank(newBanks);
      final state = controller.state.value;
      expect(state, isA<BankErrorState>());
      expect((state as BankErrorState).failure, isA<GenericError>());
    });

    test('should return update Bank', () async {
      when(() => repository.update(any()))
          .thenAnswer((_) async => BankSuccessfulState([banks[0]]));
      when(() => repository.findAll())
          .thenAnswer((_) async => BankSuccessfulState(banks));
      await controller.updateBank(updateBanks);
      final state = controller.state.value;
      expect(state, isA<BankSuccessfulState>());
      expect((state as BankSuccessfulState).banks.length, banks.length);
    });

    test('shoud return generic exception', () async {
      when(() => repository.update(any()))
          .thenAnswer((_) async => BankErrorState(GenericError('1')));
      await controller.updateBank(updateBanks);
      final state = controller.state.value;
      expect(state, isA<BankErrorState>());
      expect((state as BankErrorState).failure, isA<GenericError>());
    });

    test('should return remove Bank', () async {
      when(() => repository.remove('1'))
          .thenAnswer((_) async => BankSuccessfulState([banks[0]]));
      when(() => repository.findAll())
          .thenAnswer((_) async => BankSuccessfulState(banks));
      await controller.removeBank('1');
      final state = controller.state.value;
      expect(state, isA<BankSuccessfulState>());
      expect((state as BankSuccessfulState).banks.length, banks.length);
    });

    test('shoud return generic exception', () async {
      when(() => repository.remove('1'))
          .thenAnswer((_) async => BankErrorState(GenericError('1')));
      await controller.removeBank('1');
      final state = controller.state.value;
      expect(state, isA<BankErrorState>());
      expect((state as BankErrorState).failure, isA<GenericError>());
    });
  });
}
