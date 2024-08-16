import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finan/data/dtos/group_dto.dart';
import 'package:my_finan/data/errors/group_data_source_erros.dart';
import 'package:my_finan/data/repositories/group_repository_imp.dart';
import 'package:my_finan/data/sources/group_data_source.dart';
import 'package:my_finan/interactor/entities/type_method.dart';
import 'package:my_finan/interactor/entities/type_operation.dart';
import 'package:my_finan/interactor/states/group_state.dart';

class GroupDataSourceMock extends Mock implements GroupDataSource {}

void main() {
  group('Repository Group', () {
    late GroupDataSourceMock groupDataSource;
    late GroupRepositoryImp repository;
    final resultGroup = [
      GroupDto(
          id: '1',
          description: 'description',
          typeOperation: TypeOperation.income,
          typeMethod: TypeMethod.essential,
          iconCode: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now())
    ];

    setUpAll(() {
      registerFallbackValue('');
    });
    setUp(() {
      groupDataSource = GroupDataSourceMock();
      repository = GroupRepositoryImp(groupDataSource);
    });
    group('group repository', () {
      group('find all group repository', () {
        test('should return all groups', () async {
          when(() => groupDataSource.findAll())
              .thenAnswer((_) async => resultGroup);
          final result = await repository.findAll();

          expect(result, isA<GroupSuccessfulState>());
          expect((result as GroupSuccessfulState).groups[0], resultGroup[0]);
        });
      });
      group('find by ID group repository', () {
        test('should return a group by id', () async {
          when(() => groupDataSource.findById(any()))
              .thenAnswer((_) async => resultGroup[0]);
          final result = await repository.findById('1');

          expect(result, isA<GroupSuccessfulState>());
          expect((result as GroupSuccessfulState).groups[0], resultGroup[0]);
        });
        test('should return NoElementDataSourceError', () async {
          when(() => groupDataSource.findById(any()))
              .thenAnswer((_) async => null);
          final result = await repository.findById('1');

          expect(result, isA<GroupErrorState>());
          expect((result as GroupErrorState).failureGroup,
              isA<NoElementDataSourceError>());
        });

        test('should return DataSourceException', () async {
          when(() => groupDataSource.findById(any())).thenThrow(Exception());
          final result = await repository.findById('1');

          expect(result, isA<GroupErrorState>());
          expect((result as GroupErrorState).failureGroup,
              isA<DataSourceException>());
        });
      });

      group('find by description group repository', () {
        test('should return a group by description', () async {
          when(() => groupDataSource.findByDescription(any()))
              .thenAnswer((_) async => resultGroup[0]);
          final result = await repository.findByDescription('description');

          expect(result, isA<GroupSuccessfulState>());
          expect((result as GroupSuccessfulState).groups[0], resultGroup[0]);
        });

        test('should return NoElementDataSourceError', () async {
          when(() => groupDataSource.findByDescription(any()))
              .thenAnswer((_) async => null);
          final result = await repository.findByDescription('description');

          expect(result, isA<GroupErrorState>());
          expect((result as GroupErrorState).failureGroup,
              isA<NoElementDataSourceError>());
        });

        test('should return DataSourceException', () async {
          when(() => groupDataSource.findByDescription(any()))
              .thenAnswer((_) async => null);
          final result = await repository.findByDescription('description');

          expect(result, isA<GroupErrorState>());
          expect((result as GroupErrorState).failureGroup,
              isA<NoElementDataSourceError>());
        });
      });
      group('save group repository', () {
        test('should return a new group', () async {
          when(() => groupDataSource.save(resultGroup[0]))
              .thenAnswer((_) async => resultGroup[0]);
          final result = await repository.save(resultGroup[0]);

          expect(result, isA<GroupSuccessfulState>());
          expect((result as GroupSuccessfulState).groups[0], resultGroup[0]);
        });

        test('should return DataSourceException', () async {
          when(() => groupDataSource.save(resultGroup[0]))
              .thenThrow(Exception());
          final result = await repository.save(resultGroup[0]);

          expect(result, isA<GroupErrorState>());
          expect((result as GroupErrorState).failureGroup,
              isA<DataSourceException>());
        });
      });
      group('update group repository', () {
        test('should return updated group', () async {
          when(() => groupDataSource.update(resultGroup[0]))
              .thenAnswer((_) async => resultGroup[0]);
          final result = await repository.update(resultGroup[0]);

          expect(result, isA<GroupSuccessfulState>());
          expect((result as GroupSuccessfulState).groups[0], resultGroup[0]);
        });
        test('should return DataSourceException', () async {
          when(() => groupDataSource.update(resultGroup[0]))
              .thenThrow(Exception());
          final result = await repository.update(resultGroup[0]);

          expect(result, isA<GroupErrorState>());
          expect((result as GroupErrorState).failureGroup,
              isA<DataSourceException>());
        });
      });
      group('remove group repository', () {
        test('should return removed group', () async {
          when(() => groupDataSource.findById(resultGroup[0].id))
              .thenAnswer((_) async => resultGroup[0]);
          when(() => groupDataSource.remove(resultGroup[0].id))
              .thenAnswer((_) async => resultGroup[0]);
          final result = await repository.remove(resultGroup[0].id);

          expect(result, isA<GroupSuccessfulState>());
          expect((result as GroupSuccessfulState).groups[0], resultGroup[0]);
        });
        test('should return NoElementDataSourceError if group id is not found',
            () async {
          when(() => groupDataSource.findById(resultGroup[0].id))
              .thenAnswer((_) async => null);
          when(() => groupDataSource.remove(resultGroup[0].id))
              .thenAnswer((_) async => null);
          final result = await repository.remove(resultGroup[0].id);

          expect(result, isA<GroupErrorState>());
          expect((result as GroupErrorState).failureGroup,
              isA<NoElementDataSourceError>());
        });
        test('should return DataSourceException', () async {
          when(() => groupDataSource.findById(resultGroup[0].id))
              .thenThrow(Exception());
          when(() => groupDataSource.remove(resultGroup[0].id))
              .thenThrow(Exception());
          final result = await repository.remove(resultGroup[0].id);

          expect(result, isA<GroupErrorState>());
          expect((result as GroupErrorState).failureGroup,
              isA<DataSourceException>());
        });
      });
    });
  });
}
