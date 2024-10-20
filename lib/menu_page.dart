import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medium_go_router_deprecation/first_page.dart';

import 'gen_route.dart';

class MenuRoute extends SupportedGenRoute {
  static const String routeName = 'menu';

  MenuRoute()
      : super(
          path: '/menu',
          name: routeName,
          builder: (_, __) => const MenuPage(),
          routes: [
            FirstRoute(),
          ],
        );
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('menu'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => context.goNamed(FirstRoute.routeName),
                child: const Text('go to first'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
