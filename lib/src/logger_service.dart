import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:offline_error_logger/src/models/error_log.dart';
import 'package:offline_error_logger/src/utils/device_info.dart';
import 'package:offline_error_logger/src/file_service.dart';
import 'package:offline_error_logger/src/telegram_service.dart';

class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  factory LoggerService() => _instance;

  LoggerService._internal();

  late TelegramService _telegramService;
  late FileService _fileService;
  late String _userName;
  late String _phoneNumber;
  bool _isInitialized = false;

  Future<void> init({
    required String botToken,
    required String chatId,
    required String userName,
    required String phoneNumber,
  }) async {
    _telegramService = TelegramService(botToken: botToken, chatId: chatId);
    _fileService = FileService();
    _userName = userName;
    _phoneNumber = phoneNumber;
    _isInitialized = true;

    Connectivity().onConnectivityChanged.listen((status) {
      if (status != ConnectivityResult.none) {
        flush();
      }
    });
  }

  Future<void> write(String error) async {
    if (!_isInitialized) throw Exception('LoggerService is not initialized');

    final deviceInfo = await DeviceInfoUtil.getDeviceInfo();

    final log = ErrorLog(
      userName: _userName,
      phoneNumber: _phoneNumber,
      device: deviceInfo['device'] ?? '',
      osVersion: deviceInfo['version'] ?? '',
      error: error,
      time: DateTime.now(),
    );

    await _fileService.write(log.toString());

    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity != ConnectivityResult.none) {
      await _telegramService.sendMessage(log.toTelegramText());
    }
  }

  Future<List<ErrorLog>> getAll() async {
    final lines = await _fileService.readAll();
    return lines.map((line) => ErrorLog.fromString(line)).toList();
  }

  Future<void> flush() async {
    final logs = await _fileService.readAll();

    for (var log in logs) {
      await _telegramService.sendMessage(log);
    }

    await _fileService.clear();
  }
}
