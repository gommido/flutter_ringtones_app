import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/audio_controller/audio_cubit.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_text.dart';

class CurrentTrackNameWidget extends StatelessWidget {
  const CurrentTrackNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<AudioCubit, AudioState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomText(
          data: context.read<AudioCubit>().currentTrack.name,
          style: Theme.of(context).textTheme.bodyLarge!,
        );
      },
    );
  }
}
