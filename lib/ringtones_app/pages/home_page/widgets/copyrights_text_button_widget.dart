import 'package:flutter/material.dart';
import '../../../core/components/custom_alert_dialog.dart';
import '../../../core/components/custom_sized_box.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/functions/navigator_pop.dart';
import '../../../core/resources/color_manager.dart';
import '../../../services/localization/localization.dart';

class CopyrightsTextButtonWidget extends StatelessWidget {
  const CopyrightsTextButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: (){
        showDialog(
          context: context,
          builder: (context){
            return customAlertDialog(
              context: context,
              height: size.height / 2,
              children: [
                CustomText(
                  data: translate(context, 'allRightsReserved'),
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                CustomSizedBox(height: size.height / 100,),
                CustomText(
                  data: translate(context, 'reportCopyright'),
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                CustomSizedBox(height: size.height / 100,),
                CustomText(
                  data: translate(context, 'artworkWillBeDeleted'),
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                CustomSizedBox(height: size.height / 25,),
                CustomText(
                  data: AppConstants.developerContactEmail,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorManager.blue
                  ),
                ),
              ],
              actions: [
                TextButton(
                  onPressed: (){
                    navigateAndPop(context);
                  },
                  child: CustomText(
                    data: translate(context, 'close'),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorManager.blue,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: CustomText(
        data: translate(context, 'copyrights'),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: ColorManager.blue,
        ),
      ),
    );
  }
}

