import 'package:go_router/go_router.dart';

import 'home_page.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    HomeRoute(),
  ],
);
