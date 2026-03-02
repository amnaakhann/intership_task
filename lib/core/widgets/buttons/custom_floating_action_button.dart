import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Custom floating action button
class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color? backgroundColor;

  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? AppColors.primary,
      shape: const CircleBorder(),
      child: Icon(icon, color: Colors.white),
    );
  }
}
