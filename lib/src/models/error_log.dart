class ErrorLog {
  final String userName;
  final String phoneNumber;
  final String device;
  final String osVersion;
  final String error;
  final DateTime time;

  ErrorLog({
    required this.userName,
    required this.phoneNumber,
    required this.device,
    required this.osVersion,
    required this.error,
    required this.time,
  });

  @override
  String toString() {
    return '''
User: $userName
Phone: $phoneNumber
Device: $device
OS Version: $osVersion
Time: ${time.toIso8601String()}
Error: $error
''';
  }

  String toTelegramText() {
    return '''
📱 Device: $device
👤 User: $userName
📞 Phone: $phoneNumber
❗️ Error: $error
🕒 Time: ${time.toLocal()}
''';
  }

  factory ErrorLog.fromString(String content) {
    return ErrorLog(
      userName: '',
      phoneNumber: '',
      device: '',
      osVersion: '',
      error: content,
      time: DateTime.now(),
    );
  }
}
