import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthe/main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  dynamic data;
  @override
  void initState() {
    super.initState();
    getUserDoc();
  }

  Future<dynamic> getUserDoc() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    FirebaseUser user = await _auth.currentUser();
    DocumentReference ref = _firestore.collection('users').document(user.uid);
    await ref.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
      });
    });
    nama = 'Halo, ' + data['firstname'];
    // return ref;
  }
  String nama = '';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(nama),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  _temperature(),
                  _heartBeat(),
                  _device(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _temperature() {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 16.0),),
        Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              print('Card tapped.');
            },
            child: Container(
              width: 300,
              height: 100,
              child: Center(
                child: Text(
                  'Suhu 36.8 C',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0),
        ),
        Center(
          child: Text(
            'Last checked 22/10 00:10'
          ),
        ),
      ],
    );
  }
  Widget _heartBeat() {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 30.0),),
        Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              print('Card tapped.');
            },
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 30.0),),
                const ListTile(
                  title: Text(
                    '100BPM',
                    style: TextStyle(
                    fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    'Hearts Beat',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30.0),),
              ],

            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0),
        ),
      ],
    );
  }
  Widget _device() {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 60.0),),
        Center(
          child: Text(
            'Samsung Band S20',
            style: TextStyle(
              fontSize: 26.0,
            ),
          ),
        ),
      ],
    );
  }
}