import 'package:flutter_test/flutter_test.dart';
import 'package:offline_error_logger/offline_error_logger.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('LoggerService init and write works', () async {
    await OfflineErrorLogger.init(
      botToken: 'INVALID_TOKEN',
      chatId: '123456',
      userName: 'TestUser',
      phoneNumber: '+998900000000',
    );

    await OfflineErrorLogger.write('Xatolik test uchun');

    final logs = await OfflineErrorLogger.getAll();
    expect(logs.isNotEmpty, true);
    expect(logs.first.error, contains('Xatolik'));
  });
}
