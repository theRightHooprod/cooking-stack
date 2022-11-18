import 'package:flutter/material.dart';

import '../views/admin_view.dart';
import '../views/main_menu.dart';

class GlobalVar {
  GlobalVar._();

  static Color black = const Color(0xff1c1c1c);
  static Color orange = const Color(0xffdc582a);
  static Color red = const Color(0xffd3273e);

  static String accountAkinator(String uid) {
    if (uid == '1OxEdNtRtkedc0aDHvhMgtyjfwx1') {
      return 'admin';
    } else if (uid == 'oBtMtP8gWXZfWWJlJEzHeIvoVMx2') {
      return '/kitchen';
    } else {
      return '/';
    }
  }

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
