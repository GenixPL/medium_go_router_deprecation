import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medium_go_router_deprecation/second_page.dart';

import 'gen_route.dart';

class OldFirstRoute extends DeprecatedGenRoute {
  OldFirstRoute()
      : super(
          path: '/first',
          redirectToName: FirstRoute.routeName,
          routes: [
            SecondRoute(),
          ],
        );
}

class FirstRoute extends SupportedGenRoute {
  static const String routeName = 'first';

  FirstRoute()
      : super(
          path: '/first',
          name: routeName,
          builder: (_, __) => const FirstPage(),
          routes: [
            SecondRoute(),
          ],
        );
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('first'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => context.goNamed(SecondRoute.routeName),
                child: const Text('go to second'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
