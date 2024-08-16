import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  String description = '';
  final Function function;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DescriptionWidget(
      {super.key, required this.function, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: description,
                onChanged: (value) => description = value,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    function(description);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
