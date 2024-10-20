import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medium_go_router_deprecation/first_page.dart';
import 'package:medium_go_router_deprecation/gen_route.dart';
import 'package:medium_go_router_deprecation/menu_page.dart';
import 'package:medium_go_router_deprecation/second_page.dart';

class HomeRoute extends SupportedGenRoute {
  static const String routeName = 'home';

  HomeRoute()
      : super(
          path: '/',
          name: routeName,
          builder: (_, __) => const HomePage(),
          routes: [
            MenuRoute(),
            OldFirstRoute(),
          ],
        );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () => context.goNamed(FirstRoute.routeName),
              child: const Text('go to first'),
            ),
            TextButton(
              onPressed: () => context.goNamed(SecondRoute.routeName),
              child: const Text('go to second'),
            ),
            TextButton(
              onPressed: () => context.goNamed(MenuRoute.routeName),
              child: const Text('go to menu'),
            ),
            TextButton(
              onPressed: () => context.go('/first'),
              child: const Text('go "/first"'),
            ),
            TextButton(
              onPressed: () => context.go('/first/second'),
              child: const Text('go "/first/second"'),
            ),
            TextButton(
              onPressed: () => context.go('/menu'),
              child: const Text('go "/menu"'),
            ),
          ],
        ),
      ),
    );
  }
}
