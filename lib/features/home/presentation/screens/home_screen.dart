import 'package:flutter/material.dart';
import 'home_mobile.dart';

/// Home screen entry point – picks the correct layout based on screen width
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Tablet & larger screens could use a different layout
        // For now, mobile layout handles both
        return const HomeMobile();
      },
    );
  }
}
