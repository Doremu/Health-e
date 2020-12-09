import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic data;
  String nama = '';
  String email = '';
  String height = '';
  String weight = '';
  String bmi = '';
  String temp = '';
  String umur = '';
  @override
  void initState() {
    super.initState();
    getUserDoc();
  }
  Future<dynamic> getUserDoc() async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    if(_auth.currentUser() == null){
      // wrong call in wrong place!
      Navigator.pushNamed(context, '/login');
    }

    FirebaseUser user = await _auth.currentUser();
    DocumentReference namaref = _firestore.collection('users').document(user.uid);
    await namaref.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
      });
    });
    nama = data['firstname'] + ' ' + data['lastname'];
    email = user.email;
    DocumentReference heartref = _firestore.collection('scan').document(user.uid);
    await heartref.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
      });
    });
    height = (data['HEIGHT'] * 100).toStringAsFixed(0);
    weight = data['WEIGHT'].toStringAsFixed(1);
    bmi = data['BODY_MASS_INDEX'].toStringAsFixed(2);
    temp = data['BODY_TEMPERATURE'].toStringAsFixed(1);
    if(height == "0") umur = "0";
    else umur = "21";
    // heartbeat = '' + getHeartbeat.toString();
    // return ref;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              _profilePicture(),
              _profileName(),
              _profileStats(),
              _bmi(),
              Spacer(),
              _personalDocument(),
              _logout()
            ]
          )
        )
      )
    );
  }

  Widget _profilePicture() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 48.0)),
        InkWell(
          child: Image.asset(
            "assets/images/profile.png",
            width: 150,
            height: 150,
            fit: BoxFit.fill
          ),
          onTap: () {
            //Navigator.pushNamed(context, "/editprofile");
          }
        ),
        Padding(padding: EdgeInsets.only(top: 16.0)),
      ]
    );
  }

  Widget _profileName() {
    return Column(
      children: [
        Text("${nama}", style: TextStyle(fontSize: 20.0)),
        Padding(padding: EdgeInsets.only(top: 8.0)),
        Text("${email}", style: TextStyle(fontSize: 14.0)),
        Padding(padding: EdgeInsets.only(top: 16.0)),
      ],
    );
  }

  Widget _profileStats() {
    return Column(
      children: [
        Row(
          children: <Widget>[
            _profileStat("Umur",umur),
            _profileStat("Tinggi (cm)", height),
            _profileStat("Berat (kg)", weight),
            _profileStat("Suhu Badan (C)", temp),
          ]
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }

  Widget _profileStat(name, value) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 36.0)),
            Text(name, style: TextStyle(fontSize: 10.0))
          ]
        )
      )
    );
  }

  Widget _bmi() {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("Nilai BMI"),
                  ]
                ),
                Expanded(
                  child: Center(
                    child: Text("${bmi}", style: TextStyle(fontSize: 36.0))
                  )
                )
              ]
            )
          )
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }

  Widget _personalDocument() {
    return Column(
      children: [
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            width: double.infinity,
            child: Text(
              'Dokumen Pribadi',
              style: TextStyle(color: ColorPalette.primaryColor),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, "/personaldocument");
          },
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }

  Widget _logout() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        width: double.infinity,
        child: Text(
          'Logout',
          style: TextStyle(color: ColorPalette.primaryColor),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onTap: () async {
        // Navigator.pop(context);
        await FirebaseAuth.instance.signOut();
        // Navigator.pushNamed(context, "/");
        Navigator.pushReplacementNamed(context, '/');
      },
    );
  }
}