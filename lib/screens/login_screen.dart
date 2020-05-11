import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zomato/AuthService.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Enter Email",
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                validator: (value) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (emailValid)
                    return null;
                  else
                    return "Invalid email";
                },
              ),
              TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "Enter Password",
                  ),
                  onFieldSubmitted: (_) => _signIn(),
                  validator: (value) =>
                      (value.length < 6) ? "Too small" : null),
              MaterialButton(
                child: Text("Sign In"),
                onPressed: () => _signIn(),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).accentColor,
        child: MaterialButton(
          child: Text("New user? Sign up"),
          textColor: Colors.white,
          onPressed: ()=> _signUp(),
        ),
      ),
    );
  }

  _signIn() async {
    print("Logging in");
    if (_formKey.currentState.validate()) {
      AuthService.signIn(_emailController.text, _passwordController.text)
          .catchError((error) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(error.code),
        ));
      });
    }
  }

  _signUp() async {
    if (_formKey.currentState.validate()) {
      AuthService.signUp(_emailController.text, _passwordController.text)
          .catchError((error) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(error.code),
        ));
      });
    }
  }
}
