import 'package:flutter_test/flutter_test.dart';
import 'package:offline_error_logger/src/file_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late FileService fileService;

  setUp(() {
    fileService = FileService();
  });

  test('write and read log file', () async {
    await fileService.clear(); // tozalaymiz
    await fileService.write('Test error 1');
    await fileService.write('Test error 2');

    final logs = await fileService.readAll();
    expect(logs.length, 2);
    expect(logs[0].contains('Test error 1'), true);
    expect(logs[1].contains('Test error 2'), true);
  });

  test('clear log file', () async {
    await fileService.write('To be cleared');
    await fileService.clear();

    final logs = await fileService.readAll();
    expect(logs.isEmpty, true);
  });
}
