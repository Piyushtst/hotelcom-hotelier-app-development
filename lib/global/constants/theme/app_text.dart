// App Text

import 'package:flutter/material.dart';

Widget loginText({
  required String txt,
}) {
  return Text(
    txt,
    textAlign: TextAlign.start,
    style: const TextStyle(
      fontSize: 25.0,
    ),
  );
}
