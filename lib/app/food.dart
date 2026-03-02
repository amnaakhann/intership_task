import 'package:flutter/material.dart';

/// Root application widget
class ToHerFocus extends StatelessWidget {
  const ToHerFocus({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('Food'))),
    );
  }
}
