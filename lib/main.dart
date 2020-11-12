import 'package:flutter/material.dart';
import 'package:healthe/login/login.dart';
import 'package:healthe/login/register.dart';
import 'package:healthe/main/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Login Register Page",
    initialRoute: "/",
    routes: {
      "/" : (context) => LoginPage(),
      "/register" : (context) => RegisterPage(),
      "/main" : (context) => Home(),
    },
  ));
}