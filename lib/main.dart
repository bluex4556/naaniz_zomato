import 'package:flutter/material.dart';
import 'package:zomato/screens/home_screen.dart';

import 'AuthService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthService.handleAuth(),
      routes: {
        "/home" : (_)=>HomeScreen(),
      },
    );
  }
}
