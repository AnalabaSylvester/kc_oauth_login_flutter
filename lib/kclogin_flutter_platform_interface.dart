import 'package:kclogin_flutter/kc_login_service.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'kclogin_flutter_method_channel.dart';

abstract class KcloginFlutterPlatform extends PlatformInterface {
  /// Constructs a KcloginFlutterPlatform.
  KcloginFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static KcloginFlutterPlatform _instance = MethodChannelKcloginFlutter();

  /// The default instance of [KcloginFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelKcloginFlutter].
  static KcloginFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KcloginFlutterPlatform] when
  /// they register themselves.
  static set instance(KcloginFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // Future<String?> getPlatformVersion() {
  //   throw UnimplementedError('platformVersion() has not been implemented.');
  // }

  Future<void> init();

  Future<KingsLoginResult> login(List<String> scopes);
}
