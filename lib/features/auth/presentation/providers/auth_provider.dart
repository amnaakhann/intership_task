import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/core/providers/base_provider.dart';
import '../../data/models/user_model.dart';
import '../../domain/repository/auth_repository.dart';

class AuthProvider extends BaseProvider {
  final AuthRepository _authRepository;
  User? _user;

  AuthProvider(this._authRepository) {
    _authRepository.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Form Keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Login Controllers
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Register Controllers
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  final registerNameController = TextEditingController();
  final registerAddressController = TextEditingController();
  final registerAgeController = TextEditingController();

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    registerNameController.dispose();
    registerAddressController.dispose();
    registerAgeController.dispose();
    super.dispose();
  }

  // Login with controllers
  Future<bool> loginWithControllers() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      return await login(
        loginEmailController.text.trim(),
        loginPasswordController.text.trim(),
      );
    }
    return false;
  }

  // Register with controllers
  Future<bool> registerWithControllers() async {
    if (registerFormKey.currentState?.validate() ?? false) {
      if (registerPasswordController.text != registerConfirmPasswordController.text) {
        setError('Passwords do not match');
        return false;
      }

      return await register(
        email: registerEmailController.text.trim(),
        password: registerPasswordController.text.trim(),
        name: registerNameController.text.trim(),
        address: registerAddressController.text.trim(),
        age: int.tryParse(registerAgeController.text.trim()) ?? 0,
      );
    }
    return false;
  }

  // Sign In
  Future<bool> login(String email, String password) async {
    setLoading(true);
    setError(null);
    try {
      await _authRepository.signIn(email, password);
      setLoading(false);
      return true;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      return false;
    }
  }

  // Sign Up
  Future<bool> register({
    required String email,
    required String password,
    required String name,
    required String address,
    required int age,
  }) async {
    setLoading(true);
    setError(null);
    try {
      final userCredential = await _authRepository.signUp(email, password);
      final user = userCredential.user;

      if (user != null) {
        final userModel = UserModel(
          uid: user.uid,
          email: email,
          name: name,
          address: address,
          age: age,
        );

        // Save user via repository (typed)
        try {
          await _authRepository.saveUser(userModel);
        } catch (_) {}
      }

      setLoading(false);
      return true;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      return false;
    }
  }

  // Sign Out
  Future<void> logout() async {
    await _authRepository.signOut();
  }
}
