import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:intl/intl.dart';

class DetailDokter extends StatefulWidget {
  final DocumentSnapshot consule;
  DetailDokter(this.consule, {Key key}): super(key: key);

  @override
  _DetailDokterState createState() => _DetailDokterState();
}

class _DetailDokterState extends State<DetailDokter> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  String namaPasien = "";

  @override
  void initState() {
    super.initState();
    getPatientName();
  }

  getPatientName() async {
    await _firestore.collection('users').document(widget.consule['uidPasien']).get().then((DocumentSnapshot snapshot) => {
      print(snapshot['firstname'] + " " + snapshot['lastname']),
      namaPasien =  snapshot['firstname'] + " " + snapshot['lastname']
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  namaPasien,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(padding: EdgeInsets.only(top: 4.0)),
                Text(
                  _dateFromTimeStamp(widget.consule['tanggal']),
                  textAlign: TextAlign.left,
                ),
                Padding(padding: EdgeInsets.only(top: 12.0)),
                Text(
                  widget.consule['keluhan'],
                  textAlign: TextAlign.left,
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Image.network(widget.consule['imageUrl']),
                Spacer(),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Back',
                      style: TextStyle(color: ColorPalette.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          )
        )
      )
    );
  }

  String _dateFromTimeStamp(timestamp){
    DateTime consuleDateTime = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd MMMM yyyy - kk:mm').format(consuleDateTime);
  }
}