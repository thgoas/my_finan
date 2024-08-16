import 'package:my_finan/interactor/entities/group_entity.dart';
import 'package:my_finan/interactor/states/group_state.dart';

abstract class GroupRepository {
  Future<GroupState> save(GroupEntity groupEntity);
  Future<GroupState> update(GroupEntity groupEntity);
  Future<GroupState> findById(String id);
  Future<GroupState> findByDescription(String description);
  Future<GroupState> findAll();
  Future<GroupState> remove(String id);
}
