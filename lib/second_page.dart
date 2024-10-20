import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medium_go_router_deprecation/home_page.dart';

import 'gen_route.dart';

class SecondRoute extends SupportedGenRoute {
  static const String routeName = 'second';

  SecondRoute()
      : super(
          path: '/second',
          name: routeName,
          builder: (_, __) => const SecondPage(),
        );
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('second'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => context.goNamed(HomeRoute.routeName),
                child: const Text('go to home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
