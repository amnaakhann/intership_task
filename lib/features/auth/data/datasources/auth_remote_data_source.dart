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

  Future<UserCredential> signIn(String email, String password) {
    return authService.signInWithEmailAndPassword(email, password);
  }

  Future<UserCredential> signUp(String email, String password) {
    return authService.signUpWithEmailAndPassword(email, password);
  }

  Future<void> saveUser(UserModel user) async {
    await firestoreService.setDocument('users', user.uid, user.toMap());
  }
}
