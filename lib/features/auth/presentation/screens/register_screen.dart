import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import 'package:task/core/providers/responsive_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final res = context.watch<ResponsiveProvider>();

    // Use centralised Provider for responsive sizing
    final horizontalPadding = res.horizontalPadding;

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: res.sh(res.smallSpace)),
        child: SingleChildScrollView(
          child: Form(
            key: authProvider.registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                res.vSpace(res.largeSpace),
                AuthTextField(
                  controller: authProvider.registerEmailController,
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
                  controller: authProvider.registerNameController,
                  label: 'Full Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter full name';
                    return null;
                  },
                ),
                res.vSpace(res.smallSpace),
                AuthTextField(
                  controller: authProvider.registerAddressController,
                  label: 'Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter address';
                    return null;
                  },
                ),
                res.vSpace(res.smallSpace),
                AuthTextField(
                  controller: authProvider.registerAgeController,
                  label: 'Age',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter age';
                    if (int.tryParse(value) == null) return 'Enter valid age';
                    return null;
                  },
                ),
                res.vSpace(res.smallSpace),
                AuthTextField(
                  controller: authProvider.registerPasswordController,
                  label: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter password';
                    if (value.length < 6) return 'Password too short';
                    return null;
                  },
                ),
                res.vSpace(res.smallSpace),
                AuthTextField(
                  controller: authProvider.registerConfirmPasswordController,
                  label: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Confirm your password';
                    return null;
                  },
                ),
                res.vSpace(res.mediumSpace),
                AuthButton(
                  text: 'Register',
                  onPressed: () async {
                    final success = await authProvider.registerWithControllers();
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
                    Navigator.pop(context);
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
