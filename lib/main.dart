import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:quizmaster/shared/loading.dart';
import 'package:quizmaster/routes.dart';
import 'package:quizmaster/theme.dart';
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const LoadingScreen();
        }
        return dynamicThemedApp();
      },
    );
  }

  ChangeNotifierProvider<ThemeProvider> dynamicThemedApp() {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
          builder: (context, themeNotifier, child) {
            return MaterialApp(
              routes: appRoutes,
              themeMode: themeNotifier.themeMode,
              theme: appTheme,
              darkTheme: appDarkTheme,
            );
          }),
    );
  }
}