import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../controllers/audio_controller/audio_cubit.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_container.dart';
import '../../../core/components/custom_gesture_detector.dart';
import '../../../core/components/custom_icon.dart';
import '../../../core/resources/color_manager.dart';

class PlayPauseWidget extends StatelessWidget {
  const PlayPauseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<AudioCubit, AudioState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomGestureDetector(
          onTap: (){
            if(context.read<AudioCubit>().player.playing){
              context.read<AudioCubit>().pause();
            }else{
              if(context.read<AudioCubit>().processingState == ProcessingState.completed){
                context.read<AudioCubit>().setTrackPath();
              }else{
                context.read<AudioCubit>().play();
              }
            }
          },
          child: CustomContainer(
            width: size.width / 6,
            height: size.width / 6,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorManager.pink,
            ),
            child: CustomIcon(
              icon: context.read<AudioCubit>().player.playing ? Icons.pause : Icons.play_arrow,
              size: size.width / 12,
              color: ColorManager.white,
            ),
          ),
        );
      },
    );
  }
}
