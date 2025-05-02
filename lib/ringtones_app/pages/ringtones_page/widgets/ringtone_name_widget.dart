import 'package:flutter/material.dart';
import '../../../core/components/custom_column.dart';
import '../../../core/components/custom_container.dart';
import '../../../core/components/custom_sized_box.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/functions/format_audio_duration.dart';
import '../../../core/resources/color_manager.dart';
import '../../../models/track_model.dart';

class RingtoneNameWidget extends StatelessWidget {
  const RingtoneNameWidget({super.key, required this.track, required this.duration});
  final TrackModel track;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: const BoxDecoration(
          color: Colors.transparent
      ),
      child: CustomColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            data:  track.name,
            style: Theme.of(context).textTheme.bodyLarge!,
          ),
          CustomSizedBox(height: size.height / 100,),

          CustomText(
            data: formatDuration(duration),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: ColorManager.white.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
