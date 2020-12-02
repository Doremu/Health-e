import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  // _content()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
}