import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barbershop/src/core/ui/widgets/babershop_loader.dart';
import 'package:dw_barbershop/src/features/auth/login_page.dart';
import 'package:dw_barbershop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BabershopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'Dw Barbershopp',
          navigatorObservers: [asyncNavigatorObserver],
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login':(context) => const LoginPage()
          },
        );
      },
    );
  }
}
