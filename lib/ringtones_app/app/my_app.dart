import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/admob_ads_controller/admob_ads_cubit.dart';
import '../controllers/audio_controller/audio_cubit.dart';
import '../controllers/home_controller/home_cubit.dart';
import '../controllers/internet_connection_controller/internet_connection_cubit.dart';
import '../core/components/bloc_consumer_widget.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/themes_manager.dart';
import '../pages/home_page/home_page.dart';
import '../services/localization/localizations_delegates.dart';
import '../services/localization/supported_locales.dart';
import '../services/shared_preference/shared_prefs_manager.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=> InternetConnectionCubit()
            ..checkForInternetConnection()
            ..subscribeForNewConnection(),
        ),
        BlocProvider(
          create: (context)=> AudioCubit(),
        ),
        BlocProvider(
          create: (context)=> HomeCubit(),
        ),
        BlocProvider(
          create: (context)=> AdmobAdsCubit(),
        ),

      ],
      child: BlocConsumerWidget<InternetConnectionCubit, InternetConnectionState>(
        listener: (context, state){},
        builder: (context, state){
          return BlocConsumerWidget<HomeCubit, HomeState>(
            listener: (context, state){},
            builder: (context, state){
              return MaterialApp(
                title: AppStrings.appName,
                theme: appTheme(),
                debugShowCheckedModeBanner: false,
                locale: Locale(SharedPrefsManager.getStringData(key: 'language'),),
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: const MyHomePage(),
              );
            },
          );
        },
      ),
    );
  }
}

