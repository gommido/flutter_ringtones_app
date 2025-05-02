import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ringtone_app/ringtones_app/app/my_app.dart';
import 'package:ringtone_app/ringtones_app/services/shared_preference/shared_prefs_init.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,],);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,);
  await MobileAds.instance.initialize();
  await SharedPrefsInit.initSharedPref();
  runApp(const MyApp());
}
