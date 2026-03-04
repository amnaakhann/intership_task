import 'package:flutter/material.dart';

class CarouselItem {
  final List<Color> gradient;
  final String title;
  final String subtitle;
  final IconData icon;

  const CarouselItem({
    required this.gradient,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
