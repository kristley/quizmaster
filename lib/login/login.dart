import 'package:flutter/material.dart';
import '../services/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            FlutterLogo(size: 150),
            Flexible(
              child: LoginButton(
                icon: Icons.person,
                text: 'Continue as Guest',
                loginMethod: AuthService.anonLogin,
                color: Colors.deepPurple,
              ),
            ),
            Flexible(child:
              LoginButton(
                text: 'Sign in with Google',
                icon: Icons.login,
                color: Colors.blue,
                loginMethod: AuthService.googleLogin,
              ),
            )
          ],
        ),
      ),
    );
  }
}
class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  const LoginButton(
      {Key? key,
        required this.text,
        required this.icon,
        required this.color,
        required this.loginMethod})
      : super(key: key);

  final Function loginMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        onPressed: () => loginMethod(),
        label: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}