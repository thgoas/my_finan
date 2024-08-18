import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:my_finan/interactor/entities/group_entity.dart';
import 'package:my_finan/interactor/entities/type_method.dart';
import 'package:my_finan/interactor/entities/type_operation.dart';
import 'package:my_finan/interactor/models/group_model.dart';
import 'package:my_finan/shared/components/description_widget.dart';
import 'package:my_finan/shared/components/icon_list_widget.dart';
import 'package:my_finan/shared/components/show_button_sheet_widget.dart';
import 'package:my_finan/shared/components/type_method_finance_widget.dart';
import 'package:my_finan/shared/components/type_operation_widget.dart';
import 'package:my_finan/shared/models/show_dialog.dart';
import 'package:my_finan/shared/models/type_method_finance.dart';
import 'package:my_finan/shared/models/type_operation_model.dart';

// ignore: must_be_immutable
class FormGroupPage extends StatefulWidget {
  String groupTitle;
  GroupEntity? groupEntity;
  String _description = '';
  TypeOperation? _typeOperation;
  TypeMethod? _typeMethod;
  int? _iconCode;
  FormGroupPage(
      {super.key, required this.groupTitle, required this.groupEntity}) {
    _description = groupEntity?.description ?? '';
    _iconCode = groupEntity?.iconCode;
    _typeOperation = groupEntity?.typeOperation;
    _typeMethod = groupEntity?.typeMethod;
  }

  @override
  State<FormGroupPage> createState() => _FormGroupPageState();
}

class _FormGroupPageState extends State<FormGroupPage> {
  final TypeOperationModel _typeOperationModel = TypeOperationModel();
  final TypeMethodFinance _typeMethodFinance = TypeMethodFinance();
  final _controller = GetIt.instance.get<GroupModel>();
  _getIconCode(int? iconCode) {
    if (iconCode != null) {
      setState(() {
        widget._iconCode = iconCode;
      });
    }
  }

  _setTypeOperation(String typeOperation) {
    setState(() {
      _typeOperationModel.setTypeOperation(typeOperation);
      widget._typeOperation = _typeOperationModel.typeOperation;
    });
  }

  _setTypeMethod(String typeMethod) {
    setState(() {
      _typeMethodFinance.setTypeMethod(typeMethod);
      widget._typeMethod = _typeMethodFinance.typeMethod;
    });
  }

  bool _validation() {
    if (widget._description.isNotEmpty &&
        widget._typeOperation != null &&
        widget._typeMethod != null) {
      return true;
    }
    ShowDialog.alertDialog('Error', 'Os Campos devem ser preenchidos', context);
    return false;
  }

  _save() {
    if (_validation()) {
      if (widget.groupEntity?.id == null) {
        final input = InputNewGroup(
            description: widget._description,
            typeOperation: widget._typeOperation!,
            typeMethod: widget._typeMethod!,
            iconCode: widget._iconCode!);
        _controller.saveGroup(input);
        context.go('/');
      } else {
        final input = InputUpdateGroup(
            id: widget.groupEntity!.id,
            description: widget._description,
            iconCode: widget._iconCode!,
            typeOperation: widget._typeOperation!,
            typeMethod: widget._typeMethod!,
            createdAt: widget.groupEntity!.createdAt!);
        _controller.updateGroup(input);
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.groupTitle} grupo'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     if (Navigator.canPop(context)) {
        //       context.pop();
        //     } else {
        //       context.go('/');
        //     }
        //   },
        // ),
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
              ShowButtonSheetWidget(
                title: 'Selecionar tipo de operação',
                subTitle:
                    '${_typeOperationModel.typeOperationToMap(widget._typeOperation)['name']} Selecionada',
                icon: Icon(
                  _typeOperationModel
                      .typeOperationToMap(widget._typeOperation)['icon'],
                  size: 40,
                  color: _typeOperationModel
                      .typeOperationToMap(widget._typeOperation)['color'],
                ),
                component: TypeOperationWidget(
                  function: _setTypeOperation,
                ),
                height: 250,
              ),
              ShowButtonSheetWidget(
                title: 'Selecionar Metodo Financeiro',
                subTitle:
                    '${_typeMethodFinance.typeMethodToMap(widget._typeMethod)['name']} Selecionada',
                icon: Text(
                    _typeMethodFinance
                        .typeMethodToMap(widget._typeMethod)['text'],
                    style: TextStyle(
                      fontSize: 30,
                      color: _typeMethodFinance
                          .typeMethodToMap(widget._typeMethod)['color'],
                    )),
                component: TypeMethodFinanceWidget(
                  function: _setTypeMethod,
                ),
                height: 250,
              ),
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
