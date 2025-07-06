import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoUtil {
  static Future<Map<String, String>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return {
        'device': 'Android',
        'version': 'SDK ${info.version.sdkInt}',
        'model': info.model,
      };
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return {
        'device': 'iOS',
        'version': info.systemVersion,
        'model': info.utsname.machine,
      };
    } else {
      return {'device': 'Unknown', 'version': 'Unknown', 'model': 'Unknown'};
    }
  }
}
