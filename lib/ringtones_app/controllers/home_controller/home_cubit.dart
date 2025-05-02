import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/constants/app_constants.dart';
import '../../services/permission_manager/permission_manager.dart';
import 'package:android_intent_plus/flag.dart';

import '../../services/shared_preference/shared_prefs_manager.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()){
    _appLanguage = 'en';
  }

  late PermissionStatus _permissionStatus;
  PermissionStatus get permissionStatus => _permissionStatus;

  Future<PermissionStatus> getPermissionStatus()async{
    _permissionStatus = await PermissionManager.getPermissionStatus();
    emit(GetStoragePermissionStatusState());
    return _permissionStatus;
  }

  Future<void> requestStoragePermission()async{
    await PermissionManager.requestStoragePermission();
    emit(RequestStoragePermissionState());
  }

  Future<void> onLaunchUrl({required String link})async{
    final intent = AndroidIntent(
      action: 'action_view',
      data: link,
      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    await intent.launch();
  }


  final MethodChannel _channel = const MethodChannel('write_settings_permission');
  late bool _isWriteSettingsEnabled;
  bool get isWriteSettingsEnabled => _isWriteSettingsEnabled;

  Future<bool> canWriteSettings() async {
    _isWriteSettingsEnabled = false;
    _isNavigated = null;
    try {
      _isWriteSettingsEnabled = await _channel.invokeMethod('canWriteSettings');
    } catch (e) {
      _isWriteSettingsEnabled = false;
    }
    emit(OnWriteSettingsState());
    return _isWriteSettingsEnabled;
  }

  bool? _isNavigated;
  bool? get isNavigated => _isNavigated;

  Future<void> onNavigateToWriteSettings() async {
    _isNavigated = true;
    const intent = AndroidIntent(
      action: 'android.settings.action.MANAGE_WRITE_SETTINGS',
      data: 'package:${AppConstants.packageName}',
    );
    await intent.launch();
  }

  late String _appLanguage;
  String get appLanguage => _appLanguage;

  Future<void> changeAppLanguage({required String language,})async{
    await SharedPrefsManager.saveStringData(key: 'language', value: language);
    _appLanguage = SharedPrefsManager.getStringData(key: 'language');
    emit(RequestStoragePermissionState());
  }

}
