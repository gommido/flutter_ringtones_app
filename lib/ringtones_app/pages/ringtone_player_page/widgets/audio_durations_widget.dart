import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controllers/audio_controller/audio_cubit.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_row.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/functions/format_audio_duration.dart';

class AudioDurationsWidget extends StatelessWidget {
  const AudioDurationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<AudioCubit, AudioState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              data: formatDuration(context.read<AudioCubit>().position),
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
            CustomText(
              data: formatDuration(context.read<AudioCubit>().currentTrackDuration),
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ],
        );
      },
    );
  }
}
