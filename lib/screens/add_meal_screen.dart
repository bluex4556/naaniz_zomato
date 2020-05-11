import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zomato/AuthService.dart';

class AddMealScreen extends StatefulWidget {
  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Meal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name of the meal",
                ),
                validator: (value) {
                  return (value.length < 4) ? "Name too small" : null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).nextFocus();
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                controller: _priceController,
                decoration: InputDecoration(labelText: "Enter price"),
                validator: (value) {
                  if(value.length>0)
                    return (int.parse(value) > 0) ? null : "Invalid Number";
                  return null;
                },
                onFieldSubmitted: (_) => addMeal(),
              ),
              const SizedBox(
                height: 40,
              ),
              MaterialButton(
                child: Text("Add meal"),
                onPressed: ()=>addMeal(),
                textColor: Colors.white,
                color: Theme.of(context).accentColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  addMeal() async {
    String name = _nameController.text;
    double price = double.parse(_priceController.text);

    Firestore.instance
        .collection("users")
        .document(AuthService.userId)
        .collection("meals")
        .document()
        .setData({"name": name, "price": price}).then(
            (value) => Navigator.pop(context)).catchError((error){
              print(error);
    });
  }
}
