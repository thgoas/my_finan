import 'package:my_finan/data/errors/group_data_source_erros.dart';
import 'package:my_finan/data/sources/group_data_source.dart';
import 'package:my_finan/interactor/entities/group_entity.dart';
import 'package:my_finan/interactor/repositories/group_respository.dart';
import 'package:my_finan/interactor/states/group_state.dart';

class GroupRepositoryImp implements GroupRepository {
  final GroupDataSource _groupDataSource;
  GroupRepositoryImp(this._groupDataSource);
  @override
  Future<GroupState> findAll() async {
    try {
      final result = await _groupDataSource.findAll();
      if (result.isEmpty) {
        return GroupErrorState(NoElementDataSourceError('No data found'));
      }
      return GroupSuccessfulState(result);
    } catch (e) {
      return GroupErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<GroupState> findByDescription(String description) async {
    try {
      final result = await _groupDataSource.findByDescription(description);

      if (result == null) {
        return GroupErrorState(NoElementDataSourceError('No data found'));
      }

      return GroupSuccessfulState([result]);
    } catch (e) {
      return GroupErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<GroupState> findById(String id) async {
    try {
      final result = await _groupDataSource.findById(id);

      if (result == null) {
        return GroupErrorState(NoElementDataSourceError('No data found'));
      }

      return GroupSuccessfulState([result]);
    } catch (e) {
      return GroupErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<GroupState> remove(String id) async {
    try {
      final group = await _groupDataSource.findById(id);

      if (group == null) {
        return GroupErrorState(NoElementDataSourceError('No data found'));
      }
      await _groupDataSource.remove(id);

      return GroupSuccessfulState([group]);
    } catch (e) {
      return GroupErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<GroupState> save(GroupEntity groupEntity) async {
    try {
      final result = await _groupDataSource.save(groupEntity);

      return GroupSuccessfulState([result]);
    } catch (e) {
      return GroupErrorState(DataSourceException(e.toString()));
    }
  }

  @override
  Future<GroupState> update(GroupEntity groupEntity) async {
    try {
      final result = await _groupDataSource.update(groupEntity);
      if (result == null) {
        return GroupErrorState(NoElementDataSourceError('No data found'));
      }
      return GroupSuccessfulState([result]);
    } catch (e) {
      return GroupErrorState(DataSourceException(e.toString()));
    }
  }
}
