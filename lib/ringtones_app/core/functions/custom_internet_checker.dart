import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/internet_connection_controller/internet_connection_cubit.dart';
import '../../services/localization/localization.dart';
import '../components/custom_snack_bar.dart';

class CustomInternetChecker{
  static void checkInternetAvailability({
    required BuildContext context,
    required VoidCallback onInternetAvailable,
    bool? isShowing,
}){
    if(!context.read<InternetConnectionCubit>().connectivityResult.contains(ConnectivityResult.none)){
      onInternetAvailable();
    }else{
      if(isShowing == null){
        CustomSnackBar.show(
          title: translate(context, 'noInternet'),
          context: context,
        );
      }
    }
  }
}