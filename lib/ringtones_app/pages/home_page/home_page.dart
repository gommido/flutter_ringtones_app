
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ringtone_app/ringtones_app/pages/home_page/widgets/copyrights_text_button_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/home_page/widgets/more_apps_button_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/home_page/widgets/privacy_policy_button_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/home_page/widgets/rate_app_button_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/home_page/widgets/ringtones_button_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/home_page/widgets/top_app_logo_widget.dart';
import '../../controllers/admob_ads_controller/admob_ads_cubit.dart';
import '../../controllers/audio_controller/audio_cubit.dart';
import '../../controllers/home_controller/home_cubit.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_center.dart';
import '../../core/components/custom_column.dart';
import '../../core/components/custom_container.dart';
import '../../core/components/custom_expanded.dart';
import '../../core/components/custom_icon.dart';
import '../../core/components/custom_icon_button.dart';
import '../../core/components/custom_padding.dart';
import '../../core/components/custom_row.dart';
import '../../core/components/custom_scaffold.dart';
import '../../core/components/custom_sized_box.dart';
import '../../core/components/page_gradient_background.dart';
import '../../core/resources/color_manager.dart';
import '../../services/shared_preference/shared_prefs_manager.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AudioCubit _audioCubit;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context, listen: false).getPermissionStatus();
    BlocProvider.of<HomeCubit>(context, listen: false).canWriteSettings();
    _audioCubit =  BlocProvider.of<AudioCubit>(context, listen:  false);
    _audioCubit.onPlayListener();
    _audioCubit.getAudioDurations();
    _audioCubit.onPlayerStateStream();
    BlocProvider.of<AdmobAdsCubit>(context, listen:  false).createAppOpenAd();
  }

  @override
  void dispose() {
    _audioCubit.disposeAudioPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      bottom: false,
      child: CustomScaffold(
        backgroundColor: ColorManager.black,
        appBar: customAppBar(
          context: context,
          isLeadingIconShown: false,
          actions: [
            CustomIconButton(
            onPressed: (){
              context.read<HomeCubit>().changeAppLanguage(
                  language: SharedPrefsManager.getStringData(key: 'language') == 'en' ? 'ar' : 'en',
              );
            }, 
              icon: CustomIcon(icon: Icons.translate, color: ColorManager.white,),
            )
          ]
        ),
        body: CustomCenter(
          child: CustomContainer(
            width: size.width,
            height: size.height,
            decoration: pageBackgroundColor(),
            child: CustomColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TopAppLogoWidget(),
                CustomSizedBox(height: size.height / 100,),
                CustomExpanded(
                  child: CustomPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                    child: CustomContainer(
                      width: size.width,
                      child: CustomColumn(
                        children: [
                          CustomRow(
                            children: [
                              const RingtonesButtonWidget(),
                              CustomSizedBox(width: size.width / 50,),
                              const PrivacyPolicyButtonWidget(),
                            ],
                          ),
                          CustomSizedBox(height: size.height / 50,),
                          CustomRow(
                            children: [
                              const MoreAppsButtonWidget(),
                              CustomSizedBox(width: size.width / 50,),
                              const RateAppButtonWidget(),
                            ],
                          ),
                          CustomSizedBox(height: size.height / 100,),
                          const CopyrightsTextButtonWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
