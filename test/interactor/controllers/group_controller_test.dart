import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finan/data/dtos/group_dto.dart';
import 'package:my_finan/interactor/controllers/group_controller.dart';
import 'package:my_finan/interactor/entities/group_entity.dart';
import 'package:my_finan/interactor/entities/type_method.dart';
import 'package:my_finan/interactor/entities/type_operation.dart';
import 'package:my_finan/interactor/errors/failure_group.dart';
import 'package:my_finan/interactor/repositories/group_respository.dart';
import 'package:my_finan/interactor/states/group_state.dart';

class GroupRepositoryMock extends Mock implements GroupRepository {}

main() {
  late GroupRepositoryMock repository;
  late GroupController controller;
  final groupEntity = GroupEntity(
    id: '1',
    description: 'description',
    typeOperation: TypeOperation.income,
    typeMethod: TypeMethod.essential,
    iconCode: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  final newGroup = InputNewGroup(
    description: 'description',
    typeOperation: TypeOperation.income,
    typeMethod: TypeMethod.essential,
    iconCode: null,
  );
  final updateGroup = InputUpdateGroup(
    id: '1',
    description: 'description edited',
    typeOperation: TypeOperation.income,
    typeMethod: TypeMethod.essential,
    iconCode: null,
    createdAt: DateTime.now(),
  );
  final resultGroup = [
    GroupDto(
        id: '1',
        description: 'description',
        typeOperation: TypeOperation.income,
        typeMethod: TypeMethod.essential,
        iconCode: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()),
    GroupDto(
        id: '2',
        description: 'description 2',
        typeOperation: TypeOperation.income,
        typeMethod: TypeMethod.essential,
        iconCode: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now())
  ];
  setUpAll(() {
    registerFallbackValue(groupEntity);
  });
  setUp(() {
    repository = GroupRepositoryMock();
    controller = GroupController(repository);
  });

  group('GroupModel', () {
    group('getGroupById', () {
      test('should return GroupSuccessfulState with id 1', () async {
        when(() => repository.findById(any()))
            .thenAnswer((_) async => GroupSuccessfulState(resultGroup));

        await controller.getGroupById('1');

        final state = controller.state.value;

        expect(state, isA<GroupSuccessfulState>());
        expect((state as GroupSuccessfulState).groups[0].id, '1');
      });
      test('should return GroupErrorState when id empty', () async {
        when(() => repository.findById(any()))
            .thenAnswer((_) async => GroupErrorState(InvalidIdError('')));
        await controller.getGroupById('');
        expect(controller.state.value, isA<GroupErrorState>());

        final state = controller.state.value as GroupErrorState;
        expect(state.failureGroup.message, 'Invalid id');
      });

      test('should return GroupErrorState when id not exist', () async {
        when(() => repository.findById(any())).thenAnswer(
            (_) async => GroupErrorState(InvalidIdError('No data found')));
        await controller.getGroupById('100');
        expect(controller.state.value, isA<GroupErrorState>());

        final state = controller.state.value as GroupErrorState;
        expect(state.failureGroup.message, 'No data found');
      });

      test('should return all groups', () async {});
    });

    group('getGroupByDescription', () {
      test('should return GroupSuccessfulState with description description',
          () async {
        when(() => repository.findByDescription(any()))
            .thenAnswer((_) async => GroupSuccessfulState(resultGroup));
        await controller.getGroupByDescription('description');
        final state = controller.state.value;
        expect(state, isA<GroupSuccessfulState>());
        expect((state as GroupSuccessfulState).groups[0].description,
            'description');
      });

      test('should return GroupErrorState when description empty', () async {
        when(() => repository.findByDescription(any()))
            .thenAnswer((_) async => GroupErrorState(InvalidIdError('')));
        await controller.getGroupByDescription('');
        expect(controller.state.value, isA<GroupErrorState>());

        final state = controller.state.value as GroupErrorState;
        expect(state.failureGroup.message, 'Invalid description');
      });
      test('should return GroupErrorState when description not exist',
          () async {
        when(() => repository.findByDescription(any())).thenAnswer(
            (_) async => GroupErrorState(InvalidIdError('No data found')));
        await controller.getGroupByDescription('100');
        expect(controller.state.value, isA<GroupErrorState>());

        final state = controller.state.value as GroupErrorState;
        expect(state.failureGroup.message, 'No data found');
      });
    });
    group('getGroupAll', () {
      test('should return all groups', () async {
        when(() => repository.findAll())
            .thenAnswer((_) async => GroupSuccessfulState(resultGroup));
        await controller.getGroups();
        final state = controller.state.value;
        expect(state, isA<GroupSuccessfulState>());
        expect((state as GroupSuccessfulState).groups[0].description,
            'description');
      });

      test('should return GroupErrorState', () async {
        when(() => repository.findAll())
            .thenAnswer((_) async => GroupErrorState(InvalidIdError('')));
        await controller.getGroups();
        expect(controller.state.value, isA<GroupErrorState>());
      });
    });

    group('remove', () {
      test('should return GroupSuccessfulState', () async {
        when(() => repository.remove(any()))
            .thenAnswer((_) async => GroupSuccessfulState(resultGroup));
        await controller.removeGroup('1');
        final state = controller.state.value;
        expect(state, isA<GroupSuccessfulState>());
        expect((state as GroupSuccessfulState).groups[0].description,
            'description');
      });

      test('should return GroupErrorState', () async {
        when(() => repository.remove(any()))
            .thenAnswer((_) async => GroupErrorState(InvalidIdError('')));
        await controller.removeGroup('1');
        expect(controller.state.value, isA<GroupErrorState>());
      });
    });
    group('save group', () {
      test('should return GroupSuccessfulState', () async {
        when(() => repository.save(any()))
            .thenAnswer((_) async => GroupSuccessfulState([resultGroup[0]]));
        when(() => repository.findAll())
            .thenAnswer((_) async => GroupSuccessfulState(resultGroup));
        await controller.saveGroup(newGroup);
        final state = controller.state.value;

        expect(state, isA<GroupSuccessfulState>());
        expect(
            (state as GroupSuccessfulState).groups.length, resultGroup.length);
      });
      test('should return GroupErrorState', () async {
        when(() => repository.save(resultGroup[0]))
            .thenAnswer((_) async => GroupErrorState(InvalidIdError('')));
        await controller.saveGroup(newGroup);
        expect(controller.state.value, isA<GroupErrorState>());
      });
    });
    group('update group', () {
      test('should return GroupSuccessfulState', () async {
        when(() => repository.update(any()))
            .thenAnswer((_) async => GroupSuccessfulState(resultGroup));
        when(() => repository.findAll())
            .thenAnswer((_) async => GroupSuccessfulState(resultGroup));
        await controller.updateGroup(updateGroup);
        final state = controller.state.value;
        expect(state, isA<GroupSuccessfulState>());
        expect(
            (state as GroupSuccessfulState).groups.length, resultGroup.length);
      });
      test('should return GroupErrorState', () async {
        when(() => repository.update(resultGroup[0]))
            .thenAnswer((_) async => GroupErrorState(InvalidIdError('')));
        await controller.updateGroup(updateGroup);
        expect(controller.state.value, isA<GroupErrorState>());
      });
    });
  });
}
