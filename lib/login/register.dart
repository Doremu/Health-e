import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/login/error.dart';
import 'package:healthe/login/login.dart';
import 'package:healthe/login/validation.dart';
import 'package:healthe/main/home.dart';

class RegisterPage extends StatelessWidget with Validation{
  final databaseReference = Firestore.instance;
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String firstName='';
  String lastName='';
  String username='';
  String email='';
  String password='';
  String retypePassword='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPalette.primaryColor,
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
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

  Widget _titleDescription() {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 16.0),),
        Text(
          "Register",
          style: TextStyle(
              color: Colors.white,
              fontSize: 26.0
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
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
              hintText: "First Name",
              hintStyle: TextStyle(color: ColorPalette.hintColor),
            ),
            onSaved: (String value){
              firstName = value;
            },
            style: TextStyle(color: Colors.white),
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
              hintText: "Last Name",
              hintStyle: TextStyle(color: ColorPalette.hintColor),
            ),
            onSaved: (String value){
              lastName = value;
            },
            style: TextStyle(color: Colors.white),
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
              hintText: "Username",
              hintStyle: TextStyle(color: ColorPalette.hintColor),
            ),
            onSaved: (String value){
              username = value;
            },
            style: TextStyle(color: Colors.white),
            autofocus: false,
          ),
          Padding(padding: EdgeInsets.only(top: 12.0),),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
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
            style: TextStyle(color: Colors.white),
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
            style: TextStyle(color: Colors.white),
            obscureText: true,
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
              hintText: "Retype Password",
              hintStyle: TextStyle(color: ColorPalette.hintColor),
            ),
            onSaved: (String value){
              retypePassword = value;
            },
            validator: (String value) {
              if(password != value) {
                return 'Password tidak sama';
              }
              return null;
            },
            style: TextStyle(color: Colors.white),
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
              'Register',
              style: TextStyle(color: ColorPalette.primaryColor),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onTap: () async {
            formKey.currentState.save();
            if(formKey.currentState.validate()){
              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);


                FirebaseUser user = newUser.user;
                await databaseReference.collection("users")
                    .document(user.uid)
                    .setData({
                  'firstname': firstName,
                  'lastname': lastName,
                  'username' : username
                });
                if (newUser != null) {
                  Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()),
                  );
                }
              }
              catch (error)
              {
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
              Navigator.pushNamed(context, "/");
            },
            child: Text(
              'Already have an account',
              style: TextStyle(color: Colors.white),
            )
        )
      ],
    );
  }
  // void createRecord() async {
  //   await databaseReference.collection("users")
  //       .document(email)
  //       .setData({
  //     'title': 'Mastering Flutter',
  //     'description': 'Programming Guide for Dart'
  //   });
  //   await databaseReference.collection("users")
  //       .document(email)
  //       .setData({
  //         'firstname': firstName,
  //         'lastname': lastName,
  //         'username' : username
  //       });
  //
  // }
}