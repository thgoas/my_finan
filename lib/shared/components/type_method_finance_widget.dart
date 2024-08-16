import 'package:flutter/material.dart';

class TypeMethodFinanceWidget extends StatelessWidget {
  final List itemBuilder = ['Essencial', 'Não essencial', 'Reserva'];
  final List iconBuilder = [
    '50%',
    '30%',
    '20%',
  ];
  final List colorBuilder = [Colors.green, Colors.red, Colors.blue];
  final Function function;
  TypeMethodFinanceWidget({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemBuilder.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Card(
            child: ListTile(
              leading: Text(
                iconBuilder[index],
                style: TextStyle(
                  fontSize: 20,
                  color: colorBuilder[index],
                ),
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
