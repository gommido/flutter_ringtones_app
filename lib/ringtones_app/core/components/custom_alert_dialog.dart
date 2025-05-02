import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import 'custom_column.dart';
import 'custom_container.dart';

AlertDialog customAlertDialog({
  required BuildContext context,
  required double height,
  required List<Widget> children,
  required List<Widget> actions,
}){
  final size = MediaQuery.of(context).size;
  return AlertDialog(
    backgroundColor: ColorManager.dialogBG,
    actions: actions,
    content: CustomContainer(
      padding: const EdgeInsets.all(15),
      width: size.width,
      height: height,
      child: CustomColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    ),
  );
}