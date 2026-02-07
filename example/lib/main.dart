import 'package:flutter/material.dart';
import 'package:kclogin_flutter/kc_login_service.dart';
import 'package:kclogin_flutter/kclogin_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginExampleScreen());
  }
}

class LoginExampleScreen extends StatefulWidget {
  const LoginExampleScreen({super.key});

  @override
  State<LoginExampleScreen> createState() => _LoginExampleScreenState();
}

class _LoginExampleScreenState extends State<LoginExampleScreen> {
  final KingsLogin _kingsLogin = KingsLogin();

  bool _loading = false;
  String _status = 'Not logged in';

  Future<void> _startLogin() async {
    setState(() {
      _loading = true;
      _status = 'Starting login...';
    });

    try {
      // Init native SDK
      await _kingsLogin.init();

      // Launch OAuth flow
      final result = await _kingsLogin.login(['user', 'email', 'profile']);

      setState(() {
        _status =
            'Success!\nAuth code: ${result.authorizationCode}\nAccepted scopes: ${result.scopes.accepted.join(", ")}';
      });
    } on KingsLoginException catch (e) {
      setState(() {
        _status = 'Login failed: ${e.message}';
      });
    } catch (e) {
      setState(() {
        _status = 'Unexpected error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KC Login Plugin Example')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loading ? null : _startLogin,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Login with Kings'),
            ),
          ],
        ),
      ),
    );
  }
}
