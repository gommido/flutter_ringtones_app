import 'package:flutter/cupertino.dart';

import '../resources/color_manager.dart';

BoxDecoration pageBackgroundColor(){
  return BoxDecoration(
      gradient: LinearGradient(
        begin: AlignmentDirectional.topCenter,
        end: AlignmentDirectional.bottomCenter,
        colors: [
          ColorManager.backgroundColor.withOpacity(0.1),
          ColorManager.black,
        ],
      )
  );
}