import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,
    routes: <GoRoute>[
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            path: 'register',
            builder: (context, state) => const RegisterScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(child: Text('404 - Page not found')),
    ),
  );
}
