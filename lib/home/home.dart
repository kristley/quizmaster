import 'package:flutter/material.dart';
import 'package:quizmaster/login/login.dart';
import '../services/auth.dart';
import '../shared/TopicsAboutProfile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        if (snapshot.hasError) {
          return const Text('Error');
        }
        return snapshot.hasData
            ? const TopicsAboutProfileScreen()
            : const LoginScreen();
      },
    );
  }
}
