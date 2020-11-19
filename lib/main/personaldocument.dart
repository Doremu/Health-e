import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/main.dart';

class PersonalDocument extends StatefulWidget {
  @override
  _PersonalDocumentState createState() => _PersonalDocumentState();
}

class _PersonalDocumentState extends State<PersonalDocument> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text("Dokumen Pribadi")
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
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
          onTap: () {
            Navigator.pushNamed(context, "/login");
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
            hintText: "First Name",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.white),
          autofocus: false,
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }
}