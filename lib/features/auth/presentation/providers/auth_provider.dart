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

  User? get user => _user;
  bool get isAuthenticated => _user != null;

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
