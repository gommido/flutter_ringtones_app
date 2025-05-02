import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtone_player_page/widgets/ringtone_type_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtone_player_page/widgets/show_ringtone_setter_widget.dart';
import '../../../controllers/admob_ads_controller/admob_ads_cubit.dart';
import '../../../controllers/audio_controller/audio_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_gesture_detector.dart';
import '../../../core/components/custom_icon.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/show_ads_dialog.dart';
import '../../../core/functions/show_permissions_dialog.dart';
import '../../../core/resources/color_manager.dart';
import '../../../services/localization/localization.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumerWidget<AdmobAdsCubit, AdmobAdsState>(
        listener: (context, state) {},
        builder: (context, state){
          return BlocConsumerWidget<HomeCubit, HomeState>(
            listener: (context, state) {
              if(state is RequestStoragePermissionState){
                context.read<HomeCubit>().getPermissionStatus();
              }
              if(state is OnWriteSettingsState){
                if(!context.read<HomeCubit>().isWriteSettingsEnabled){
                  if(context.read<HomeCubit>().isNavigated == null){
                    context.read<HomeCubit>().onNavigateToWriteSettings();
                  }
                }
              }
            },
            builder: (context, state) {
              if(context.read<HomeCubit>().permissionStatus != PermissionStatus.granted ||
                  !context.read<HomeCubit>().isWriteSettingsEnabled ||
                  !context.read<AdmobAdsCubit>().isAdDismissed){
                return CustomGestureDetector(
                  onTap: (){
                    context.read<AudioCubit>().pause();
                    if(context.read<HomeCubit>().permissionStatus != PermissionStatus.granted ||
                        !context.read<HomeCubit>().isWriteSettingsEnabled){
                      showPermissionsDialog(
                        context: context,
                        onTapFirstPermission: (){
                          context.read<HomeCubit>().requestStoragePermission();
                        },
                        onTapSecondPermission: (){
                          context.read<HomeCubit>().canWriteSettings();
                        },
                      );
                    }else{
                      showAdsDialog(context: context,);
                    }

                  },
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: ColorManager.pink,
                    child: CustomIcon(icon: Icons.notifications_active, color: ColorManager.white,),
                  ),
                );
              }
              return ShowRingtoneSetterWidget(
                icon: Icons.notifications_active,
                children: [
                  ringtoneTypeWidget(
                    context: context,
                    icon: Icons.alarm,
                    label: CustomText(
                      data: translate(context, 'setAlarm'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorManager.black ,),
                    ),
                    onTap: (){
                      context.read<AudioCubit>().setRingtone(type: AppStrings.alarm,);
                    },
                  ),

                  ringtoneTypeWidget(
                    context: context,
                    icon: Icons.notifications,
                    label: CustomText(
                      data: translate(context, 'setNotification'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorManager.black ,),
                    ),
                    onTap: (){
                      context.read<AudioCubit>().setRingtone(type: AppStrings.notification,);
                    },
                  ),

                  ringtoneTypeWidget(
                    context: context,
                    icon: Icons.phonelink_ring,
                    label: CustomText(
                      data: translate(context, 'setRingtone'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorManager.black ,),
                    ),
                    onTap: (){
                      context.read<AudioCubit>().setRingtone(type: AppStrings.ringtone,);
                    },
                  ),
                ],
              );
            },
          );
        },
    );
  }
}
