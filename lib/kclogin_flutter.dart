
import 'package:kclogin_flutter/kc_login_service.dart';

import 'kclogin_flutter_platform_interface.dart';

class KingsLogin {
  Future<void> init() {
    return KcloginFlutterPlatform.instance.init();
  }

  Future<KingsLoginResult> login(List<String> scopes) {
    return KcloginFlutterPlatform.instance.login(scopes);
  }
}
