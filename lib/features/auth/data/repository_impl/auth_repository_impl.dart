import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Stream<User?> get authStateChanges => remote.authStateChanges;

  @override
  User? get currentUser => remote.currentUser;

  @override
  Future<UserCredential> signIn(String email, String password) {
    return remote.signIn(email, password);
  }

  @override
  Future<UserCredential> signUp(String email, String password) {
    return remote.signUp(email, password);
  }

  @override
  Future<void> signOut() async {
    await remote.authService.signOut();
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    // convert UserEntity to UserModel if necessary
    try {
      final userModel = (user is dynamic && (user as dynamic).toMap != null)
          ? user
          : user;
      // If remote has a saveUser which accepts UserModel, we attempt to call it.
      await remote.saveUser(user as dynamic);
    } catch (e) {
      rethrow;
    }
  }
}
