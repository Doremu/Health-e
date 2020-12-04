import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:intl/intl.dart';

class mainDokter extends StatefulWidget {
  @override
  _HomeDokterState createState() => _HomeDokterState();
}

class _HomeDokterState extends State<mainDokter> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  
  dynamic data;
  String email;
  List<DocumentSnapshot> consules = new List<DocumentSnapshot>();
  Map<String, String> namaPasien = new Map<String, String>();
  var list;
  @override
  void initState() {
    super.initState();
    getUserDoc();
  }

  Future<dynamic> getUserDoc() async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    if(_auth.currentUser() == null){
      Navigator.pushNamed(context, '/login');
    }

    FirebaseUser user = await _auth.currentUser();
    DocumentReference namaref = _firestore.collection('users').document(user.uid);
    await namaref.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data = snapshot.data;
      });
    });
    email = user.email;

    QuerySnapshot querySnapshot = await Firestore.instance.collection("consules").where('emailDokter', isEqualTo: email).getDocuments();
    setState(() {
      consules = querySnapshot.documents;
    });

    consules.forEach((consule) async {
      await _firestore.collection('users').document(consule['uidPasien']).get().then((DocumentSnapshot snapshot) => {
        print(snapshot['firstname'] + " " + snapshot['lastname']),
        namaPasien[consule.documentID] =  snapshot['firstname'] + " " + snapshot['lastname']
      });
    });
    setState(() {});

  }
  
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
        child: Column(
          children: [
            // _temperature(),
              Expanded(
                child: _pasienList(),
              ),
            // _content(),
            _logout()
          ],
        ),
      )
    );
  }

  Widget _pasienList() {
    List<Widget> widgets = new List<Widget>();
    consules.forEach((consule) {
      DateTime consuleDateTime = DateTime.fromMillisecondsSinceEpoch(consule['tanggal'].seconds * 1000);
      String consuleDate = DateFormat('dd MMMM yyyy - kk:mm').format(consuleDateTime);
      widgets.add(
        Card(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "${consule['keluhan']}",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(padding: EdgeInsets.only(top: 16.0)),
                Text(
                  "${namaPasien[consule.documentID]}",
                  textAlign: TextAlign.left,
                ),
                Padding(padding: EdgeInsets.only(top: 4.0)),
                Text(
                  "$consuleDate",
                  textAlign: TextAlign.left,
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Image.network(consule['imageUrl'].toString()),
                Padding(padding: EdgeInsets.only(top: 16.0)),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    width: double.infinity,
                    child: Text(
                      'Beri Resep & Hasil EMR',
                      style: TextStyle(color: ColorPalette.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onTap: () async {
                  },
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
            )
          )
        )
      );
    });
    return ListView(children: widgets);
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
        Navigator.pop(context);
      },
    );
  }
  
}