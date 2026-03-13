import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/core/theme/app_theme.dart';
import 'package:task/core/router/app_router.dart';
import 'package:task/app/injection_container.dart' as dio;
import 'package:task/features/home/presentation/screens/home_screen.dart';
import 'package:task/features/auth/presentation/providers/auth_provider.dart';
import 'package:task/features/auth/presentation/screens/login_screen.dart';

/// Root application widget
class ToHerFocus extends StatelessWidget {
  const ToHerFocus({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Use GetIt factories to create providers
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => dio.sl<AuthProvider>(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final isAuthenticated = authProvider.isAuthenticated;
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Task App',
            theme: AppTheme.lightTheme,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
