import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/core/services/auth_service.dart';
import 'package:task/core/services/firestore_service.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final AuthService authService;
  final FirestoreService firestoreService;

  AuthRemoteDataSource(this.authService, this.firestoreService);

  Stream<User?> get authStateChanges => authService.authStateChanges;
  User? get currentUser => authService.currentUser;

  Future<UserCredential> signIn(String email, String password) async {
    try {
      // ignore: avoid_print
      print('[AuthRemoteDataSource] signIn for $email');
      final credential = await authService.signInWithEmailAndPassword(email, password);
      return credential;
    } catch (e) {
      // ignore: avoid_print
      print('[AuthRemoteDataSource] signIn error: $e');
      rethrow;
    }
  }

  Future<UserCredential> signUp(String email, String password) async {
    try {
      // ignore: avoid_print
      print('[AuthRemoteDataSource] signUp for $email');
      final credential = await authService.signUpWithEmailAndPassword(email, password);
      return credential;
    } catch (e) {
      // ignore: avoid_print
      print('[AuthRemoteDataSource] signUp error: $e');
      rethrow;
    }
  }

  Future<void> saveUser(UserModel user) async {
    try {
      // ignore: avoid_print
      print('[AuthRemoteDataSource] saveUser ${user.uid}');
      await firestoreService.setDocument('users', user.uid, user.toMap());
      // ignore: avoid_print
      print('[AuthRemoteDataSource] saveUser complete for ${user.uid}');
    } catch (e) {
      // ignore: avoid_print
      print('[AuthRemoteDataSource] saveUser error: $e');
      rethrow;
    }
  }
}
