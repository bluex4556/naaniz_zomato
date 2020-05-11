import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zomato/AuthService.dart';

class RestaurantMeals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Text(
            "Restaurant meals",
            style: Theme.of(context).textTheme.headline1,
          ),
          trailing: MaterialButton(
            child: Text("Add Meal"),
            textColor: Colors.white,
            color: Theme.of(context).accentColor,
            onPressed: ()=>Navigator.pushNamed(context, "/add-meal"),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('users')
              .document(AuthService.userId)
              .collection("meals")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  child: ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return ListTile(
                        title: Text(document['name']),
                        trailing: Text("\$${document['price']}"),
                      );
                    }).toList(),
                  ),
                );
            }
          },
        ),
      ],
    );
  }
}
