import 'package:flutter/foundation.dart';
import 'package:my_finan/interactor/entities/group_entity.dart';
import 'package:my_finan/interactor/entities/type_method.dart';
import 'package:my_finan/interactor/entities/type_operation.dart';
import 'package:my_finan/interactor/errors/failure_group.dart';
import 'package:my_finan/interactor/repositories/group_respository.dart';
import 'package:my_finan/interactor/states/group_state.dart';

class GroupController {
  var state = ValueNotifier<GroupState>(GroupStartState());
  final GroupRepository _repository;

  GroupController(this._repository);

  getGroupById(String id) async {
    state.value = GroupLoadingState();

    if (id.isEmpty) {
      state.value = GroupErrorState(InvalidIdError('Invalid id'));
      return;
    }
    try {
      final result = await _repository.findById(id);
      state.value = result;
    } catch (e) {
      state.value = GroupErrorState(GenericError(e.toString()));
    }
  }

  getGroupByDescription(String description) async {
    state.value = GroupLoadingState();
    if (description.isEmpty) {
      state.value = GroupErrorState(InvalidIdError('Invalid description'));
      return;
    }
    try {
      final result = await _repository.findByDescription(description);
      state.value = result;
    } catch (e) {
      state.value = GroupErrorState(GenericError(e.toString()));
    }
  }

  getGroups() async {
    state.value = GroupLoadingState();
    try {
      final result = await _repository.findAll();
      state.value = result;
    } catch (e) {
      state.value = GroupErrorState(GenericError(e.toString()));
    }
  }

  removeGroup(String id) async {
    state.value = GroupLoadingState();
    try {
      await _repository.remove(id);
      await getGroups();
    } catch (e) {
      state.value = GroupErrorState(GenericError(e.toString()));
    }
  }

  saveGroup(InputNewGroup input) async {
    state.value = GroupLoadingState();
    final group = GroupEntity.newGroup(
        description: input.description,
        typeOperation: input.typeOperation,
        typeMethod: input.typeMethod,
        iconCode: input.iconCode);

    try {
      await _repository.save(group);
      await getGroups();
    } catch (e) {
      state.value = GroupErrorState(GenericError(e.toString()));
    }
  }

  updateGroup(InputUpdateGroup input) async {
    state.value = GroupLoadingState();
    final group = GroupEntity.updateGroup(
        id: input.id,
        description: input.description,
        typeOperation: input.typeOperation,
        typeMethod: input.typeMethod,
        iconCode: input.iconCode,
        createdAt: input.createdAt);

    try {
      await _repository.update(group);
      await getGroups();
    } catch (e) {
      state.value = GroupErrorState(GenericError(e.toString()));
    }
  }
}

class InputNewGroup {
  final String description;
  final TypeOperation typeOperation;
  final TypeMethod typeMethod;
  final int? iconCode;

  InputNewGroup(
      {required this.description,
      required this.typeOperation,
      required this.typeMethod,
      required this.iconCode});
}

class InputUpdateGroup {
  final String id;
  final String description;
  final TypeOperation typeOperation;
  final TypeMethod typeMethod;
  final int? iconCode;
  final DateTime createdAt;

  InputUpdateGroup({
    required this.id,
    required this.description,
    required this.typeOperation,
    required this.typeMethod,
    required this.iconCode,
    required this.createdAt,
  });
}
