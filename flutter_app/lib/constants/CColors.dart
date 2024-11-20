import 'package:flutter/material.dart';

abstract class CColor {
  static const Color mainRed =
  Color.fromRGBO(160, 14, 19, 1); //Color(0xFFE3211E);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color bgColor = Color.fromRGBO(242, 242, 242, 1);
  static const Color lightGrey = Color.fromRGBO(190, 190, 190, 1);
  static const Color borderGrey = Color(0xFFE1E1E1);
  static const Color eventGrey = Color.fromRGBO(147, 145, 145, 1);
  static const Color scoreGrey = Color.fromRGBO(208, 208, 208, 1);
  static const Color dateGrey = Color.fromRGBO(83, 83, 83, 1);
  static const Color secondaryRed = Color.fromRGBO(227, 33, 30, 1);
  static const Color fadedRed = Color.fromRGBO(242, 155, 158, 1);
  static const Color yellowCard = Color.fromRGBO(242, 169, 5, 1);

  static Color appBarColor = Colors.grey.shade700;
  static Color? appBarColor2 = Colors.grey[200];
  static const Color backgroundGrey = Color.fromRGBO(81, 81, 81, 0.96);
  static const Color backgroundLightGrey = Color.fromRGBO(81, 81, 81, 0.2);
  static Color shadowDarkGrey = Colors.grey.shade900;
}
