import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/main.dart';
import 'package:healthe/model/recipe.model.dart';

class Recipe extends StatefulWidget {
  @override
  _RecipeState createState() => _RecipeState();
}
class _RecipeState extends State<Recipe> {
  List<DocumentSnapshot> recipes = new List<DocumentSnapshot>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
    getUserDoc();
  }

  Future<dynamic> getUserDoc() async {

    if(_auth.currentUser() == null){
      Navigator.pushNamed(context, '/login');
    }

    FirebaseUser user = await _auth.currentUser();

    QuerySnapshot querySnapshot = await Firestore.instance.collection("resep").where('uidPasien', isEqualTo: user.uid).getDocuments();
    setState(() {
      recipes = querySnapshot.documents;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 36.0)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Daftar Resep",
                style: TextStyle(
                  fontSize: 26.0,
                )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 24.0)),
            Expanded(child: _recipeWidget()),
          ],
          crossAxisAlignment: CrossAxisAlignment.start
        )
      )
    );
  }

  Widget _recipeWidget() {
    List<Widget> widgets = new List<Widget>();
    bool isEmpty = recipes.length == 0;
    if(isEmpty)
      return Column(
        children: [
          Spacer(),
          Text(
            'Tidak ada resep.',
            style: TextStyle(
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.only(top: 16.0)),
          Text(
            'Resep yang diberikan dari dokter akan ditampilkan di sini.',
            textAlign: TextAlign.center,
          ),
          Spacer(),
        ]
      );
    else{
      recipes.forEach((recipe) {
        DateTime recipeDateTime = DateTime.fromMillisecondsSinceEpoch(recipe['tanggal'].seconds * 1000);
        widgets.add(
          _recipeSingle(recipe['namaObat'],recipe['deskripsiObat'],recipeDateTime),
        );
      });

      return ListView(
        children: widgets,
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      );
    }
  }

  Widget _recipeSingle(name, category, DateTime time) {
    String expireString = "Kadaluarsa dalam ";
    int timeLeft = time.difference(new DateTime.now()).inDays;
    if(timeLeft > 30) expireString += (timeLeft / 30).floor().toString() + " bulan";
    else expireString += timeLeft.toString() + " hari";

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(padding: EdgeInsets.only(top: 8.0)),
              Text(
                category,
                textAlign: TextAlign.left,
              ),
              Padding(padding: EdgeInsets.only(top: 4.0)),
              Text(
                expireString,
                textAlign: TextAlign.left,
              ),
              Divider(
                color: Colors.grey,
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start
          )
        ),
        Text("...")
      ],
    );
  }
}