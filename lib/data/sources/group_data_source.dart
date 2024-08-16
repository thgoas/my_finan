import 'package:my_finan/data/dtos/group_dto.dart';
import 'package:my_finan/interactor/entities/group_entity.dart';

abstract class GroupDataSource {
  Future<GroupDto> save(GroupEntity groupEntity);
  Future<GroupDto?> update(GroupEntity groupEntity);
  Future<GroupDto?> findById(String id);
  Future<GroupDto?> findByDescription(String description);
  Future<List<GroupDto>> findAll();
  Future<void> remove(String id);
}
