import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zomato/AuthService.dart';

class UserDetailInputScreen extends StatefulWidget {
  @override
  _UserDetailInputScreenState createState() => _UserDetailInputScreenState();
}

class _UserDetailInputScreenState extends State<UserDetailInputScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownValue = "user";
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 50),
      child: Form(
        autovalidate: true,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ListTile(
              leading: Text("You are a? "),
              trailing: DropdownButton<String>(
                value: dropdownValue,
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: "user",
                    child: Text("User"),
                  ),
                  DropdownMenuItem(
                    value: "restaurant",
                    child: Text("Restaurant Owner"),
                  ),
                ],
              ),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: (dropdownValue == "user")
                    ? "Enter your name"
                    : "Enter the name of the restaurant",
              ),
              onFieldSubmitted: (name)=>addDetails(name),
              validator: (value){
                return (value.length<4)? "Name too small": null;
              },
            ),
            SizedBox(height: 25,),
            MaterialButton(
              child: Text("Submit"),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: ()=>addDetails(nameController.text),

            ),
          ],
        ),
      ),
    );
  }

  addDetails(String name) async {
    if(_formKey.currentState.validate())
      {
        Firestore.instance.collection("users").document(AuthService.userId).setData(
          {
            "type" : dropdownValue,
            "name" : name
          }
        ).then((value) => Navigator.pushReplacementNamed(context, "/home")).catchError((error){
          print(error);
        });
      }
  }
}
