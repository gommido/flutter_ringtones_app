import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../../controllers/audio_controller/audio_cubit.dart';
import '../../../core/components/custom_icon.dart';
import '../../../core/resources/color_manager.dart';

class ShowRingtoneSetterWidget extends StatelessWidget {
  const ShowRingtoneSetterWidget({super.key, required this.children, required this.icon,});
  final List<SpeedDialChild> children;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      onOpen: (){
        context.read<AudioCubit>().pause();
      },
      backgroundColor: ColorManager.pink,
      direction: SpeedDialDirection.up,
      overlayOpacity: 0.0,
      children: children,
      child: CustomIcon(
        icon: icon,
        color: ColorManager.white,
      ),
    );
  }
}


