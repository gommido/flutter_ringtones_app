import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../controllers/home_controller/home_cubit.dart';
import '../../services/localization/localization.dart';
import '../components/bloc_consumer_widget.dart';
import '../components/custom_alert_dialog.dart';
import '../components/custom_column.dart';
import '../components/custom_container.dart';
import '../components/custom_expanded.dart';
import '../components/custom_gesture_detector.dart';
import '../components/custom_icon.dart';
import '../components/custom_row.dart';
import '../components/custom_sized_box.dart';
import '../components/custom_text.dart';
import '../resources/color_manager.dart';
import 'navigator_pop.dart';


void showPermissionsDialog({
  required BuildContext context,
  required void Function() onTapFirstPermission,
  required void Function() onTapSecondPermission,
}){
  final size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (context){
      return customAlertDialog(
        context: context,
        height: size.height / 2,
        children: [
          CustomExpanded(
            child: CustomContainer(
              child: CustomColumn(
                children: [
                  CustomContainer(
                    width: size.width / 10,
                    height: size.width / 10,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/lock.webp'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CustomSizedBox(height: size.height / 50,),
                  CustomText(
                    data: translate(context, 'requiredPermissions'),
                    style: Theme.of(context).textTheme.bodyLarge!,
                  ),
                ],
              ),
            ),
          ),
          CustomExpanded(
            child: CustomContainer(
              child: BlocConsumerWidget<HomeCubit, HomeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if(context.watch<HomeCubit>().permissionStatus == PermissionStatus.granted){
                    return CustomRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          data: translate(context, 'accessFiles'),
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                        CustomIcon(icon: Icons.done, color: ColorManager.green,),
                      ],
                    );
                  }
                  return CustomColumn(
                    children: [
                      CustomText(
                        data: translate(context, 'allowAccessFiles'),
                        style: Theme.of(context).textTheme.bodyMedium!,
                      ),
                      CustomSizedBox(height: size.height / 50,),
                      CustomGestureDetector(
                        onTap: onTapFirstPermission,
                        child: CustomContainer(
                          alignment: Alignment.center,
                          width: size.width,
                          height: size.width / 12,
                          decoration: BoxDecoration(
                              color: ColorManager.teal,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: CustomText(
                            data: translate(context, 'allow'),
                            style: Theme.of(context).textTheme.bodyMedium!,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          CustomExpanded(
            child: CustomContainer(
              child: BlocConsumerWidget<HomeCubit, HomeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if(context.read<HomeCubit>().isWriteSettingsEnabled){
                    return CustomRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          data: translate(context, 'modify'),
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                        CustomIcon(icon: Icons.done, color: ColorManager.green,),
                      ],
                    );
                  }
                  return CustomColumn(
                    children: [
                      CustomText(
                        data: translate(context, 'allowModifySystem'),
                        style: Theme.of(context).textTheme.bodyMedium!,
                      ),
                      CustomSizedBox(height: size.height / 50,),
                      CustomGestureDetector(
                        onTap: onTapSecondPermission,
                        child: CustomContainer(
                          alignment: Alignment.center,
                          width: size.width,
                          height: size.width / 12,
                          decoration: BoxDecoration(
                              color: ColorManager.teal,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: CustomText(
                            data: translate(context, 'allow'),

                            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorManager.white,),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
        actions: [
          BlocConsumerWidget<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if(context.watch<HomeCubit>().permissionStatus == PermissionStatus.granted &&
                  context.read<HomeCubit>().isWriteSettingsEnabled){
                return CustomGestureDetector(
                  onTap: (){
                    navigateAndPop(context);
                  },
                  child: CustomContainer(
                    alignment: Alignment.center,
                    width: size.width,
                    height: size.width / 12,
                    decoration: BoxDecoration(
                        color: ColorManager.red,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: CustomText(
                      data: translate(context, 'done'),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorManager.white,),
                    ),
                  ),
                );
              }
              return CustomSizedBox();
            },
          ),
        ],
      );
    },
  );
}

