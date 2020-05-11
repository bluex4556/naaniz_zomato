import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zomato/AuthService.dart';
import 'package:zomato/screens/user_detail_input_screen.dart';
import 'package:zomato/widget/restaurant_list.dart';

class HomeScreen extends StatelessWidget {
  Future<DocumentSnapshot> getCurrentUser() {
    return Firestore.instance
        .collection("users")
        .document(AuthService.userId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Zomato Clone"),
          actions: <Widget>[IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: ()=>AuthService.signOut(),
          ),],
        ),
        body: FutureBuilder(
          future: getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String,dynamic> user = snapshot.data.data;
              print(user);
              if (user == null) {
                return UserDetailInputScreen();
              } else {
                if(user["type"]=="user")
                  return RestaurantList();
                else
                  return Text("hello");
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
