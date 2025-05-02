import 'package:flutter/material.dart';

import '../../../core/components/custom_container.dart';

class WaveImageWidget extends StatelessWidget {
  const WaveImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      width: size.width / 4,
      height: size.height / 6,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/waves.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
