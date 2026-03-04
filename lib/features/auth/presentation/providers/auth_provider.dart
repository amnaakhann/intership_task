import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/core/providers/base_provider.dart';
import 'package:task/core/services/auth_service.dart';
import 'package:task/core/services/firestore_service.dart';
import '../../data/models/user_model.dart';

class AuthProvider extends BaseProvider {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  User? _user;

  AuthProvider() {
    _authService.authStateChanges.listen((User? user) {
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
      await _authService.signInWithEmailAndPassword(email, password);
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
      final userCredential = await _authService.signUpWithEmailAndPassword(email, password);
      final user = userCredential.user;

      if (user != null) {
        final userModel = UserModel(
          uid: user.uid,
          email: email,
          name: name,
          address: address,
          age: age,
        );

        await _firestoreService.setDocument('users', user.uid, userModel.toMap());
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
    await _authService.signOut();
  }
}
