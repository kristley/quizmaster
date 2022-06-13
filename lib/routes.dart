import 'package:quizmaster/about/about.dart';
import 'package:quizmaster/profile/profile.dart';
import 'package:quizmaster/login/login.dart';
import 'package:quizmaster/topics/topics.dart';
import 'package:quizmaster/home/home.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
};