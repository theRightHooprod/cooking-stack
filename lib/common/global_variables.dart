import 'package:flutter/material.dart';

class GlobalVar {
  GlobalVar._();

  static Color black = const Color(0xff1c1c1c);
  static Color orange = const Color(0xffdc582a);
  static Color red = const Color(0xffd3273e);

  static String waAccessToken =
      'EAAwVvInHpgYBAJ7ZCTqLfouWcjBWBPODDlq9kWSxNLUiTqeUZAyEivgSLTiMxxv3PBgSZBNViOovzhJ3X9p1wEUXFgvVS4IJfgSkGzBUnukYp3PUWFGShFLZAaIJvZAXEiSIGZAh9MXMTmQp2sOyE5WSzZA6IbAo9QjCA1P8wlMsj8beZAjhkpl3lAOumpJigTmzoljPXHto1mTTJMd63fsSWwhkJ4E5oYwZD';
  static int fromid = 110235615246028;

  static String accountAkinator(String uid) {
    if (uid == '1OxEdNtRtkedc0aDHvhMgtyjfwx1') {
      return 'admin';
    } else if (uid == 'oBtMtP8gWXZfWWJlJEzHeIvoVMx2') {
      return 'kitchen';
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
