import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/main.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text("Edit Data Pribadi")
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: Expanded(
          child: ListView(
            children: [
              _inputText("Nama Lengkap", ""),
              _inputDropdownCalendar("Tanggal Lahir"),
              _inputRadios("Jenis Kelamin",["Laki-laki", "Perempuan"]),
              _inputRadios("Golongan Darah",["A", "B", "AB", "O"]),
              _inputText("Nomor Telepon", ""),
              _inputText("Alamat", ""),
            ]
          )
        )
      )
    );
  }

  Widget _inputText(label, value) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label)
        ),
        TextFormField(
          initialValue: value,
          decoration: const InputDecoration(
            hintText: "", //pake label ga bisa
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          autofocus: false,
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }

  Widget _inputDropdownCalendar(label) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label)
        ),
        DropdownButton(
          hint: Text("DD-MM-YYYY"),
          items: null,
          onChanged: null,
          isExpanded: true,
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }

  Widget _inputRadios(label, options) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label)
        ),
        Row(
          children: [for (var option in options)
            Expanded(
              child: Row(
                children: [
                  Radio(groupValue: null, value: null, onChanged: null),
                  Text(option)
                ]
              )
            )
          ]
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }
}