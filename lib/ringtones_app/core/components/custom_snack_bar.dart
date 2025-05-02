
import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import 'custom_text.dart';

class CustomSnackBar {
  static void show({
    required String title,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ColorManager.teal,
            content: Center(
              child: CustomText(
                data: title,
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
            ),
        ),
    );
  }
}
