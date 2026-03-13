import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;

  /// Returns a fraction of the screen height.
  double sh(double percent) => screenHeight * percent;

  /// Returns a fraction of the screen width.
  double sw(double percent) => screenWidth * percent;

  /// Returns a SizedBox with a fraction of the screen height.
  Widget vSpace(double percent) => SizedBox(height: sh(percent));

  /// Returns a SizedBox with a fraction of the screen width.
  Widget hSpace(double percent) => SizedBox(width: sw(percent));
}
