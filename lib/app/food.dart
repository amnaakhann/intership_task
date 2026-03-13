import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/core/theme/app_theme.dart';
import 'package:task/core/router/app_router.dart';
import 'package:task/app/injection_container.dart' as dio;
import 'package:task/features/auth/presentation/providers/auth_provider.dart';
import 'package:task/core/providers/responsive_provider.dart';

/// Root application widget
/// Responsiveness utilities (MediaQuery) are centralized in
/// lib/core/extensions/context_extensions.dart for global access.
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
        ChangeNotifierProvider<ResponsiveProvider>(
          create: (_) => ResponsiveProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Task App',
            theme: AppTheme.lightTheme,
            routerConfig: AppRouter.router,
            builder: (context, child) {
              // Update responsive provider with current screen size
              final size = MediaQuery.of(context).size;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.read<ResponsiveProvider>().update(size);
                }
              });
              return child!;
            },
          );
        },
      ),
    );
  }
}
