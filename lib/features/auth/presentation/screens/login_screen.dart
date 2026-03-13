import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import 'package:task/core/providers/responsive_provider.dart' as resp;
import '../providers/auth_provider.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final res = context.watch<resp.ResponsiveProvider>();

    // Responsive sizes using centralized Provider
    final horizontalPadding = res.loginHorizontalPadding;
    final verticalPadding = res.sh(0.02);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        child: Form(
          key: authProvider.loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthTextField(
                controller: authProvider.loginEmailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter email';
                  if (!value.contains('@')) return 'Enter valid email';
                  return null;
                },
              ),
              res.vSpace(res.smallSpace),
              AuthTextField(
                controller: authProvider.loginPasswordController,
                label: 'Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter password';
                  if (value.length < 6) return 'Password too short';
                  return null;
                },
              ),
              res.vSpace(res.mediumSpace),
              AuthButton(
                text: 'Login',
                onPressed: () async {
                  final success = await authProvider.loginWithControllers();
                  if (success && context.mounted) {
                    context.go(AppRoutes.home);
                  } else if (context.mounted && authProvider.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(authProvider.error!)),
                    );
                  }
                },
                isLoading: authProvider.isLoading,
              ),
              TextButton(
                onPressed: () {
                  context.push(AppRoutes.register);
                },
                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
