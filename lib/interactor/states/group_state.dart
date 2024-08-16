import 'package:my_finan/interactor/entities/group_entity.dart';
import 'package:my_finan/interactor/errors/failure_group.dart';

abstract class GroupState {}

class GroupLoadingState extends GroupState {}

class GroupStartState extends GroupState {}

class GroupSuccessfulState extends GroupState {
  final List<GroupEntity> groups;

  GroupSuccessfulState(this.groups);
}

class GroupErrorState extends GroupState {
  final FailureGroup failureGroup;

  GroupErrorState(this.failureGroup);
}
