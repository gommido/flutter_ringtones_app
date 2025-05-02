import 'package:flutter/material.dart';
import '../../../core/components/custom_container.dart';
import '../../../core/components/custom_expanded.dart';
import '../../../core/components/custom_gesture_detector.dart';
import '../../../core/components/custom_icon.dart';
import '../../../core/components/custom_row.dart';
import '../../../core/components/custom_sized_box.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/functions/fade_animation.dart';
import '../../../core/resources/color_manager.dart';
import '../../../services/localization/localization.dart';
import '../../ringtones_page/ringtones_page.dart';

class RingtonesButtonWidget extends StatelessWidget {
  const RingtonesButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomExpanded(
      child: CustomGestureDetector(
        onTap: (){
         Navigator.of(context).push(navigateFadeAnimation(widget: const RingtonesPage(),),);
        },
        child: CustomContainer(
          alignment: Alignment.center,
          height: size.height / 15,
          decoration: BoxDecoration(
            color: ColorManager.pink,
            borderRadius: BorderRadius.circular(5),
          ),
          child: CustomRow(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIcon(icon: Icons.notifications_active, color: ColorManager.white,),
              CustomSizedBox(width: size.width / 100,),
              CustomText(
                data: translate(context, 'ringtones'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorManager.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
