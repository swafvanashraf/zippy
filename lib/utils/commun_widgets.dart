import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor:
        //  Color.fromARGB(255, 54, 45, 45),
        Colors.black,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}

Widget logo() {
  return Image.asset(
    'asset/logo.png',
    width: 40, // Adjust the width as needed
    height: 35, // Adjust the height as needed
    fit: BoxFit.cover, // Adjust the fit as needed
  );
}
