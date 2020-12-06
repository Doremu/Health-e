import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:intl/intl.dart';

class EmrDokter extends StatefulWidget {
  @override
  _EmrDokterState createState() => _EmrDokterState();
}

class _EmrDokterState extends State<EmrDokter> {

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      )
    );
  }
}