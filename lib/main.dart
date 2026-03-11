import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task/app/food.dart';
import 'app/injection_container.dart' as dio;
import 'package:task/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dio.init();

  runApp(const ToHerFocus());
}
