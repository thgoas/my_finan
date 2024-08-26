import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MorePage extends StatelessWidget {
  MorePage({super.key});
  final List<Map<String, dynamic>> _items = [
    {
      'icon': Icons.group,
      'title': 'Grupos',
      'path': '/more/groups',
    },
    {
      'icon': Icons.account_balance,
      'title': 'Contas',
      'path': '/more/accounts',
    },
    {
      'icon': Icons.account_box,
      'title': 'Bancos',
      'path': '/more/banks',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuração'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(_items[index]['icon']),
            title: Text(_items[index]['title']),
            trailing: const Icon(
              Icons.edit,
              color: Colors.purple,
            ),
            onTap: () {
              context.go(_items[index]['path']);
            },
          );
        },
      ),
    );
  }
}
