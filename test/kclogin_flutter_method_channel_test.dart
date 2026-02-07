import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kclogin_flutter/kclogin_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelKcloginFlutter platform = MethodChannelKcloginFlutter();
  const MethodChannel channel = MethodChannel('kclogin_flutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
