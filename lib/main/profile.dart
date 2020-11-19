import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              _profilePicture(),
              _profileName(),
              _profileStats(),
              _bmi(),
              Spacer(),
              _personalDocument(),
              _logout()
            ]
          )
        )
      )
    );
  }

  Widget _profilePicture() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 48.0)),
        InkWell(
          child: Image.asset(
            "assets/images/profile.png",
            width: 150,
            height: 150,
            fit: BoxFit.fill
          ),
          onTap: () {
            Navigator.pushNamed(context, "/editprofile");
          }
        ),
        Padding(padding: EdgeInsets.only(top: 16.0)),
      ]
    );
  }

  Widget _profileName() {
    return Column(
      children: [
        Text("Fransiskus Aprilion Aric", style: TextStyle(fontSize: 20.0)),
        Padding(padding: EdgeInsets.only(top: 8.0)),
        Text("fransiskusaric@gmail.com", style: TextStyle(fontSize: 14.0)),
        Padding(padding: EdgeInsets.only(top: 16.0)),
      ],
    );
  }

  Widget _profileStats() {
    return Column(
      children: [
        Row(
          children: <Widget>[
            _profileStat("Umur","21"),
            _profileStat("Tinggi (cm)","170"),
            _profileStat("Berat (kg)","60"),
            _profileStat("Gol. Darah","O"),
          ]
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }

  Widget _profileStat(name, value) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 36.0)),
            Text(name)
          ]
        )
      )
    );
  }

  Widget _bmi() {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("Nilai BMI"),
                    Text("Normal"),
                  ]
                ),
                Expanded(
                  child: Center(
                    child: Text("20.8", style: TextStyle(fontSize: 36.0))
                  )
                )
              ]
            )
          )
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
  }

  Widget _personalDocument() {
    return Column(
      children: [
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            width: double.infinity,
            child: Text(
              'Dokumen Pribadi',
              style: TextStyle(color: ColorPalette.primaryColor),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, "/personaldocument");
          },
        ),
        Padding(padding: EdgeInsets.only(top: 16.0))
      ]
    );
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
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}