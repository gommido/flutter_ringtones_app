import 'package:flutter/material.dart';

class CustomGestureDetector extends StatelessWidget {
  const CustomGestureDetector({super.key,  required this.onTap, required this.child,});
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}
