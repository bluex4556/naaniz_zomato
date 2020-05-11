import 'package:flutter/material.dart';
import 'package:zomato/screens/home_screen.dart';
import 'package:zomato/screens/restaurant_detail.dart';

import 'AuthService.dart';
import 'screens/add_meal_screen.dart';

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
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: AuthService.handleAuth(),
      routes: {
        "/home" : (_)=>HomeScreen(),
        "/detail" : (_)=>RestaurantDetail(),
        "/add-meal": (_)=>AddMealScreen(),
      },
    );
  }
}
