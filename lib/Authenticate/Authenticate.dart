import 'package:chat/Authenticate/LoginScreen.dart';
import 'package:chat/Screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_fireAuth.currentUser != null) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
