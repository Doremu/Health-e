import 'package:firebase_database/firebase_database.dart';

class User {
  String email;
  String firstname;
  String lastname;
  String username;

  User(this.email, this.firstname, this.lastname, this.username);

  User.fromSnapshot(DataSnapshot snapshot) :
        email = snapshot.value["email"],
        firstname = snapshot.value["firstname"],
        lastname = snapshot.value["lastname"],
        username = snapshot.value["username"];

  toJson() {
    return {
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "username" : username
    };
  }
}