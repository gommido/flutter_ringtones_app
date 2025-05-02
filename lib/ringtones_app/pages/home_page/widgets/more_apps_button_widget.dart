import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import '../../../core/components/custom_container.dart';
import '../../../core/components/custom_expanded.dart';
import '../../../core/components/custom_gesture_detector.dart';
import '../../../core/components/custom_icon.dart';
import '../../../core/components/custom_row.dart';
import '../../../core/components/custom_sized_box.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/resources/color_manager.dart';
import '../../../services/localization/localization.dart';

class MoreAppsButtonWidget extends StatelessWidget {
  const MoreAppsButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomExpanded(
      child: CustomGestureDetector(
        onTap: (){
          context.read<HomeCubit>().onLaunchUrl(link: AppConstants.developerLink).then((value){});

        },
        child: CustomContainer(
          alignment: Alignment.center,
          height: size.height / 15,
          decoration: BoxDecoration(
            color: ColorManager.bg2,
            borderRadius: BorderRadius.circular(5),
          ),
          child: CustomRow(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIcon(icon: Icons.more_horiz_sharp, color: ColorManager.black,),
              CustomSizedBox(width: size.width / 100,),
              CustomText(
                data: translate(context, 'moreApps'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorManager.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
