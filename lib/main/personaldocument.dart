import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/login/error.dart';
import 'package:healthe/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class PersonalDocument extends StatefulWidget {
  @override
  _PersonalDocumentState createState() => _PersonalDocumentState();
}

class _PersonalDocumentState extends State<PersonalDocument> {
  final formKey = GlobalKey<FormState>();
  String bpjs = '';
  String nik = '';
  File _imageFileKtp;
  File _imageFileKtpOrang;
  File _imageFileBPJS;
  final picker = ImagePicker();
  final databaseReference = Firestore.instance;
  String imageUrlKtp = '';
  String imageUrlKtpOrang = '';
  String imageUrlBPJS = '';

  @override
  void initState() {
    super.initState();
    getUserDoc();
  }

  Future pickImageKtp() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFileKtp = File(pickedFile.path);
    });
    // String x = basename
  }
  Future pickImageKtpOrang() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFileKtpOrang = File(pickedFile.path);
    });
    // String x = basename
  }
  Future pickImageBPJS() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFileBPJS = File(pickedFile.path);
    });
    // String x = basename
  }

  uploadImageKTPToFirebase(BuildContext context) async {
    String fileName = path.basename(_imageFileKtp.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFileKtp);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
            (value) => {
          print("Done: $value"),
          imageUrlKtp = value,
        }
    );
    imageUrlKtp = await taskSnapshot.ref.getDownloadURL();
  }
  uploadImageKTPOrangToFirebase(BuildContext context) async {
    String fileName = path.basename(_imageFileKtpOrang.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFileKtpOrang);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
            (value) => {
          print("Done: $value"),
          imageUrlKtpOrang = value,
        }
    );
    imageUrlKtpOrang = await taskSnapshot.ref.getDownloadURL();
  }
  uploadImageBPJSToFirebase(BuildContext context) async {
    String fileName = path.basename(_imageFileBPJS.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFileBPJS);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
            (value) => {
          print("Done: $value"),
          imageUrlBPJS = value,
        }
    );
    imageUrlBPJS = await taskSnapshot.ref.getDownloadURL();
  }

  Future<dynamic> getUserDoc() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    FirebaseUser user = await _auth.currentUser();
    // return ref;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text("Dokumen Pribadi")
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              _documentImage("Kartu Tanda Penduduk"),
              _documentImage("Swafoto dengan KTP"),
              _documentImage("Nomor BPJS"),
              _inputText("Nomor BPJS"),
              _inputText("NIK"),
              _btnSubmit()
            ]
          ),
        )
      )
    );
  }

  Widget _documentImage(label) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label)
        ),
        Padding(padding: EdgeInsets.only(top: 8.0)),
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            width: double.infinity,
            child: Text(
              'Ambil Foto',
              style: TextStyle(color: ColorPalette.primaryColor),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onTap: () async {
            if (label == 'Kartu Tanda Penduduk') {
              pickImageKtp();
            }
            else if(label == 'Swafoto dengan KTP') {
              pickImageKtpOrang();
            }
            else if(label == 'Nomor BPJS') {
              pickImageBPJS();
            }
            // Navigator.pushNamed(context, "/login");
          },
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }

  Widget _inputText(label) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label)
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 1.5
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 3.0
              ),
            ),
            hintText: "",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          onSaved: (String value){
            if (label == 'Nomor BPJS') bpjs = value;
            else if (label == 'NIK') nik = value;
          },
          style: TextStyle(color: Colors.blueAccent),
          autofocus: false,
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
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
        await uploadImageKTPToFirebase(context);
        await uploadImageKTPOrangToFirebase(context);
        await uploadImageBPJSToFirebase(context);

        formKey.currentState.save();
        if(formKey.currentState.validate()){
          try {
            final FirebaseAuth _auth = FirebaseAuth.instance;
            FirebaseUser user = await _auth.currentUser();
            // String docname = emailDokter+" "+DateTime.now().toString();
            await databaseReference.collection("document")
                .document(user.uid)
                .setData({
              'nomorBPJS': bpjs,
              'nik': nik,
              'urlKTP' : imageUrlKtp,
              'urlSwafoto' : imageUrlKtpOrang,
              'urlBPJS': imageUrlBPJS,
            });
            Navigator.pop(context);
          }
          catch (error)
          {
            print(error);
            Fluttertoast.showToast(
              msg: Errors.show(error.code),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          }
        }
      },
    );
  }
}