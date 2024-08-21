import 'package:flutter/material.dart';

import 'package:my_finan/core/inject/inject.dart';

import 'package:my_finan/ui/routers/main_router.dart';

void main() {
  Inject.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Finan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerDelegate: MainRouter.route.routerDelegate,
      routeInformationParser: MainRouter.route.routeInformationParser,
      routeInformationProvider: MainRouter.route.routeInformationProvider,
    );
  }
}
