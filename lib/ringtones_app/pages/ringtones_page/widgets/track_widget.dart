
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtones_page/widgets/ringtone_name_widget.dart';
import '../../../controllers/admob_ads_controller/admob_ads_cubit.dart';
import '../../../controllers/audio_controller/audio_cubit.dart';
import '../../../controllers/internet_connection_controller/internet_connection_cubit.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_container.dart';
import '../../../core/components/custom_gesture_detector.dart';
import '../../../core/components/custom_row.dart';
import '../../../core/components/custom_sized_box.dart';
import '../../../core/functions/fade_animation.dart';
import '../../../core/resources/color_manager.dart';
import '../../../models/track_model.dart';
import '../../ringtone_player_page/ringtone_player_page.dart';

class TrackWidget extends StatelessWidget {
  const TrackWidget({super.key, required this.track, required this.index,});
  final TrackModel track;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<AudioCubit, AudioState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomGestureDetector(
          onTap: (){
            context.read<AdmobAdsCubit>().increaseClicksNumber();
            if(context.read<AdmobAdsCubit>().clicksNumber == 10){
              if(!context.read<InternetConnectionCubit>().connectivityResult.contains(ConnectivityResult.none)){
                context.read<AdmobAdsCubit>().createInterstitialAd();
              }else{
                context.read<AudioCubit>().setCurrentTrack(track);
                context.read<AudioCubit>().setCurrentTrackDuration(track.id);
                Navigator.of(context).push(
                  navigateFadeAnimation(widget: const RingtonePlayerPage(),
                  ),
                );
              }
            }else{
              context.read<AudioCubit>().setCurrentTrack(track);
              context.read<AudioCubit>().setCurrentTrackDuration(track.id);
              Navigator.of(context).push(
                navigateFadeAnimation(widget: const RingtonePlayerPage(),
                ),
              );
            }
          },
          child: CustomContainer(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            width: size.width,
            height: size.height / 12,
            decoration: const BoxDecoration(
              color: ColorManager.transparent,
            ),
            child: CustomRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomContainer(
                  width: size.height / 200,
                  height: size.height / 14,
                  decoration: const BoxDecoration(
                    color: ColorManager.teal,
                  ),
                ),
                CustomSizedBox(width: size.width / 50,),
                CustomContainer(
                  width: size.height / 14,
                  height: size.height / 14,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.white.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                CustomSizedBox(width: size.width / 50,),
                RingtoneNameWidget(track: track, duration: context.read<AudioCubit>().durations[index],),
              ],
            ),
          ),
        );
      },
    );
  }
}
