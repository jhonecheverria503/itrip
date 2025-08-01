import 'package:permission_handler/permission_handler.dart';

class PermissionsApp {
  static Future<void> requestPermission() async {
    bool locationGranted = await Permission.location.isGranted;
    if (!locationGranted) {
      await Permission.location.request();
    }
  }
}
