import 'package:flutter/material.dart';
import '../../../core/components/custom_text.dart';
import '../../../services/localization/localization.dart';

class RingtoneTitleWidget extends StatelessWidget {
  const RingtoneTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomText(
      data: translate(context, 'ringtones'),
      style: Theme.of(context).textTheme.bodyMedium!,
    );
  }
}
