import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:my_finan/interactor/controllers/account_controller.dart';
import 'package:my_finan/interactor/entities/account_entity.dart';

import 'package:my_finan/shared/components/description_widget.dart';
import 'package:my_finan/shared/components/icon_list_widget.dart';
import 'package:my_finan/shared/components/show_button_sheet_widget.dart';

import 'package:my_finan/shared/models/show_dialog.dart';

// ignore: must_be_immutable
class FormAccountPage extends StatefulWidget {
  String title;
  AccountEntity? accountEntity;
  String _description = '';
  int? _iconCode;

  FormAccountPage(
      {super.key, required this.title, required this.accountEntity}) {
    _description = accountEntity?.description ?? '';
    _iconCode = accountEntity?.iconCode;
  }

  @override
  State<FormAccountPage> createState() => _FormAccountPageState();
}

class _FormAccountPageState extends State<FormAccountPage> {
  final _controller = GetIt.instance.get<AccountController>();
  _getIconCode(int? iconCode) {
    if (iconCode != null) {
      setState(() {
        widget._iconCode = iconCode;
      });
    }
  }

  bool _validation() {
    if (widget._description.isNotEmpty) {
      return true;
    }
    ShowDialog.alertDialog('Error', 'Os Campos devem ser preenchidos', context);
    return false;
  }

  _save() {
    if (_validation()) {
      if (widget.accountEntity?.id == null) {
        final input = InputNewAccount(
            description: widget._description, iconCode: widget._iconCode!);
        _controller
            .saveAccount(input)
            .then((value) => GoRouter.of(context).pop(true));
      } else {
        final input = InputUpdateAccount(
            id: widget.accountEntity!.id,
            description: widget._description,
            iconCode: widget._iconCode!,
            createdAt: widget.accountEntity!.createdAt!);
        _controller
            .updateAccount(input)
            .then((value) => GoRouter.of(context).pop(true));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} Conta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ShowButtonSheetWidget(
                title: 'Digite a descrição',
                subTitle: widget._description,
                icon: const Icon(
                  Icons.description,
                  size: 40,
                ),
                component: DescriptionWidget(
                  description: widget._description,
                  function: (value) {
                    setState(() {
                      widget._description = value;
                    });
                  },
                ),
              ),
              ShowButtonSheetWidget(
                  title: 'Selecionar ícone',
                  subTitle: '${widget._iconCode.toString()} Selecionado',
                  icon: widget._iconCode != null
                      ? Icon(
                          IconData(
                            widget._iconCode!,
                            fontFamily: 'MaterialIcons',
                          ),
                          size: 40)
                      : const Icon(Icons.error, size: 40),
                  component: IconListWidget(selectIcon: _getIconCode)),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _save();
                      },
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
