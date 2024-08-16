import 'package:flutter/material.dart';

class TypeOperationWidget extends StatelessWidget {
  final List itemBuilder = ['Receita', 'Despesa', 'Transferencia'];
  final List iconBuilder = [
    Icons.call_received,
    Icons.call_made,
    Icons.import_export
  ];
  final List colorBuilder = [Colors.green, Colors.red, Colors.blue];
  final Function function;
  TypeOperationWidget({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemBuilder.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Card(
            child: ListTile(
              leading: Icon(
                iconBuilder[index],
                color: colorBuilder[index],
              ),
              title: Text(itemBuilder[index]),
              onTap: () {
                function(itemBuilder[index]);
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }
}
