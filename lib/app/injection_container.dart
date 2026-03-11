import 'package:get_it/get_it.dart';
import 'package:task/core/services/auth_service.dart';
import 'package:task/core/services/firestore_service.dart';
import 'package:task/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:task/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:task/features/auth/domain/repository/auth_repository.dart';
import 'package:task/features/home/data/datasources/home_remote_data_source.dart';
import 'package:task/features/home/data/repository_impl/home_repository_impl.dart';
import 'package:task/features/home/domain/repository/home_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton<AuthService>(() => AuthService());
  sl.registerLazySingleton<FirestoreService>(() => FirestoreService());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(sl(), sl()));
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSource(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));

  // You can register more features similarly
}
