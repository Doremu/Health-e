import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:intl/intl.dart';

class ResepDokter extends StatefulWidget {
  final DocumentSnapshot consule;
  ResepDokter(this.consule, {Key key}): super(key: key);

  @override
  _ResepDokterState createState() => _ResepDokterState();
}

class _ResepDokterState extends State<ResepDokter> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final databaseReference = Firestore.instance;
  String namaPasien = "";
  var namaObat = [""];
  var deskripsiObat = [""];
  var durasiObat = [""];
  final formKey = GlobalKey<FormState>();

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
          child: Column(
            children: [
              Text("Beri resep ke " + namaPasien),
              Expanded(child: _inputList("List Obat")),
              _btnAddRemove(),
              _btnSubmit()
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          )
        )
      )
    );
  }

  Widget _inputList(label){
    List<Widget> widgets = new List<Widget>();
    widgets.add(Padding(padding: EdgeInsets.only(top: 16.0)));
    widgets.add(Text(label, textAlign: TextAlign.left,));
    widgets.add(Padding(padding: EdgeInsets.only(top: 16.0)));
    
    for(var i = 0; i < namaObat.length; i++){
      widgets.add(
        Card(child: 
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Nama Obat")
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(color: ColorPalette.hintColor),
                ),
                autofocus: false,
                onSaved: (String value){
                  namaObat[i] = value;
                },
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Deskripsi Obat")
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(color: ColorPalette.hintColor),
                ),
                autofocus: false,
                onSaved: (String value){
                  deskripsiObat[i] = value;
                },
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Durasi Obat")
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(color: ColorPalette.hintColor),
                ),
                autofocus: false,
                onSaved: (String value){
                  durasiObat[i] = value;
                },
              ),
            ])
          )
        )
      );
    }
    return ListView(children: widgets,);
  }

  Widget _btnAddRemove(){
    return Row(children: [
      Expanded(child: 
        InkWell(
          child: Container(
            padding: EdgeInsets.all(4.0),
            child: Text(
              'Tambah Obat',
              style: TextStyle(color: ColorPalette.primaryColor),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onTap: () {
            namaObat.add("");
            deskripsiObat.add("");
            durasiObat.add("");
            setState(() {});
          },
        ),
      ),
      Expanded(child: 
        InkWell(
          child: Container(
            padding: EdgeInsets.all(4.0),
            child: Text(
              'Hapus Obat Terakhir',
              style: TextStyle(color: ColorPalette.primaryColor),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onTap: () {
            if(namaObat.length > 1){
              namaObat.removeAt(namaObat.length - 1);
              deskripsiObat.removeAt(deskripsiObat.length - 1);
              durasiObat.removeAt(durasiObat.length - 1);
              setState(() {});
            }
          },
        ),
      ),
    ],);
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
            for(var i = 0; i < namaObat.length; i++){
              String docname = widget.consule['uidPasien'] + " " + i.toString() + " "+DateTime.now().toString();
              await databaseReference.collection("resep")
                  .document(docname)
                  .setData({
                'uidPasien': widget.consule['uidPasien'],
                'namaObat': namaObat[i],
                'deskripsiObat': deskripsiObat[i],
                'tanggal' : Timestamp.fromDate(DateTime.now().add(new Duration(days: int.parse(durasiObat[i]))))
              });
            }
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