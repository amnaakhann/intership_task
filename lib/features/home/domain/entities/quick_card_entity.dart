import 'package:flutter/material.dart';

class QuickCardEntity {
  final String name;
  final String time;
  final IconData icon;
  final Color bgColor;

  const QuickCardEntity({
    required this.name,
    required this.time,
    required this.icon,
    required this.bgColor,
  });
}
