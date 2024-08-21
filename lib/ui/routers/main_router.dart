import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_finan/interactor/entities/account_entity.dart';
import 'package:my_finan/interactor/entities/group_entity.dart';
import 'package:my_finan/ui/pages/accounts_page.dart';
import 'package:my_finan/ui/pages/form_account_page.dart';
import 'package:my_finan/ui/pages/form_group_page.dart';
import 'package:my_finan/ui/pages/groups_page.dart';
import 'package:my_finan/ui/pages/home_page.dart';
import 'package:my_finan/ui/pages/more_page.dart';
import 'package:my_finan/ui/pages/scaffold_with_nav_bar.dart';

class MainRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorMoreKey =
      GlobalKey<NavigatorState>(debugLabel: 'More');

  static final GoRouter route = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) {
                  return const HomePage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMoreKey,
            routes: [
              GoRoute(
                path: '/more',
                builder: (context, state) {
                  return MorePage();
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'groups',
                    builder: (context, state) {
                      return const GroupsPage();
                    },
                    routes: [
                      GoRoute(
                        path: 'form/:title',
                        builder: (context, state) {
                          final String title = state.pathParameters['title']!;
                          final dynamic group = state.extra != null
                              ? state.extra as GroupEntity
                              : null;
                          return FormGroupPage(
                              groupTitle: title, groupEntity: group);
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'accounts',
                    builder: (context, state) {
                      return const AccountsPage();
                    },
                    routes: <RouteBase>[
                      GoRoute(
                        path: 'form/:title',
                        builder: (context, state) {
                          final String title = state.pathParameters['title']!;
                          final dynamic account = state.extra != null
                              ? state.extra as AccountEntity
                              : null;
                          return FormAccountPage(
                              title: title, accountEntity: account);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    ],
  );
}
