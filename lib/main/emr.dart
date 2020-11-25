import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthe/constants.dart';
import 'package:healthe/main.dart';

class Emr extends StatefulWidget {
  @override
  _EmrState createState() => _EmrState();
}
class _EmrState extends State<Emr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 36.0)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Hasil EMR",
                style: TextStyle(
                  fontSize: 26.0,
                )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 24.0)),
            Expanded(child: _emrWidget()),
          ],
          crossAxisAlignment: CrossAxisAlignment.start
        )
      )
    );
  }

  Widget _emrWidget() {
    //bool isEmpty = true;
    bool isEmpty = false;
    if(isEmpty)
      return Column(
        children: [
          Spacer(),
          Text(
            'Tidak ada riwayat.',
            style: TextStyle(
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.only(top: 16.0)),
          Text(
            'Daftarkan dirimu segera untuk dapat kami periksa lebih lanjut',
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.only(top: 32.0)),
          _verifyData(),
          Spacer(),
        ],
        mainAxisAlignment: MainAxisAlignment.center
      );
    else
      return ListView(
        children: [
          _emrSingle(new DateTime.utc(2020,11,26), "Deskripsi 1"),
          _emrSingle(new DateTime.utc(2020,11,25), "Deskripsi 2"),
          _emrSingle(new DateTime.utc(2020,11,24), "Deskripsi 3"),
          _emrSingle(new DateTime.utc(2020,11,20), "Deskripsi 4"),
          _emrSingle(new DateTime.utc(2020,10,15), "Deskripsi 5"),
          _emrSingle(new DateTime.utc(2020,9,15), "Deskripsi 6"),
          _emrSingle(new DateTime.utc(2020,8,15), "Deskripsi 7"),
          _emrSingle(new DateTime.utc(2020,7,15), "Deskripsi 8"),
          _emrSingle(new DateTime.utc(2020,6,15), "Deskripsi 9"),
          _emrSingle(new DateTime.utc(2020,5,15), "Deskripsi 10"),
        ],
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      );
  }

  Widget _verifyData() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        width: double.infinity,
        child: Text(
          'Verifikasi Data Pasien',
          style: TextStyle(color: ColorPalette.primaryColor),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onTap: () {
      },
    );
  }

  Widget _emrSingle(DateTime time, description) {
    String timeString = "";
    switch(-time.difference(DateTime.now()).inDays){
      case 0: timeString = "Hari Ini"; break;
      case 1: timeString = "Kemarin"; break;
      case 2: timeString = "2 hari yang lalu"; break;
      case 3: timeString = "3 hari yang lalu"; break;
      case 4: timeString = "4 hari yang lalu"; break;
      case 5: timeString = "5 hari yang lalu"; break;
      case 6: timeString = "6 hari yang lalu"; break;
      default: 
        List<String> months = [
          'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
          'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
        ];
        timeString = time.day.toString() + " " + months[time.month - 1] + " " + time.year.toString();
      break;
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                timeString,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(padding: EdgeInsets.only(top: 8.0)),
              Text(
                description,
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