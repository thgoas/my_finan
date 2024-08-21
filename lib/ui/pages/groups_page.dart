import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:go_router/go_router.dart';
import 'package:my_finan/interactor/controllers/group_controller.dart';
import 'package:my_finan/interactor/entities/group_entity.dart';
import 'package:my_finan/interactor/states/group_state.dart';
import 'package:my_finan/shared/models/show_dialog.dart';
import 'package:my_finan/shared/models/type_operation_model.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  late final GroupController _controller;
  @override
  void initState() {
    super.initState();
    _controller = GetIt.instance.get<GroupController>();
    _controller.getGroups();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _removeGroup(GroupEntity group) async {
    final result = await ShowDialog.confirmationAlertDialog('Excluir Grupo',
        'Deseja realmente excluir o grupo ${group.description}?', context);
    result ? await _controller.removeGroup(group.id) : null;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final typeOperationModel = TypeOperationModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await context.push('/more/groups/form/Novo', extra: null);

          if (result == true) await _controller.getGroups();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(children: [
        Expanded(
          child: ValueListenableBuilder<GroupState>(
            valueListenable: _controller.state,
            builder: (context, state, _) {
              switch (state.runtimeType) {
                case const (GroupStartState):
                  return const Center(
                    child: Center(
                      child: Text('Sem dados'),
                    ),
                  );
                case const (GroupLoadingState):
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case const (GroupSuccessfulState):
                  final successFulState = state as GroupSuccessfulState;
                  return Center(
                    child: ListView.builder(
                      itemCount: successFulState.groups.length,
                      itemBuilder: (context, index) {
                        final resultTypeOperation =
                            typeOperationModel.typeOperationToMap(
                                successFulState.groups[index].typeOperation);
                        final group = successFulState.groups[index];
                        return Card(
                          child: Dismissible(
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            key: ValueKey(group.id),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              return await _removeGroup(group);
                            },
                            child: ListTile(
                              leading: group.iconCode != null
                                  ? Icon(
                                      IconData(group.iconCode!,
                                          fontFamily: 'MaterialIcons'),
                                      size: 40,
                                    )
                                  : const Icon(Icons.error, size: 40),
                              title: Text(group.description),
                              subtitle: Row(
                                children: [
                                  Icon(
                                    resultTypeOperation['icon'],
                                    color: resultTypeOperation['color'],
                                  ),
                                  Text(resultTypeOperation['name']),
                                ],
                              ),
                              onTap: () async {
                                final result = await context.push(
                                    '/more/groups/form/Editar',
                                    extra: successFulState.groups[index]);
                                if (result == true) _controller.getGroups();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                case const (GroupErrorState):
                  final errorState = state as GroupErrorState;
                  return Center(
                    child: Text(errorState.failureGroup.message),
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      ]),
    );
  }
}
