import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaster/theme.dart';

import '../services/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: const [
          ThemeDropDown(),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
              child: const Text('sign out'),
              onPressed: () async {
                await AuthService.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              }),
        ],
      ),
    );
  }
}

class ThemeDropDown extends StatefulWidget {
  const ThemeDropDown({Key? key}) : super(key: key);

  @override
  State<ThemeDropDown> createState() => _ThemeDropDownState();
}

class _ThemeDropDownState extends State<ThemeDropDown> {

  static const items = ['System default',  'Light mode', 'Dark mode'];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangeNotifier>(
      builder: (_, themeNotifier, __){
        return DropdownButton<ThemeMode>(
          value: themeNotifier.themeMode,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurpleAccent),
          underline: Container(
            height: 2,
            color: Colors.deepPurple[300],
          ),
          onChanged: (newValue) {
            setState(() => themeNotifier.themeMode = newValue!);
          },
          items: ThemeMode.values.map((ThemeMode themeMode) {
            return DropdownMenuItem<ThemeMode >(
                value: themeMode,
                child: Text(items[themeMode.index]));
          }).toList(),
        );
      }
    );
  }
}
