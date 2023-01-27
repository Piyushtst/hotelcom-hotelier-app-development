// SharedPreferences : Set, Get, Clear

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

setDataToLocalStorage({
  @required String? dataType,
  @required String? prefKey,
  bool? boolData,
  double? doubleData,
  int? integerData,
  String? stringData,
  List<String>? listOfStringData,
}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  switch (dataType) {
    case "BOOL":
      return sharedPreferences.setBool(
        prefKey!,
        boolData!,
      );
    case "DOUBLE":
      return sharedPreferences.setDouble(
        prefKey!,
        doubleData!,
      );
    case "INTEGER":
      return sharedPreferences.setInt(
        prefKey!,
        integerData!,
      );
    case "STRING":
      return stringData != null
          ? sharedPreferences.setString(
              prefKey!,
              stringData,
            )
          : "";
    case "LIST-OF-STRING":
      return sharedPreferences.setStringList(
        prefKey!,
        listOfStringData!,
      );
    default:
      return null;
  }
}

getDataFromLocalStorage({
  @required String? dataType,
  @required String? prefKey,
}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  switch (dataType) {
    case "BOOL":
      return sharedPreferences.getBool(
        prefKey!,
      );
    case "DOUBLE":
      return sharedPreferences.getDouble(
        prefKey!,
      );
    case "INTEGER":
      return sharedPreferences.getInt(
        prefKey!,
      );
    case "STRING":
      return sharedPreferences.getString(
        prefKey!,
      );
    case "LIST-OF-STRING":
      return sharedPreferences.getStringList(
        prefKey!,
      );
    default:
      return null;
  }
}

Future clearLocalStorage() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.clear();
  return true;
}
