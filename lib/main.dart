import 'package:boilerplate_flutter/src/user_preferences/user_preferences.dart';
import 'package:flutter/material.dart';

import 'src/screens/home_screen.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/signup_screen.dart';

import 'package:boilerplate_flutter/src/blocs/provider.dart';

void main() async {
  final prefs = new UserPreferences();

  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new UserPreferences();
    print(prefs.token);
    print(prefs.name);

    return Provider(
      child: MaterialApp(
        title: 'Boilerplate-app Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color.fromARGB(255, 4, 125, 141)),
        routes: {
          '/home': (context) => HomeScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
        },
        home: LoginScreen(),
      ),
    );
  }
}
