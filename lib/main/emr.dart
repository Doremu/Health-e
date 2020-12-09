import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/main.dart';
import 'package:intl/intl.dart';

class Emr extends StatefulWidget {
  @override
  _EmrState createState() => _EmrState();
}
class _EmrState extends State<Emr> {
  List<DocumentSnapshot> emrs = new List<DocumentSnapshot>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
    getUserDoc();
  }

  Future<dynamic> getUserDoc() async {

    if(_auth.currentUser() == null){
      Navigator.pushNamed(context, '/login');
    }

    FirebaseUser user = await _auth.currentUser();

    QuerySnapshot querySnapshot = await Firestore.instance.collection("emr").where('uidPasien', isEqualTo: user.uid).getDocuments();
    setState(() {
      emrs = querySnapshot.documents;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 36.0)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Hasil EMR",
                style: TextStyle(
                  fontSize: 26.0,
                )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 24.0)),
            Expanded(child: _emrWidget()),
          ],
          crossAxisAlignment: CrossAxisAlignment.start
        )
      )
    );
  }

  Widget _emrWidget() {
    List<Widget> widgets = new List<Widget>();
    bool isEmpty = emrs.length == 0;
    if(isEmpty)
      return Column(
        children: [
          Spacer(),
          Text(
            'Tidak ada riwayat.',
            style: TextStyle(
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.only(top: 16.0)),
          Text(
            'Daftarkan dirimu segera untuk dapat kami periksa lebih lanjut',
            textAlign: TextAlign.center,
          ),
          Spacer(),
        ],
        mainAxisAlignment: MainAxisAlignment.center
      );
    else{
      emrs.forEach((emr) {
        DateTime emrDateTime = DateTime.fromMillisecondsSinceEpoch(emr['tanggal'].seconds * 1000);
        widgets.add(
          _emrSingle(emrDateTime,emr['hasilEmr']),
        );
      });

      return ListView(
        children: widgets,
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      );
    }
  }

  Widget _verifyData() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        width: double.infinity,
        child: Text(
          'Verifikasi Data Pasien',
          style: TextStyle(color: ColorPalette.primaryColor),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onTap: () {
      },
    );
  }

  Widget _emrSingle(DateTime time, description) {
    String timeString = "";
    switch(-time.difference(DateTime.now()).inDays){
      case 0: timeString = "Hari Ini"; break;
      case 1: timeString = "Kemarin"; break;
      case 2: timeString = "2 hari yang lalu"; break;
      case 3: timeString = "3 hari yang lalu"; break;
      case 4: timeString = "4 hari yang lalu"; break;
      case 5: timeString = "5 hari yang lalu"; break;
      case 6: timeString = "6 hari yang lalu"; break;
      default: 
        timeString = DateFormat("dd MMMM yyyy").format(time);
      break;
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                timeString,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(padding: EdgeInsets.only(top: 8.0)),
              Text(
                description,
                textAlign: TextAlign.left,
              ),
              Divider(
                color: Colors.grey,
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start
          )
        ),
        Text("...")
      ],
    );
  }
}