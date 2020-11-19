import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthe/login/login.dart';
import 'package:healthe/login/register.dart';
import 'package:healthe/main/consule.dart';
import 'package:healthe/main/editprofile.dart';
import 'package:healthe/main/emr.dart';
import 'package:healthe/main/home.dart';
import 'package:healthe/main/personaldocument.dart';
import 'package:healthe/main/profile.dart';
import 'package:healthe/main/recipe.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Login Register Page",
    initialRoute: "/",
    routes: {
      "/" : (context) => LoginPage(),
      "/register" : (context) => RegisterPage(),
      "/main" : (context) => BottomNavBar(),
      "/personaldocument" : (context) => PersonalDocument(),
      "/editprofile" : (context) => EditProfile()
    },
  ));
}

class BottomNavBar extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _BottomNavBar();
  }
}

class _BottomNavBar extends State<BottomNavBar> {

  int _page = 2;
  final List<Widget> _children = [
    Consule(),
    Recipe(),
    Home(),
    Emr(),
    Profile()
  ];
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: _children[_page],
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.blueAccent,
          backgroundColor: Colors.white,
          key: _bottomNavigationKey,
          items: <Widget>[
            Image.asset('assets/icon/stethoscope.png', width: 30,),
            Icon(Icons.assignment_outlined, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.library_add, size: 30),
            Icon(Icons.account_circle, size: 30),
          ],
          index: 2,
          animationDuration: Duration(
              milliseconds: 200
          ),
          animationCurve: Curves.bounceInOut,
          // onTap: onTappedBar,
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
    );
  }
}
