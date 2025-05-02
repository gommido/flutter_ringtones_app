import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/admob_ads_controller/admob_ads_cubit.dart';
import '../../services/localization/localization.dart';
import '../components/custom_alert_dialog.dart';
import '../components/custom_expanded.dart';
import '../components/custom_text.dart';
import '../functions/navigator_pop.dart';
import '../resources/color_manager.dart';
import 'custom_internet_checker.dart';

void showAdsDialog({
  required BuildContext context,
}){
  final size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (context){
      return customAlertDialog(
          context: context,
          height: size.height / 10,
          children: [
            CustomExpanded(
              child: CustomText(
                data: translate(context, 'watchAd'),
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
            ),
          ],
          actions: [
            TextButton(
              onPressed: (){
                navigateAndPop(context);
                CustomInternetChecker.checkInternetAvailability(
                  context: context,
                  onInternetAvailable: (){
                    context.read<AdmobAdsCubit>().createRewardedAd();
                  },
                );
              },
              child: CustomText(
                data: translate(context, 'watch'),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorManager.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: (){
                navigateAndPop(context);
              },
              child: CustomText(
                data: translate(context, 'no'),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorManager.blue,
                ),
              ),
            ),
          ]
      );
    },
  );
}
