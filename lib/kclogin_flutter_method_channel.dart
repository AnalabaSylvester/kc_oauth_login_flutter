import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kclogin_flutter/kc_login_service.dart';

import 'kclogin_flutter_platform_interface.dart';


class MethodChannelKcloginFlutter extends KcloginFlutterPlatform {
  @visibleForTesting
  final methodChannel =
      const MethodChannel('com.yourdomain/kclogin_flutter');

  @override
  Future<void> init() async {
    await methodChannel.invokeMethod('init');
  }

  @override
  Future<KingsLoginResult> login(List<String> scopes) async {
    final result =
        await methodChannel.invokeMapMethod<String, dynamic>('login', {
      'scopes': scopes,
    });

    if (result == null) {
      throw KingsLoginException('No result from native');
    }

    final status = result['status'];

    if (status == 'success') {
      return KingsLoginResult(
        authorizationCode: result['authorization_code'],
        scopes: KcScopes.fromMap(result['scopes']),
      );
    }

    if (status == 'cancel') {
      throw KingsLoginException('User cancelled');
    }

    throw KingsLoginException('Unknown error');
  }
}
