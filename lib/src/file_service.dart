import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileService {
  static const String _fileName = 'log.txt';

  Future<File> _getLogFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<void> write(String content) async {
    final file = await _getLogFile();
    await file.writeAsString('$content\n========\n', mode: FileMode.append);
  }

  Future<List<String>> readAll() async {
    final file = await _getLogFile();
    if (await file.exists()) {
      final content = await file.readAsString();
      return content
          .split('========\n')
          .where((e) => e.trim().isNotEmpty)
          .toList();
    }
    return [];
  }

  Future<void> clear() async {
    final file = await _getLogFile();
    if (await file.exists()) {
      await file.writeAsString('');
    }
  }
}
