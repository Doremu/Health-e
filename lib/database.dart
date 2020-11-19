import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String firstname) async {
  final CollectionReference users = Firestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseUser user = await auth.currentUser();
  String uid = user.uid.toString();

  users.add({
    'firstname': firstname, 'uid' : uid
  });
}