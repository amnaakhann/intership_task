import 'package:flutter/material.dart';

/// Navigation service for programmatic routing
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  static Future<T?>? navigateTo<T>(String routeName, {Object? arguments}) {
    return navigator?.pushNamed<T>(routeName, arguments: arguments);
  }

  static void goBack<T>({T? result}) {
    navigator?.pop<T>(result);
  }

  static Future<T?>? navigateAndReplace<T>(String routeName,
      {Object? arguments}) {
    return navigator?.pushReplacementNamed<T, dynamic>(routeName,
        arguments: arguments);
  }
}
