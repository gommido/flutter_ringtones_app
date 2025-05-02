import 'package:flutter/material.dart';
import '../../../core/components/custom_column.dart';
import '../../../core/components/custom_container.dart';
import '../../../core/components/custom_expanded.dart';
import 'home_page_app_bar_title_widget.dart';

class TopAppLogoWidget extends StatelessWidget {
  const TopAppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomExpanded(
      child: CustomContainer(
        alignment: Alignment.center,
        width: size.width,
        child: CustomColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomContainer(
              alignment: Alignment.center,
              width: size.width / 2,
              height: size.width / 2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const HomePageAppBarTitleWidget(),
          ],
        ),
      ),
    );
  }
}
