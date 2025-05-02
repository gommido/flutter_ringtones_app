import 'package:permission_handler/permission_handler.dart';


class PermissionManager {

  static Future<PermissionStatus> getPermissionStatus() async {
    PermissionStatus permissionStatus = await Permission.storage.status;
    return permissionStatus;
  }

  static Future<PermissionStatus> requestStoragePermission() async {
    final permissionStatus = await Permission.storage.request();
    return permissionStatus;
  }

}

