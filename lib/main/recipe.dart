import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/main.dart';

class Recipe extends StatefulWidget {
  @override
  _RecipeState createState() => _RecipeState();
}
class _RecipeState extends State<Recipe> {
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
    //bool isEmpty = true;
    bool isEmpty = false;
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
    else
      return ListView(
        children: [
          _recipeSingle("Pasifed","Obat Pilek",new DateTime.utc(2021,04,26)),
          _recipeSingle("Contramag","Obat Maag",new DateTime.utc(2020,12,29)),
          _recipeSingle("Xerdob","Obat Flu",new DateTime.utc(2020,12,4)),
        ],
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      );
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