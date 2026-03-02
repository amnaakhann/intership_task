import 'package:flutter/material.dart';
import 'package:task/features/home/presentation/screens/home_screen.dart';

/// Application route names
class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String saved = '/saved';
  static const String cooked = '/cooked';
}

/// Application route generator
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page not found')),
          ),
        );
    }
  }
}
