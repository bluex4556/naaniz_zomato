import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

class AuthService {
  static String userId;

  static handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          FirebaseUser loggedInUser = snapshot.data as FirebaseUser;
          userId = loggedInUser.uid;
          return HomeScreen();
        } else
          return LoginScreen();
      },
    );
  }

  static signIn(String email, String password){
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static signOut() {
    FirebaseAuth.instance.signOut();
  }

  static signUp(String email,String password){
    return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }
}
