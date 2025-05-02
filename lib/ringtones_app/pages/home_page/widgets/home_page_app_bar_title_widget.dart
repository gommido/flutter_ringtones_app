import 'package:flutter/material.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/resources/font_manager.dart';

class HomePageAppBarTitleWidget extends StatelessWidget {
  const HomePageAppBarTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: AppStrings.appName,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: FontManager.s20,
      ),
    );
  }
}
