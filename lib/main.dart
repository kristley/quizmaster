import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:quizmaster/services/firestore.dart';
import 'package:quizmaster/services/models.dart';
import 'package:quizmaster/shared/loading.dart';
import 'package:quizmaster/routes.dart';
import 'package:quizmaster/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  late SharedPreferences _sharedPrefs;

  Future<void> _getPrefs() async{
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_initialization, _getPrefs()]),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState != ConnectionState.done || !snapshot.hasData) {
          return const LoadingScreen();
        }
        return dynamicThemedApp();
      },
    );
  }

  MultiProvider dynamicThemedApp() {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeChangeNotifier(_sharedPrefs), lazy: false),
          StreamProvider(create: (_) => FirestoreService.streamReport(), initialData: Report())
        ],
        child: Consumer<ThemeChangeNotifier>(
            builder: (_, ThemeChangeNotifier notifier, __) {
              return MaterialApp(
                routes: appRoutes,
                themeMode: notifier.themeMode,
                theme: appTheme,
                darkTheme: appDarkTheme,
              );
            }),
    );
  }
}