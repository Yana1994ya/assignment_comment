import 'package:assignment_comment/screens/homepage.dart';
import 'package:assignment_comment/screens/write_comment.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'write_comment',
          builder: (BuildContext context, GoRouterState state) {
            return const WriteComment();
          },
        ),
      ],
    ),
  ],
);