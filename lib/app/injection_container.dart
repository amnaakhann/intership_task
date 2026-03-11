import 'package:get_it/get_it.dart';
import 'package:task/core/services/auth_service.dart';
import 'package:task/core/services/firestore_service.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Core Services
  if (!sl.isRegistered<AuthService>()) {
    sl.registerLazySingleton<AuthService>(() => AuthService());
  }
  if (!sl.isRegistered<FirestoreService>()) {
    sl.registerLazySingleton<FirestoreService>(() => FirestoreService());
  }


}
