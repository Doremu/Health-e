import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:intl/intl.dart';

class EmrDokter extends StatefulWidget {
  final DocumentSnapshot consule;
  EmrDokter(this.consule, {Key key}): super(key: key);

  @override
  _EmrDokterState createState() => _EmrDokterState();
}

class _EmrDokterState extends State<EmrDokter> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final databaseReference = Firestore.instance;
  String namaPasien = "";
  final formKey = GlobalKey<FormState>();
  String hasilEmr = "";

  @override
  void initState() {
    super.initState();
    getPatientName();
  }

  getPatientName() async {
    await _firestore.collection('users').document(widget.consule['uidPasien']).get().then((DocumentSnapshot snapshot) => {
      print(snapshot['firstname'] + " " + snapshot['lastname']),
      namaPasien =  snapshot['firstname'] + " " + snapshot['lastname'],
      setState(() {})
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Halo dokter!'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Text("Beri hasil EMR ke " + namaPasien),
              _inputText("Hasil"),
              _btnSubmit()
            ]
          )
        )
      )
    );
  }

  Widget _inputText(label) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 16.0)),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label)
        ),
        Padding(padding: EdgeInsets.only(top: 16.0)),
        TextFormField(
          maxLines: 8,
          decoration: const InputDecoration(
            hintText: "Tulis hasil EMR di sini",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          autofocus: false,
          onSaved: (String value){
            hasilEmr = value;
          },
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }

  Widget _btnSubmit(){
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        width: double.infinity,
        child: Text(
          'Kirim',
          style: TextStyle(color: ColorPalette.primaryColor),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onTap: () async {
        formKey.currentState.save();
        if(formKey.currentState.validate()){
          try {
            String docname = widget.consule['uidPasien']+" "+DateTime.now().toString();
            await databaseReference.collection("emr")
                .document(docname)
                .setData({
              'uidPasien': widget.consule['uidPasien'],
              'hasilEmr': hasilEmr,
              'tanggal' : FieldValue.serverTimestamp()
            });
            Navigator.pop(context);
          }
          catch (error)
          {
            print(error);
          }
        }
      },
    );
  }
}