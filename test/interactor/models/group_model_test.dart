import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finan/data/dtos/group_dto.dart';
import 'package:my_finan/interactor/entities/group_entity.dart';
import 'package:my_finan/interactor/entities/type_method.dart';
import 'package:my_finan/interactor/entities/type_operation.dart';
import 'package:my_finan/interactor/errors/failure_group.dart';
import 'package:my_finan/interactor/models/group_model.dart';
import 'package:my_finan/interactor/repositories/group_respository.dart';
import 'package:my_finan/interactor/states/group_state.dart';

class GroupRepositoryMock extends Mock implements GroupRepository {}

main() {
  late GroupRepositoryMock repository;
  late GroupModel groupModel;
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
    groupModel = GroupModel(repository);
  });

  group('GroupModel', () {
    group('getGroupById', () {
      test('should return GroupSuccessfulState with id 1', () async {
        when(() => repository.findById(any()))
            .thenAnswer((_) async => GroupSuccessfulState(resultGroup));

        await groupModel.getGroupById('1');

        final state = groupModel.state.value;

        expect(state, isA<GroupSuccessfulState>());
        expect((state as GroupSuccessfulState).groups[0].id, '1');
      });
      test('should return GroupErrorState when id empty', () async {
        when(() => repository.findById(any()))
            .thenAnswer((_) async => GroupErrorState(InvalidIdError('')));
        await groupModel.getGroupById('');
        expect(groupModel.state.value, isA<GroupErrorState>());

        final state = groupModel.state.value as GroupErrorState;
        expect(state.failureGroup.message, 'Invalid id');
      });

      test('should return GroupErrorState when id not exist', () async {
        when(() => repository.findById(any())).thenAnswer(
            (_) async => GroupErrorState(InvalidIdError('No data found')));
        await groupModel.getGroupById('100');
        expect(groupModel.state.value, isA<GroupErrorState>());

        final state = groupModel.state.value as GroupErrorState;
        expect(state.failureGroup.message, 'No data found');
      });

      test('should return all groups', () async {});
    });

    group('getGroupByDescription', () {
      test('should return GroupSuccessfulState with description description',
          () async {
        when(() => repository.findByDescription(any()))
            .thenAnswer((_) async => GroupSuccessfulState(resultGroup));
        await groupModel.getGroupByDescription('description');
        final state = groupModel.state.value;
        expect(state, isA<GroupSuccessfulState>());
        expect((state as GroupSuccessfulState).groups[0].description,
            'description');
      });

      test('should return GroupErrorState when description empty', () async {
        when(() => repository.findByDescription(any()))
            .thenAnswer((_) async => GroupErrorState(InvalidIdError('')));
        await groupModel.getGroupByDescription('');
        expect(groupModel.state.value, isA<GroupErrorState>());

        final state = groupModel.state.value as GroupErrorState;
        expect(state.failureGroup.message, 'Invalid description');
      });
      test('should return GroupErrorState when description not exist',
          () async {
        when(() => repository.findByDescription(any())).thenAnswer(
            (_) async => GroupErrorState(InvalidIdError('No data found')));
        await groupModel.getGroupByDescription('100');
        expect(groupModel.state.value, isA<GroupErrorState>());

        final state = groupModel.state.value as GroupErrorState;
        expect(state.failureGroup.message, 'No data found');
      });
    });
    group('getGroupAll', () {
      test('should return all groups', () async {
        when(() => repository.findAll())
            .thenAnswer((_) async => GroupSuccessfulState(resultGroup));
        await groupModel.getGroups();
        final state = groupModel.state.value;
        expect(state, isA<GroupSuccessfulState>());
        expect((state as GroupSuccessfulState).groups[0].description,
            'description');
      });

      test('should return GroupErrorState', () async {
        when(() => repository.findAll())
            .thenAnswer((_) async => GroupErrorState(InvalidIdError('')));
        await groupModel.getGroups();
        expect(groupModel.state.value, isA<GroupErrorState>());
      });
    });

    group('remove', () {
      test('should return GroupSuccessfulState', () async {
        when(() => repository.remove(any()))
            .thenAnswer((_) async => GroupSuccessfulState(resultGroup));
        await groupModel.removeGroup('1');
        final state = groupModel.state.value;
        expect(state, isA<GroupSuccessfulState>());
        expect((state as GroupSuccessfulState).groups[0].description,
            'description');
      });

      test('should return GroupErrorState', () async {
        when(() => repository.remove(any()))
            .thenAnswer((_) async => GroupErrorState(InvalidIdError('')));
        await groupModel.removeGroup('1');
        expect(groupModel.state.value, isA<GroupErrorState>());
      });
    });
    group('save group', () {
      test('should return GroupSuccessfulState', () async {
        when(() => repository.save(any()))
            .thenAnswer((_) async => GroupSuccessfulState([resultGroup[0]]));
        await groupModel.saveGroup(newGroup);
        final state = groupModel.state.value;

        expect(state, isA<GroupSuccessfulState>());
        expect((state as GroupSuccessfulState).groups[0].description,
            'description');
      });
      test('should return GroupErrorState', () async {
        when(() => repository.save(resultGroup[0]))
            .thenAnswer((_) async => GroupErrorState(InvalidIdError('')));
        await groupModel.saveGroup(newGroup);
        expect(groupModel.state.value, isA<GroupErrorState>());
      });
    });
    group('update group', () {
      test('should return GroupSuccessfulState', () async {
        when(() => repository.update(any()))
            .thenAnswer((_) async => GroupSuccessfulState(resultGroup));
        await groupModel.updateGroup(updateGroup);
        final state = groupModel.state.value;
        expect(state, isA<GroupSuccessfulState>());
        expect((state as GroupSuccessfulState).groups[0].description,
            'description');
      });
      test('should return GroupErrorState', () async {
        when(() => repository.update(resultGroup[0]))
            .thenAnswer((_) async => GroupErrorState(InvalidIdError('')));
        await groupModel.updateGroup(updateGroup);
        expect(groupModel.state.value, isA<GroupErrorState>());
      });
    });
  });
}
