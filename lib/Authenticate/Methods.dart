import 'package:chat/Authenticate/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<User> createAccount(String name, String email, String password) async {
  FirebaseAuth _fireAuth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCrendetial = await _fireAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    print("Account created Succesfully");

    userCrendetial.user.updateDisplayName(name);

    await _firestore.collection('users').doc(_fireAuth.currentUser.uid).set({
      "name": name,
      "email": email,
      "status": "Unavalible",
      "uid": _fireAuth.currentUser.uid,
    });

    return userCrendetial.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User> logIn(String email, String password) async {
  FirebaseAuth _fireAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _fireAuth.signInWithEmailAndPassword(
        email: email, password: password);

    print("Login Sucessfull");
    _firestore
        .collection('users')
        .doc(_fireAuth.currentUser.uid)
        .get()
        .then((value) => userCredential.user.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _fireAuth = FirebaseAuth.instance;

  try {
    await _fireAuth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}
