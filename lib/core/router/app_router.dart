import 'package:flutter/material.dart';
import 'package:task/features/home/presentation/screens/home_screen.dart';
import 'package:task/features/auth/presentation/screens/login_screen.dart';
import 'package:task/features/auth/presentation/screens/register_screen.dart';

/// Application route names
class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
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
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      default:
        // Handle sub-routes like /login/register if used
        if (settings.name == '${AppRoutes.login}/register') {
           return MaterialPageRoute(builder: (_) => const RegisterScreen());
        }
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page not found')),
          ),
        );
    }
  }
}
