import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/main.dart';

class ConsuleForm extends StatefulWidget {
  @override
  _ConsuleFormState createState() => _ConsuleFormState();
}

class _ConsuleFormState extends State<ConsuleForm> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text("Konsultasi")
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _inputDropdown("Doktor"),
            _inputText("Keluhan"),
            _inputAttachment("Lampiran (tidak wajib)"),
            _btnSubmit()
          ]
        )
      )
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
          maxLines: 8,
          decoration: const InputDecoration(
            hintText: "Tulis keluhan anda di sini",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          autofocus: false,
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }

  Widget _inputDropdown(label) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label)
        ),
        DropdownButton(
          hint: Text("Pilih Dokter"),
          items: null,
          onChanged: null,
          isExpanded: true,
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }

  Widget _inputAttachment(label) {
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
        Padding(padding: EdgeInsets.only(top: 24.0))
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
      onTap: () {
        Navigator.pushNamed(context, "/login");
      },
    );
  }
}