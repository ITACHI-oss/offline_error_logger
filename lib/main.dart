import 'package:flutter/material.dart';
import 'package:offline_error_logger/offline_error_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await OfflineErrorLogger.init(
    botToken: '8128429434:AAFBSQq0dzWek2bHqixCzqjaMl7nr0xl4Rg',
    chatId: '7566157131',
    userName: 'Miraziz',
    phoneNumber: '+998901234567',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Logger Tester')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await OfflineErrorLogger.write(
                "❗️ Sample error from test button",
              );
            },
            child: const Text('Trigger Error'),
          ),
        ),
      ),
    );
  }
}
