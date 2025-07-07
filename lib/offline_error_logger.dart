import 'dart:typed_data';
import 'package:offline_error_logger/src/models/error_log.dart';
import 'src/logger_service.dart';

class OfflineErrorLogger {
  static final _service = LoggerService();

  static Future<void> init({
    required String botToken,
    required String chatId,
    required String userName,
    required String phoneNumber,
  }) {
    return _service.init(
      botToken: botToken,
      chatId: chatId,
      userName: userName,
      phoneNumber: phoneNumber,
    );
  }

  static Future<void> write(String error, {Uint8List? screenshotBytes}) =>
      _service.write(error, screenshotBytes: screenshotBytes);

  static Future<List<ErrorLog>> getAll() => _service.getAll();

  static Future<void> flush() => _service.flush();
}
