import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credentials = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credentials);
  }

  void signUpUser({
    required String email,
    required String password,
    required String username,
    required String phoneNo,
    required BuildContext context,
  }) async {
    // Authentication
    await _auth.createUserWithEmailAndPassword(email: email.toString(), password: password.toString());


    // SharedPreferences
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('email', email.toString());


    // Data Store in Cloud Firestore
    await _firestore.collection('user').doc(_auth.currentUser!.uid).set({
      "email": email.toString(),
      "password": password.toString(),
      "username": username.toString(),
      "phoneNo": phoneNo.toString()
    });

    Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
  }
}
