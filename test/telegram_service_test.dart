import 'package:flutter_test/flutter_test.dart';
import 'package:offline_error_logger/src/telegram_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final service = TelegramService(
    botToken: 'INVALID_BOT_TOKEN',
    chatId: '123456789',
  );

  test('sendMessage throws exception with invalid token', () async {
    try {
      await service.sendMessage('Test message');
      fail('Should throw exception');
    } catch (e) {
      expect(e.toString(), contains('Failed to send message to Telegram'));
    }
  });
}
