import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtones_page/widgets/loading_ads_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtones_page/widgets/ringtone_title_widget.dart';
import 'package:ringtone_app/ringtones_app/pages/ringtones_page/widgets/track_widget.dart';
import '../../controllers/admob_ads_controller/admob_ads_cubit.dart';
import '../../controllers/audio_controller/audio_cubit.dart';
import '../../core/components/bloc_consumer_widget.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_container.dart';
import '../../core/components/custom_scaffold.dart';
import '../../core/components/custom_sized_box.dart';
import '../../core/components/custom_stack.dart';
import '../../core/components/page_gradient_background.dart';
import '../../core/constants/ringtones.dart';
import '../../core/functions/navigator_pop.dart';

class RingtonesPage extends StatelessWidget {
  const RingtonesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<AudioCubit, AudioState>(
        listener: (context, state){},
        builder: (context, state){
          return BlocConsumerWidget<AdmobAdsCubit, AdmobAdsState>(
            listener: (context, state){
              if(state is ShowInterstitialAdLoadingState || state is ShowRewardedAdLoadingState){
                context.read<AudioCubit>().pause();
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
                            navigateAndPop(context);
                          },
                      ),
                      body: CustomContainer(
                        width: size.width,
                        height: size.height,
                        decoration: pageBackgroundColor(),
                        child: ListView.separated(
                          itemCount: tracks.length,
                          separatorBuilder: (context, index)=> CustomSizedBox(),
                          itemBuilder: (context, index){
                            final track = tracks[index];
                            return TrackWidget(track: track, index: index,);
                          },
                        ),
                      ),
                    ),
                    if(context.read<AdmobAdsCubit>().isAdLoading != null && context.read<AdmobAdsCubit>().isAdLoading!)
                      const LoadingAdsWidget(),
                  ],
                ),
              );
            },
          );
        },
    );
  }
}
