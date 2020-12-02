import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/login/error.dart';
import 'package:healthe/login/register.dart';
import 'package:healthe/main/home.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email, password, e;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  _iconLogin(),
                  _titleDescription(),
                  _textField(),
                  _buildButton(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _iconLogin() {
    return Image.asset(
      "assets/images/logo.png",
      width: 300.0,
      height: 300.0,
    );
  }

  Widget _titleDescription() {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 16.0),),
        Text(
          "Login",
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 16.0
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0),
        )
      ],
    );
  }

  Widget _textField() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 12.0),),
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: ColorPalette.underlineTextField,
                    width: 1.5
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white,
                    width: 3.0
                ),
              ),
              hintText: "Email",
              hintStyle: TextStyle(color: ColorPalette.hintColor),
            ),
            onSaved: (String value){
              email = value;
            },
            style: TextStyle(color: Colors.blueAccent),
            autofocus: false,
          ),
          Padding(padding: EdgeInsets.only(top: 12.0),),
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: ColorPalette.underlineTextField,
                    width: 1.5
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white,
                    width: 3.0
                ),
              ),
              hintText: "Password",
              hintStyle: TextStyle(color: ColorPalette.hintColor),
            ),
            onSaved: (String value){
              password = value;
            },
            style: TextStyle(color: Colors.blueAccent),
            obscureText: true,
            autofocus: false,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 16.0),),
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            width: double.infinity,
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onTap: () async {
            if(formKey.currentState.validate()){
              formKey.currentState.save();
              try {
                final newUser = await _auth.signInWithEmailAndPassword(
                    email: email, password: password);
                if (newUser != null) {
                  //successfully login
                  //navigate the user to main page
                  Navigator.pushNamed(context, "/");
                  // i am just showing toast message here
                }
              } catch (error) {
                print(error);
                Fluttertoast.showToast(
                  msg: Errors.show(error.code),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              }
            }
          },
        ),
        Padding(padding: EdgeInsets.only(top: 16.0),),
        Text(
          'or',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, "/register");
            },
            child: Text(
              'Create account',
              style: TextStyle(color: Colors.blue),
            )
        )
      ],
    );
  }
}