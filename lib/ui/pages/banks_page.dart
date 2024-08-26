import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:my_finan/interactor/controllers/bank_controller.dart';
import 'package:my_finan/interactor/entities/bank_entity.dart';
import 'package:my_finan/interactor/states/bank_state.dart';
import 'package:my_finan/shared/models/show_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BanksPage extends StatefulWidget {
  const BanksPage({super.key});

  @override
  State<BanksPage> createState() => _BanksPageState();
}

class _BanksPageState extends State<BanksPage> {
  late final BankController _controller;

  @override
  void initState() {
    _controller = GetIt.instance.get<BankController>();
    _controller.getBanks();
    super.initState();
  }

  Future<bool> _removeBank(BankEntity account) async {
    final result = await ShowDialog.confirmationAlertDialog('Excluir Conta',
        'Deseja realmente excluir a conta ${account.description}?', context);
    result ? await _controller.removeBank(account.id) : null;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bancos'),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final result =
      //         await context.push('/more/banks/form/Novo', extra: null);

      //     if (result == true) _controller.getBanks();
      //   },
      //   child: const Icon(Icons.add),
      // ),
      body: Column(children: [
        Expanded(
          child: ValueListenableBuilder<BankState>(
            valueListenable: _controller.state,
            builder: (context, state, _) {
              switch (state.runtimeType) {
                case const (BankStartState):
                  return const Center(
                    child: Center(
                      child: Text('Sem dados'),
                    ),
                  );
                case const (BankLoadingState):
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case const (BankSuccessfulState):
                  final successFulState = state as BankSuccessfulState;
                  return Center(
                    child: ListView.builder(
                        itemCount: successFulState.banks.length,
                        itemBuilder: (context, index) {
                          final bank = successFulState.banks[index];
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
                              key: ValueKey(bank.id),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                return await _removeBank(bank);
                              },
                              child: ListTile(
                                leading: SvgPicture.asset(
                                  bank.path,
                                  semanticsLabel: bank.description,
                                  allowDrawingOutsideViewBox: false,
                                  width: 40,
                                  height: 40,
                                ),
                                title: Text(bank.description),
                                // onTap: () async {
                                //   final result = await context.push(
                                //       '/more/banks/form/Editar',
                                //       extra: successFulState.banks[index]);

                                //   if (result == true) _controller.getBanks();
                                // },
                              ),
                            ),
                          );
                        }),
                  );
                case const (BankErrorState):
                  final errorState = state as BankErrorState;
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
