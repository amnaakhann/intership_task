import 'package:flutter/material.dart';

/// Provider to handle responsive layout calculations globally.
class ResponsiveProvider extends ChangeNotifier {
  double _screenWidth = 0;
  double _screenHeight = 0;

  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;

  /// Standard horizontal padding (used in most screens)
  double get horizontalPadding => _screenWidth * 0.06;
  
  /// Specific horizontal padding for Login (as previously defined)
  double get loginHorizontalPadding => _screenWidth * 0.05;

  /// Standard spacing values (fractions of total height)
  double get smallSpace => 0.02;
  double get mediumSpace => 0.03;
  double get largeSpace => 0.06;

  /// Calculated pixel values for spacing (based on current height)
  double get smallSpacePx => _screenHeight * smallSpace;
  double get mediumSpacePx => _screenHeight * mediumSpace;
  double get largeSpacePx => _screenHeight * largeSpace;

  /// Updates the dimensions and notifies listeners if they changed.
  void update(Size size) {
    if (_screenWidth == size.width && _screenHeight == size.height) return;
    _screenWidth = size.width;
    _screenHeight = size.height;
    notifyListeners();
  }

  /// Convenience: update using BuildContext's MediaQuery
  void updateFromContext(BuildContext context) {
    final mq = MediaQuery.of(context);
    update(mq.size);
  }

  /// Helper to get height percentage (percent must be 0..1)
  double sh(double percent) {
    assert(percent >= 0 && percent <= 1, 'percent must be between 0 and 1');
    return _screenHeight * percent;
  }

  /// Helper to get width percentage (percent must be 0..1)
  double sw(double percent) {
    assert(percent >= 0 && percent <= 1, 'percent must be between 0 and 1');
    return _screenWidth * percent;
  }

  /// Returns a SizedBox with a fraction of the screen height.
  Widget vSpace(double percent) => SizedBox(height: sh(percent));

  /// Returns a SizedBox with a fraction of the screen width.
  Widget hSpace(double percent) => SizedBox(width: sw(percent));
}
