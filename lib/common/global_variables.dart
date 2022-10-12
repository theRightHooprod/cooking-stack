import 'package:flutter/material.dart';

class GlobalVar {
  GlobalVar._();

  static Color black = const Color(0xff1c1c1c);
  static Color orange = const Color(0xffdc582a);

  static AppBar asd = AppBar(
    centerTitle: true,
    title: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
      Text(
        'Cooking Stack',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        Icons.fastfood_sharp,
        color: Colors.white,
        size: 25,
      )
    ]),
  );
}
