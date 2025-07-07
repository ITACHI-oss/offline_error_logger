import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class TelegramService {
  final String botToken;
  final String chatId;

  TelegramService({required this.botToken, required this.chatId});

  Future<void> sendMessage(String message, {Uint8List? screenshotBytes}) async {
    final url = Uri.parse('https://api.telegram.org/bot$botToken/sendMessage');

    final sendText = () async {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'chat_id': chatId, 'text': message}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to send message to Telegram: ${response.body}');
      }
    };

    await sendText();

    if (screenshotBytes != null) {
      final photoUrl = Uri.parse(
        'https://api.telegram.org/bot$botToken/sendPhoto',
      );
      final request =
          http.MultipartRequest('POST', photoUrl)
            ..fields['chat_id'] = chatId
            ..files.add(
              http.MultipartFile.fromBytes(
                'photo',
                screenshotBytes,
                filename: 'screenshot.png',
              ),
            );

      final response = await request.send();
      if (response.statusCode != 200) {
        throw Exception('Failed to send screenshot to Telegram.');
      }
    }
  }

  Future<void> sendPhoto(Uint8List imageBytes, String caption) async {
    final url = Uri.parse('https://api.telegram.org/bot$botToken/sendPhoto');

    final request =
        http.MultipartRequest('POST', url)
          ..fields['chat_id'] = chatId
          ..fields['caption'] = caption
          ..files.add(
            http.MultipartFile.fromBytes(
              'photo',
              imageBytes,
              filename: 'screenshot.jpg',
              contentType: MediaType('image', 'jpeg'),
            ),
          );

    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to send photo to Telegram');
    }
  }
}
