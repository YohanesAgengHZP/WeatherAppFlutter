import 'package:flutter/material.dart';
import 'package:weather_app/HomePage.dart';
import 'LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Cuaca',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.blue
        ),
      ),
      home: login_screen(),
    );
  }
}

