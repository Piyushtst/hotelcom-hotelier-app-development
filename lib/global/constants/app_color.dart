// App Colors

import 'package:flutter/material.dart';

class AppColor {
  static const transparent = Color(0x00FFFFFF);
  static const black = Color(0xff000000);
  static const blackText = Color(0xff0C0F0A);
  static const white = Color(0xFFFFFFFF);
  static const red = Color(0xFFFC5012);
  static const green = Color(0xFF53CA20);
  static const purple = Color(0xFF6350FF);
  static const teal = Color(0xFF5E548E);
  static const backgroungGray = Color(0xFFF5F5F5);
  static const grey = Colors.grey;
  static const amber = Colors.amber;
  static const primary = Color(0xFF0B0A0F);
  static const borderGrayColor = Color(0xFFCDCDCD);
  static const orangeColor = Color(0xFFFC5012);
  static const textOrangeColor = Color(0xFFD28107);
  static const textGrayColor = Color(0xFF8D8D8D);
  static const titleGrayColor = Color(0xFF727272);
  static const cardGrayColor = Color(0xFFEDEDED);
  static const cardBorderGrayColor = Color(0xFFD9D9D9);

  // Hexadecimal Color
  static Color hexGrey = fromHex('#121212');

  static Color fromHex(
    String hexString,
  ) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write(
        'ff',
      );
    }
    buffer.write(
      hexString.replaceFirst(
        '#',
        '',
      ),
    );
    return Color(
      int.parse(
        buffer.toString(),
        radix: 16,
      ),
    );
  }
}
