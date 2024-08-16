import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_finan/core/inject/inject.dart';
import 'package:my_finan/interactor/entities/group_entity.dart';
import 'package:my_finan/ui/pages/form_group_page.dart';
import 'package:my_finan/ui/pages/groups_page.dart';

void main() {
  Inject.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _route = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const GroupsPage()),
      GoRoute(
        path: '/groups/form/:title',
        builder: (context, state) {
          final String title = state.pathParameters['title']!;
          final dynamic group =
              state.extra != null ? state.extra as GroupEntity : null;
          return FormGroupPage(groupTitle: title, groupEntity: group);
        },
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerDelegate: _route.routerDelegate,
      routeInformationParser: _route.routeInformationParser,
      routeInformationProvider: _route.routeInformationProvider,
    );
  }
}
