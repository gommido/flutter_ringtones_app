import 'package:flutter/cupertino.dart';

void navigateAndPop(context){
  return Navigator.of(context).pop();
}

void navigateAndPopUntil({required BuildContext context, required String routeName}){
  return Navigator.of(context).popUntil((route) => route.isFirst);
}