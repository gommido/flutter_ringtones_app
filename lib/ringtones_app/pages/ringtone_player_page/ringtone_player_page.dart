import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtone_player_page/widgets/audio_control_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtone_player_page/widgets/audio_durations_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtone_player_page/widgets/current_track_name_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtone_player_page/widgets/floating_action_button_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtone_player_page/widgets/slider_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtone_player_page/widgets/wave_image_widget.dart';
import '../../controllers/admob_ads_controller/admob_ads_cubit.dart';
import '../../controllers/audio_controller/audio_cubit.dart';
import '../../core/components/bloc_consumer_widget.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_center.dart';
import '../../core/components/custom_column.dart';
import '../../core/components/custom_container.dart';
import '../../core/components/custom_padding.dart';
import '../../core/components/custom_scaffold.dart';
import '../../core/components/custom_sized_box.dart';
import '../../core/components/custom_snack_bar.dart';
import '../../core/components/custom_stack.dart';
import '../../core/components/page_gradient_background.dart';
import '../../core/functions/navigator_pop.dart';
import '../../services/localization/localization.dart';
import '../ringtones_page/widgets/loading_ads_widget.dart';
import '../ringtones_page/widgets/ringtone_title_widget.dart';

class RingtonePlayerPage extends StatefulWidget {
  const RingtonePlayerPage({super.key,});


  @override
  State<RingtonePlayerPage> createState() => _RingtonePlayerPageState();
}

class _RingtonePlayerPageState extends State<RingtonePlayerPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AudioCubit>(context, listen: false).setTrackPath();

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<AudioCubit, AudioState>(
      listener: (context, state){
        if(state is OnPlayerStateStreamState){
          if(context.read<AudioCubit>().processingState == ProcessingState.completed){
            context.read<AudioCubit>().pause();
          }
        }
        if(state is SetRingtoneSuccessState && context.read<AudioCubit>().isSuccess != null){
          if(context.read<AudioCubit>().isSuccess!){
            context.read<AudioCubit>().setIsSuccessData();
            CustomSnackBar.show(title: translate(context, 'setSuccessfully'), context: context);
          }else{
            context.read<AudioCubit>().setIsSuccessData();
            CustomSnackBar.show(title:  translate(context, 'tryAgain'), context: context);
          }
        }
      },
      builder: (context, state){
        return PopScope(
          onPopInvokedWithResult: (didPop, s){
            context.read<AudioCubit>().pause();
          },
          child: BlocConsumerWidget<AdmobAdsCubit,AdmobAdsState>(
              listener: (context, state){
                if(state is ShowInterstitialAdLoadingState || state is ShowRewardedAdLoadingState){
                  context.read<AudioCubit>().pause();
                }
                if(state is OnAdDisposeDelaySuccessState && context.read<AdmobAdsCubit>().isAdLoading != null
                && context.read<AdmobAdsCubit>().isAdLoading!){
                  context.read<AdmobAdsCubit>().rewardedAd?.dispose();
                  context.read<AdmobAdsCubit>().interstitialAd?.dispose();
                }
              },
              builder: (context, state){
                return CustomScaffold(
                  body: CustomStack(
                    children: [
                      CustomScaffold(
                        appBar: customAppBar(
                            context: context,
                            title: const RingtoneTitleWidget(),
                            onPressed: (){
                              context.read<AudioCubit>().pause();
                              navigateAndPop(context);
                            },
                        ),
                        body: CustomContainer(
                            decoration: pageBackgroundColor(),
                          child: CustomCenter(
                            child: CustomPadding(
                              padding: const EdgeInsets.all(8.0),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: CustomColumn(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const WaveImageWidget(),
                                    CustomSizedBox(height: size.height/ 50,),
                                    const CurrentTrackNameWidget(),
                                    CustomSizedBox(height: size.height/ 50,),
                                    const SliderWidget(),
                                    CustomSizedBox(height: size.height/ 50,),
                                    const AudioDurationsWidget(),
                                    CustomSizedBox(height: size.height/ 50,),
                                    const AudioControlWidget(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        floatingActionButton: const FloatingActionButtonWidget(),
                      ),
                      if(context.read<AdmobAdsCubit>().isAdLoading != null && context.read<AdmobAdsCubit>().isAdLoading!)
                        const LoadingAdsWidget(),
                    ],
                  ),
                );
              },
          ),
        );
      },
    );
  }
}
