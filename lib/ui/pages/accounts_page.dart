import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:my_finan/interactor/entities/account_entity.dart';
import 'package:my_finan/interactor/controllers/account_controller.dart';
import 'package:my_finan/interactor/states/account_state.dart';
import 'package:my_finan/shared/models/show_dialog.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  late final AccountController _controller;

  @override
  void initState() {
    _controller = GetIt.instance.get<AccountController>();
    _controller.getAccounts();
    super.initState();
  }

  Future<bool> _removeAccount(AccountEntity account) async {
    final result = await ShowDialog.confirmationAlertDialog('Excluir Conta',
        'Deseja realmente excluir a conta ${account.description}?', context);
    result ? await _controller.removeAccount(account.id) : null;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await context.push('/more/accounts/form/Nova', extra: null);

          if (result == true) _controller.getAccounts();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(children: [
        Expanded(
          child: ValueListenableBuilder<AccountState>(
            valueListenable: _controller.state,
            builder: (context, state, _) {
              switch (state.runtimeType) {
                case const (AccountStartState):
                  return const Center(
                    child: Center(
                      child: Text('Sem dados'),
                    ),
                  );
                case const (AccountLoadingState):
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case const (AccountSuccessfulState):
                  final successFulState = state as AccountSuccessfulState;
                  return Center(
                    child: ListView.builder(
                        itemCount: successFulState.accounts.length,
                        itemBuilder: (context, index) {
                          final account = successFulState.accounts[index];
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
                              key: ValueKey(account.id),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                return await _removeAccount(account);
                              },
                              child: ListTile(
                                leading: account.iconCode != null
                                    ? Icon(
                                        IconData(account.iconCode!,
                                            fontFamily: 'MaterialIcons'),
                                        size: 40,
                                      )
                                    : const Icon(
                                        Icons.account_balance,
                                        size: 40,
                                      ),
                                title: Text(account.description),
                                onTap: () async {
                                  final result = await context.push(
                                      '/more/accounts/form/Editar',
                                      extra: successFulState.accounts[index]);

                                  if (result == true) _controller.getAccounts();
                                },
                              ),
                            ),
                          );
                        }),
                  );
                case const (AccountErrorState):
                  final errorState = state as AccountErrorState;
                  return Center(
                    child: Text(errorState.failure.message),
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
