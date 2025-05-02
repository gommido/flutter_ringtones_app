import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/admob_ads_controller/admob_ads_cubit.dart';
import '../../../controllers/audio_controller/audio_cubit.dart';
import '../../../controllers/internet_connection_controller/internet_connection_cubit.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_icon.dart';
import '../../../core/components/custom_icon_button.dart';
import '../../../core/constants/ringtones.dart';
import '../../../core/resources/color_manager.dart';

class PlayNextWidget extends StatelessWidget {
  const PlayNextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomIconButton(
      onPressed: (){
        if(context.read<AudioCubit>().currentTrack.id != tracks.length - 1){
          context.read<AudioCubit>().pause();
          context.read<AdmobAdsCubit>().increaseClicksNumber();
          if(context.read<AdmobAdsCubit>().clicksNumber == 10){
            if(!context.read<InternetConnectionCubit>().connectivityResult.contains(ConnectivityResult.none)){
              context.read<AdmobAdsCubit>().createInterstitialAd();
            }else{
              context.read<AudioCubit>().setCurrentTrackDuration(context.read<AudioCubit>().currentTrack.id + 1);
              context.read<AudioCubit>().setCurrentTrack(tracks[context.read<AudioCubit>().currentTrack.id + 1]);
              context.read<AudioCubit>().setTrackPath();
            }
          }else{
            context.read<AudioCubit>().setCurrentTrackDuration(context.read<AudioCubit>().currentTrack.id + 1);
            context.read<AudioCubit>().setCurrentTrack(tracks[context.read<AudioCubit>().currentTrack.id + 1]);
            context.read<AudioCubit>().setTrackPath();
          }
        }
      },
      icon: BlocConsumerWidget<AudioCubit, AudioState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomIcon(
            icon: Icons.skip_next,
            size: size.width / 10,
            color: context.read<AudioCubit>().currentTrack.id == tracks.length - 1 ?
            ColorManager.white.withOpacity(0.2) :
            ColorManager.white,
          );
        },
      ),
    );
  }
}
