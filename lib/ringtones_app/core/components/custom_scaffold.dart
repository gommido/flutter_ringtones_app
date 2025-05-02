import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.backgroundColor,
    this.floatingActionButton,
  });
  final Widget body;
  PreferredSizeWidget? appBar;
  Color? backgroundColor;
  Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
