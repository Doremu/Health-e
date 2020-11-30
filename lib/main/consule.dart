import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthe/main.dart';

class Consule extends StatefulWidget {
  @override
  _ConsuleState createState() => _ConsuleState();
}
class _ConsuleState extends State<Consule> {
  String nama = '';
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
    DocumentReference namaref = _firestore.collection('users').document(user.uid);
    await namaref.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
      });
    });
    nama = 'Halo, ' + data['firstname'];
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(nama),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: _consuleWidget()
      )
    );
  }

  Widget _consuleWidget() {
    return Column(
      children: [
        Card(
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Konsultasi",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Padding(padding: EdgeInsets.only(top: 8.0)),
                  Text("Konsultasi dengan dokter kapan saja dan dimana saja.")
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              )
            ),
            onTap: () {
              Navigator.pushNamed(context, "/consuleform");
            },
          )
        ),
      ]
    );
  }
}