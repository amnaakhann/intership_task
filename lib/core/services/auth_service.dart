import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream for auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Debug log
      // ignore: avoid_print
      print('[AuthService] signInWithEmailAndPassword start for $email');

      final result = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 15));

      // ignore: avoid_print
      print('[AuthService] signInWithEmailAndPassword success for $email');
      return result;
    } on FirebaseAuthException catch (e) {
      // Surface firebase error code/message
      // ignore: avoid_print
      print('[AuthService] FirebaseAuthException: ${e.code} ${e.message}');
      throw Exception(e.message ?? e.code);
    } on TimeoutException catch (_) {
      // ignore: avoid_print
      print('[AuthService] signIn timeout for $email');
      throw Exception('Authentication timed out. Check your network connection.');
    } catch (e) {
      // ignore: avoid_print
      print('[AuthService] signIn unexpected error: $e');
      rethrow;
    }
  }

  // Register with email and password
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      // ignore: avoid_print
      print('[AuthService] signUpWithEmailAndPassword start for $email');

      final result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 15));

      // ignore: avoid_print
      print('[AuthService] signUpWithEmailAndPassword success for $email');
      return result;
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print('[AuthService] FirebaseAuthException (signUp): ${e.code} ${e.message}');
      throw Exception(e.message ?? e.code);
    } on TimeoutException catch (_) {
      // ignore: avoid_print
      print('[AuthService] signUp timeout for $email');
      throw Exception('Registration timed out. Check your network connection.');
    } catch (e) {
      // ignore: avoid_print
      print('[AuthService] signUp unexpected error: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
