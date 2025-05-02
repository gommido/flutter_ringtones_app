
import 'package:ringtone_app/ringtones_app/services/shared_preference/shared_prefs_init.dart';

class SharedPrefsManager{


  static Future<bool> saveStringData({required String key, required String value}) async{
    return await SharedPrefsInit.prefs.setString(key, value);
  }

  static String getStringData({required String key}){
    return SharedPrefsInit.prefs.getString(key) ?? 'en';
  }
}