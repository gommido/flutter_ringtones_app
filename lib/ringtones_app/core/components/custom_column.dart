import 'package:flutter/material.dart';

class CustomColumn extends StatelessWidget {
  CustomColumn({
    super.key,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    required this.children
  });
  MainAxisAlignment? mainAxisAlignment;
  CrossAxisAlignment? crossAxisAlignment;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment != null ? mainAxisAlignment! : MainAxisAlignment.start ,
      crossAxisAlignment: crossAxisAlignment != null ?crossAxisAlignment! : CrossAxisAlignment.center,
      children: children,
    );
  }
}
