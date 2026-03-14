import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Stream<User?> get authStateChanges => remote.authStateChanges;

  @override
  User? get currentUser => remote.currentUser;

  @override
  Future<UserCredential> signIn(String email, String password) async {
    try {
      // ignore: avoid_print
      print('[AuthRepository] signIn for $email');
      final res = await remote.signIn(email, password);
      return res;
    } catch (e) {
      // ignore: avoid_print
      print('[AuthRepository] signIn error: $e');
      rethrow;
    }
  }

  @override
  Future<UserCredential> signUp(String email, String password) async {
    try {
      // ignore: avoid_print
      print('[AuthRepository] signUp for $email');
      final res = await remote.signUp(email, password);
      return res;
    } catch (e) {
      // ignore: avoid_print
      print('[AuthRepository] signUp error: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await remote.authService.signOut();
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    try {
      // ignore: avoid_print
      print('[AuthRepository] saveUser ${user.uid}');
      await remote.saveUser(user as UserModel);
    } catch (e) {
      // ignore: avoid_print
      print('[AuthRepository] saveUser error: $e');
      rethrow;
    }
  }
}
