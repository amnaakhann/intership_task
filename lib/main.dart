import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/core/theme/app_theme.dart';
import 'package:task/firebase_options.dart';
import 'package:task/core/router/app_router.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'app/injection_container.dart' as di;
import 'features/auth/domain/repository/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(di.sl<AuthRepository>()),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Task App',
            theme: AppTheme.lightTheme,
            onGenerateRoute: AppRouter.generateRoute,
            home: (authProvider != null && authProvider.isAuthenticated)
                ? const HomeScreen()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
