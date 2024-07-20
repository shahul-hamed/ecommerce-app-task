import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility {
  static showToast(String msg, [Color? color]) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: color,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}