import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:healthe/login/login.dart';
import 'package:healthe/main.dart';
import 'package:healthe/user.model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

enum AppState { DATA_NOT_FETCHED, FETCHING_DATA, DATA_READY, NO_DATA }

class _HomeState extends State<Home> {
  final databaseReference = Firestore.instance;
  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;
  FirebaseAuth auth = FirebaseAuth.instance;
  dynamic data;
  @override
  void initState() {
    super.initState();

    // Assign widget based on availability of currentUser
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      if (FirebaseAuth.instance.currentUser() == null) {
        Navigator.pushNamed(context, '/login');
      }
    });
    // if (FirebaseAuth.instance.currentUser() != null) {
    //   Navigator.pushNamed(context, '/login');
    // }
    // else getUserDoc();

    // if(FirebaseAuth.instance.currentUser() != null){
    //   // wrong call in wrong place!
    //   Navigator.of(context).pushReplacement(MaterialPageRoute(
    //       builder: (context) => LoginPage()
    //   ));
    // }
    // loginCheck();
    getUserDoc();
  }

  Future<FirebaseUser> loginCheck() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if(_auth.currentUser() == null){
      // wrong call in wrong place!
      Navigator.pushNamed(context, '/login');
    }
  }

  Future<dynamic> getUserDoc() async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    // if(_auth.currentUser() == null){
    //   // wrong call in wrong place!
    //   Navigator.pushNamed(context, '/login');
    // }

    FirebaseUser user = await _auth.currentUser();
    DocumentReference namaref = _firestore.collection('users').document(user.uid);
    await namaref.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
      });
    });
    nama = 'Halo, ' + data['firstname'];

    DocumentReference heartref = _firestore.collection('scan').document(user.uid);
    await heartref.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
      });
    });
    getHeartbeat = data['HEART_RATE'];
    heartbeat = '' + getHeartbeat.toString();
    // return ref;
  }
  Future<void> fetchData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      _state = AppState.FETCHING_DATA;
    });

    /// Get everything from midnight until now
    DateTime endDate = DateTime.now();
    // DateTime startDate = DateTime(2020, 11, 24);
    DateTime startDate = endDate.subtract(new Duration(hours: 50));

    HealthFactory health = HealthFactory();

    /// Define the types to get.
    List<HealthDataType> types = [
      HealthDataType.BODY_MASS_INDEX,
      HealthDataType.HEIGHT,
      HealthDataType.WEIGHT,
      HealthDataType.HEART_RATE,
      HealthDataType.BODY_TEMPERATURE,
    ];

    /// You can request types pre-emptively, if you want to
    /// which will make sure access is granted before the data is requested
   bool granted = await health.requestAuthorization(types);

    /// Fetch new data
    List<HealthDataPoint> healthData =
    await health.getHealthDataFromTypes(startDate, endDate, types);

    /// Save all the new data points
    _healthDataList.addAll(healthData);

    /// Filter out duplicates
    _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

    /// Print the results
    _healthDataList.forEach((x) => print("Data point: $x"));

    /// Update the UI to display the results
    setState(() {
      _state = _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
    });
    double height = 0;
    double weight = 0;
    double bmi = 0;
    double heart = 0;
    double temp = 0;
    for(var i in _healthDataList) {
      HealthDataPoint p = i;
      print("AAAAA: $p");

      if (p.typeString == 'WEIGHT') weight = p.value;
      if (p.typeString == 'HEIGHT') height = p.value;
      if (p.typeString == 'BODY_MASS_INDEX')bmi = p.value;
      if (p.typeString == 'HEART_RATE')heart = p.value;
      if (p.typeString == 'BODY_TEMPERATURE')temp = p.value;
    }
    await databaseReference.collection("scan")
        .document(user.uid)
        .setData({
      'WEIGHT': weight,
      'HEIGHT': height,
      'BODY_MASS_INDEX': bmi,
      'HEART_RATE': heart,
      'BODY_TEMPERATURE': temp
    });
  }

  Widget _contentFetchingData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              strokeWidth: 10,
            )),
        Text('Fetching data...')
      ],
    );
  }

  String nama = '';
  double getHeartbeat = 0;
  String heartbeat = '0';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(nama),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  // _temperature(),
                  _heartBeat(),
                  // _device(),
                  _content()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _temperature() {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 16.0),),
        Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              print('Card tapped.');
            },
            child: Container(
              width: 300,
              height: 100,
              child: Center(
                child: Text(
                  'Suhu 36.8 C',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0),
        ),
        Center(
          child: Text(
            'Last checked 22/10 00:10'
          ),
        ),
      ],
    );
  }

  // Widget _contentDataReady() {
  //   return ListView.builder(
  //       scrollDirection: Axis.vertical,
  //       shrinkWrap: true,
  //       itemCount: _healthDataList.length,
  //       itemBuilder: (_, index) {
  //         HealthDataPoint p = _healthDataList[index];
  //         return Text(
  //           'Fetching data success'
  //           // title: Text("${p.typeString}: ${p.value}"),
  //           // trailing: Text('${p.unitString}'),
  //           // subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
  //         );
  //
  //     });
  // }
  Widget _contentDataReady() {
    return Text(
      'Fetching data success'
    );
  }

  Widget _contentNoData() {
    return Text('No Data to show');
  }

  Widget _contentNotFetched() {
    return Text('Press the card to fetch data');
  }
  Widget _content() {
    if (_state == AppState.DATA_READY)
      return _contentDataReady();
    else if (_state == AppState.NO_DATA)
      return _contentNoData();
    else if (_state == AppState.FETCHING_DATA) return _contentFetchingData();

    return _contentNotFetched();
  }
  Widget _heartBeat() {
    String a = 'x';
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 30.0),),
        Card(
          child: new InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () async{
              fetchData();
            },
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 30.0),),
                ListTile(
                  title: Text(
                    heartbeat,
                    style: TextStyle(
                    fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  subtitle: const Text(
                    'Hearts Beat',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30.0),),
              ],

            ),

          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0),
        ),
      ],
    );
  }
  Widget _device() {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 60.0),),
        Center(
          child: Text(
            'Samsung Band S20',
            style: TextStyle(
              fontSize: 26.0,
            ),
          ),
        ),
      ],
    );
  }
}