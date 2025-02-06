import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/home_screen/home_screen_view.dart';

abstract class AppRouter {
  List<RouteBase> get routes;
}

class MobileRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static const String initialScreenRoute = '/initial_screen_route';

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialScreenRoute,
    routes: <RouteBase>[
      GoRoute(
        path: initialScreenRoute,
        name: initialScreenRoute,
        builder: (_, __) => const HomeScreenView(),
      ),
    ],
  );
}
