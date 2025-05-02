import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../../core/components/custom_container.dart';
import '../../../core/components/custom_icon.dart';
import '../../../core/components/custom_padding.dart';
import '../../../core/resources/color_manager.dart';


SpeedDialChild ringtoneTypeWidget({
  required IconData icon,
  required Widget label,
  required BuildContext context,
  required VoidCallback onTap,
}){
  return SpeedDialChild(
      onTap: onTap,
      child: CustomIcon(
        icon: icon,
        color: ColorManager.white,
      ),
      labelWidget: CustomContainer(
        decoration: BoxDecoration(
            color: ColorManager.white ,
            borderRadius: BorderRadius.circular(10),
        ),
        child: CustomPadding(
          padding: const EdgeInsets.all(8.0),
          child: label,
        ),
      ),
      backgroundColor: ColorManager.pink,
  );
}