// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:task/features/auth/presentation/screens/login_screen.dart';
import 'package:task/features/auth/presentation/providers/auth_provider.dart';
import 'package:task/features/auth/domain/repository/auth_repository.dart';
import 'package:task/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class FakeAuthRepository implements AuthRepository {
  @override
  Stream<fb.User?> get authStateChanges => Stream.value(null);

  @override
  fb.User? get currentUser => null;

  @override
  Future<fb.UserCredential> signIn(String email, String password) {
    return Future.error('not implemented');
  }

  @override
  Future<fb.UserCredential> signUp(String email, String password) {
    return Future.error('not implemented');
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<void> saveUser(UserEntity user) async {}
}

void main() {
  testWidgets('LoginScreen renders and shows Login title', (WidgetTester tester) async {
    // Provide AuthProvider backed by FakeAuthRepository so LoginScreen can access it
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(FakeAuthRepository()),
          child: const LoginScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify the LoginScreen renders and shows the AppBar title 'Login'
    expect(find.text('Login'), findsOneWidget);

    // Ensure email and password fields are present
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}
