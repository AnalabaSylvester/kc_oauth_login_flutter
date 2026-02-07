import 'package:flutter_test/flutter_test.dart';
import 'package:kclogin_flutter/kclogin_flutter.dart';
import 'package:kclogin_flutter/kclogin_flutter_platform_interface.dart';
import 'package:kclogin_flutter/kclogin_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKcloginFlutterPlatform
    with MockPlatformInterfaceMixin
    implements KcloginFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final KcloginFlutterPlatform initialPlatform = KcloginFlutterPlatform.instance;

  test('$MethodChannelKcloginFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKcloginFlutter>());
  });

  test('getPlatformVersion', () async {
    KcloginFlutter kcloginFlutterPlugin = KcloginFlutter();
    MockKcloginFlutterPlatform fakePlatform = MockKcloginFlutterPlatform();
    KcloginFlutterPlatform.instance = fakePlatform;

    expect(await kcloginFlutterPlugin.getPlatformVersion(), '42');
  });
}
