import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthe/main.dart';

class Consule extends StatefulWidget {
  @override
  _ConsuleState createState() => _ConsuleState();
}
class _ConsuleState extends State<Consule> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Halo, Aric'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: _consuleWidget()
      )
    );
  }

  Widget _consuleWidget() {
    return Column(
      children: [
        Card(
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Telekonsultasi",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Padding(padding: EdgeInsets.only(top: 8.0)),
                  Text("Konsultasi dengan dokter kapan saja dan dimana saja.")
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              )
            ),
            onTap: () {

            },
          )
        ),
        Padding(padding: EdgeInsets.only(top: 16.0)),
        Card(
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Reservasi Online",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Padding(padding: EdgeInsets.only(top: 8.0)),
                  Text("Buat janji konsultasi di rumah sakit terdaftar.")
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              )
            ),
            onTap: () {
              
            },
          )
        )
      ]
    );
  }
}