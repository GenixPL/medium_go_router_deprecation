import 'package:go_router/go_router.dart';

import 'home_page.dart';

sealed class GenRoute extends GoRoute {
  GenRoute({
    required super.path,
    super.name,
    super.builder,
    super.redirect,
    this.routes = const [],
  });

  @override
  // We need this override to ensure that all routes are of our type
  // and comply with our requirements (in this case name nullability).
  // There are ways of providing this without triggering the lint warning,
  // however, they add a bit more code and, for the clarity of the example,
  // I want to keep it as minimal as possible.
  // ignore: overridden_fields
  final List<GenRoute> routes;
}

class SupportedGenRoute extends GenRoute {
  SupportedGenRoute({
    required super.path,
    required String name,
    required super.builder,
    super.redirect,
    super.routes,
  }) : super(
          name: name,
        );
}

class DeprecatedGenRoute extends GenRoute {
  DeprecatedGenRoute({
    required super.path,
    this.redirectToName,
    List<GenRoute> routes = const [],
  }) : super(
          name: null,
          builder: null,
          routes: _routes(routes),
          redirect: (_, GoRouterState state) {
            return _redirectOverride(
              state: state,
              path: path,
              redirectToName: redirectToName,
            );
          },
        );

  final String? redirectToName;

  static Future<String?> _redirectOverride({
    required GoRouterState state,
    required String path,
    required String? redirectToName,
  }) async {
    // Redirect only if the current path is the top one being pushed!
    // Otherwise we will intercept the higher routes, which is a definite bug.
    if (state.topRoute?.path == path) {
      return state.namedLocation(redirectToName ?? HomeRoute.routeName);
    }

    return null;
  }

  static List<GenRoute> _routes(List<GenRoute> routes) {
    return routes.map((GenRoute route) {
      return switch (route) {
        SupportedGenRoute() => DeprecatedGenRoute(
            path: route.path,
            redirectToName: route.name,
            routes: route.routes,
          ),
        DeprecatedGenRoute() => route,
      };
    }).toList();
  }
}
