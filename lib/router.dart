import 'package:assignment_comment/screens/homepage.dart';
import 'package:assignment_comment/screens/write_comment.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Start from 1.0 on X, and 0.0 on the Y axis
      const begin = Offset(1.0, 0.0);
      // End in 0.0, 0.0
      const end = Offset.zero;

      // This defines the position in each frame of the animation
      final tween =
          Tween(begin: begin, end: end)
              .chain(CurveTween(curve: Curves.ease));
      final offsetAnimation = animation.drive(tween);

      // And finally, use a "SlideTransition"
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

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
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
                  context: context,
                  state: state,
                  child: const WriteComment(),
                )),
      ],
    ),
  ],
);
