import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MorePage extends StatelessWidget {
  MorePage({super.key});
  final List<Map<String, dynamic>> _items = [
    {
      'icon': Icons.group,
      'title': 'Grupos',
    },
    {
      'icon': Icons.account_balance,
      'title': 'contas',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(_items[index]['icon']),
            title: Text(_items[index]['title']),
            onTap: () {
              if (_items[index]['title'] == 'Grupos') {
                context.go('/more/groups');
              } else if (_items[index]['title'] == 'contas') {
                context.go('/more/accounts');
              }
            },
          );
        },
      ),
    );
  }
}
