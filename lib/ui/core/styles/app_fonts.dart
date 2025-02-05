import 'package:flutter/material.dart';

class AppFonts {
  AppFonts._();

  static const String labradorFamily = 'LabradorA';

  static TextStyle bold(double size, [Color? color]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w700,
      fontFamily: labradorFamily,
    );
  }

  static TextStyle regular(double size, [Color? color]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w400,
      fontFamily: labradorFamily,
    );
  }

  static TextStyle medium(double size, [Color? color]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w500,
      fontFamily: labradorFamily,
    );
  }
}
