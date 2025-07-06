import 'dart:convert';
import 'package:http/http.dart' as http;

class TelegramService {
  final String botToken;
  final String chatId;

  TelegramService({required this.botToken, required this.chatId});

  Future<void> sendMessage(String message) async {
    final url = Uri.parse('https://api.telegram.org/bot$botToken/sendMessage');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'chat_id': chatId, 'text': message}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message to Telegram: ${response.body}');
    }
  }
}
