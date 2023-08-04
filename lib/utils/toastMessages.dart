import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void errorMessage(String msg) async {

  await   Fluttertoast.showToast(
    msg: "THE toast message",
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
bool isEmailValid(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

bool isPasswordValid(String password) {
  if (password.length < 8) {
    return false;
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return false;
  }
  if (!password.contains(RegExp(r'[a-z]'))) {
    return false;
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    return false;
  }
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return false;
  }

  return true;
}


void showSnackBar(String msg, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
      content: Text(msg),
    ),
  );
}