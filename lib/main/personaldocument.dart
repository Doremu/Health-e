import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class PersonalDocument extends StatefulWidget {
  @override
  _PersonalDocumentState createState() => _PersonalDocumentState();
}

class _PersonalDocumentState extends State<PersonalDocument> {
  File _imageFileKtp;
  File _imageFileKtpOrang;
  File _imageFileBPJS;
  final picker = ImagePicker();
  final databaseReference = Firestore.instance;
  String imageUrlKtp = '';
  String imageUrlKtpOrang = '';
  String imageUrlBPJS = '';
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text("Dokumen Pribadi")
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _documentImage("Kartu Tanda Penduduk"),
            _documentImage("Swafoto dengan KTP"),
            _documentImage("Nomor BPJS"),
            _inputText("Nomor BPJS"),
            _inputText("NIK"),
          ]
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
          style: TextStyle(color: Colors.blueAccent),
          autofocus: false,
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }
}