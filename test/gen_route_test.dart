import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medium_go_router_deprecation/gen_route.dart';
import 'package:meta/meta.dart';

void main() {
  group('GenRoute', () {
    GoRouter getGoRouter() {
      return GoRouter(
        routes: [
          SupportedGenRoute(
            path: '/',
            name: 'home',
            builder: (_, __) => const Text('home'),
            routes: [
              SupportedGenRoute(
                path: '/menu',
                name: 'menu',
                builder: (_, __) => const Text('menu'),
                routes: [
                  SupportedGenRoute(
                    path: '/first',
                    name: 'first',
                    builder: (_, __) => const Text('first-new'),
                    routes: [
                      SupportedGenRoute(
                        path: '/second',
                        name: 'second',
                        builder: (_, __) => const Text('second-new'),
                      ),
                    ],
                  ),
                ],
              ),
              DeprecatedGenRoute(
                path: '/first',
                redirectToName: 'first',
                routes: [
                  SupportedGenRoute(
                    path: '/second',
                    name: 'second',
                    builder: (_, __) => const Text('second-old'),
                  ),
                  DeprecatedGenRoute(
                    path: '/third',
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }

    @isTest
    void routeTest({
      required String description,
      required String pathToNavigateTo,
      required String expectedText,
    }) {
      testWidgets(
        description,
        (WidgetTester tester) async {
          // PREPARE
          final GoRouter goRouter = getGoRouter();
          await tester.pumpWidget(
            MaterialApp.router(
              routerConfig: goRouter,
            ),
          );

          // TRIGGER
          goRouter.push(pathToNavigateTo);
          await tester.pumpAndSettle();

          // TEST
          expect(find.text(expectedText), findsOneWidget);
        },
      );
    }

    routeTest(
      description: 'navigating to an existing route should result in displaying it',
      pathToNavigateTo: '/first/second',
      expectedText: 'second-new',
    );

    routeTest(
      description: 'navigating to a deprecated route with redirect should result in redirect',
      pathToNavigateTo: '/first',
      expectedText: 'first-new',
    );

    routeTest(
      description: 'navigating to a deprecated route without redirect should result in navigating to home',
      pathToNavigateTo: '/first/third',
      expectedText: 'home',
    );

    routeTest(
      description: 'navigating to supported route within deprecated route should result in redirect to the same route',
      pathToNavigateTo: '/first/second',
      expectedText: 'second-new',
    );
  });
}
