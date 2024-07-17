import 'package:flutter/material.dart';
import 'colors.dart';

final ButtonStyle colorBtnStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  shadowColor: MaterialStateProperty.all<Color>(Colors.green),
  backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
      return primaryColor;
    },
  ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28.0),
    ),
  ),
);
final ButtonStyle colorBtnWithRadiusStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  shadowColor: MaterialStateProperty.all<Color>(Colors.green),
  backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
      return primaryColor;
    },
  ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(11.0),
    ),
  ),
);
final ButtonStyle borderedBtnStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  shadowColor: MaterialStateProperty.all<Color>(Colors.white),
  backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
      return white;
    },
  ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(side: const BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(26.0),
    ),
  ),
);
final ButtonStyle borderedRadius6BtnStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  shadowColor: MaterialStateProperty.all<Color>(Colors.white),
  backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
      return white;
    },
  ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(side: const BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(6.0),
    ),
  ),
);
final ButtonStyle whiteBtnStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  shadowColor: MaterialStateProperty.all<Color>(Colors.white),
  backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
      return white;
    },
  ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(26.0),
    ),
  ),
);

final ButtonStyle greyBtnStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  shadowColor: MaterialStateProperty.all<Color>(Colors.white),
  backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
      return darkGrey;
    },
  ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(11.0),
    ),
  ),
);
