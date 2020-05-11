
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot document =
        ModalRoute.of(context).settings.arguments as DocumentSnapshot;
    Map<String,dynamic> restaurantData = document.data;
    print(restaurantData);
    return Scaffold(
        appBar: AppBar(
          title: Text(restaurantData["name"]),
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('users').document(document.documentID).collection("meals").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Meals Available",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 400,
                          child: ListView(
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: ListTile(
                                    title: Text(document['name']),
                                    trailing: Text("\$${document['price']}"),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ));
  }
}
