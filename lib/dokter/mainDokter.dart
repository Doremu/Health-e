import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';

class mainDokter extends StatefulWidget {
  @override
  _HomeDokterState createState() => _HomeDokterState();
}

class _HomeDokterState extends State<mainDokter> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('Halo dokter!'),
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
                  // _temperature(),
                  // _pasien(),
                  // _content(),
                  _logout()
                ],
              ),
            )
          ],
        ),
      ),
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
        Navigator.pushNamed(context, "/login");
      },
    );
  }
  
}