import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/app_router.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.register(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
        address: _addressController.text.trim(),
        age: int.tryParse(_ageController.text.trim()) ?? 0,
      );

      if (success && mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProvider.error ?? 'Registration failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter email';
                    if (!value.contains('@')) return 'Enter valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter full name';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _addressController,
                  label: 'Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter address';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _ageController,
                  label: 'Age',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter age';
                    if (int.tryParse(value) == null) return 'Enter valid age';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _passwordController,
                  label: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter password';
                    if (value.length < 6) return 'Password too short';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Confirm your password';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                AuthButton(
                  text: 'Register',
                  onPressed: _register,
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
