import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controllers/admob_ads_controller/admob_ads_cubit.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_column.dart';
import '../../../core/components/custom_container.dart';
import '../../../core/components/custom_sized_box.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/resources/color_manager.dart';
import '../../../services/localization/localization.dart';

class LoadingAdsWidget extends StatelessWidget {
  const LoadingAdsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<AdmobAdsCubit, AdmobAdsState>(
      listener: (context, state){
        if(state is OnAdDisposeDelaySuccessState && context.read<AdmobAdsCubit>().isAdLoading != null){
          context.read<AdmobAdsCubit>().disposeAd();
        }
      },
      builder: (context, state){
        if(context.read<AdmobAdsCubit>().isAdLoading != null){
          return CustomContainer(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: ColorManager.black.withOpacity(0.7),
            ),
            child: CustomColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  data: translate(context, 'loadingAd'),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorManager.white,
                  ),
                ),
                CustomSizedBox(height: size.height / 50,),
                const LinearProgressIndicator(
                  color: ColorManager.teal,
                ),
              ],
            ),
          );
        }
        return CustomSizedBox();
      },
    );
  }
}
