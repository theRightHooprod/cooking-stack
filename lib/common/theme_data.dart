import 'package:flutter/material.dart';

import 'global_variables.dart';

class CustomTheme {
  CustomTheme._();

  static var theme = ThemeData(
      primaryColor: const Color(0xffdc582a),
      appBarTheme: AppBarTheme(
        color: GlobalVar.orange,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: GlobalVar.orange,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: GlobalVar.orange),
        ),
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 20, color: GlobalVar.black)),
      iconTheme: IconThemeData(color: GlobalVar.black),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: MaterialStateProperty.all(GlobalVar.orange))));
}
