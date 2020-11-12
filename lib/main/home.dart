import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthe/main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Halo, Aric'),
        automaticallyImplyLeading: false,
      ),
      body: new Center(
        child: new Text('Home Page'),
      ),

    );
  }
}