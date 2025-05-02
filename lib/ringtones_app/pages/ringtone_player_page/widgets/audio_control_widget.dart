import 'package:flutter/material.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtone_player_page/widgets/play_next_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtone_player_page/widgets/play_pause_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtone_player_page/widgets/play_previous_widget.dart';
import '../../../core/components/custom_row.dart';


class AudioControlWidget extends StatelessWidget {
  const AudioControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomRow(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        PlayPreviousWidget(),
        PlayPauseWidget(),
        PlayNextWidget(),
      ],
    );
  }
}
