//     CookingStack - A semi-automated WhatsApp notificator for cooking orders
//     Copyright (C) 2023 theRightHoopRod

//     This program is free software: you can redistribute it and/or modify
//     it under the terms of the GNU Affero General Public License as published
//     by the Free Software Foundation, either version 3 of the License.

//     This program is distributed in the hope that it will be useful,
//     but WITHOUT ANY WARRANTY; without even the implied warranty of
//     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//     GNU Affero General Public License for more details.

//     You should have received a copy of the GNU Affero General Public License
//     along with this program.  If not, see <https://www.gnu.org/licenses/>.

//     Contact me at: https://github.com/theRightHooprod or hoop3.1416@gmail.com

import 'package:flutter/material.dart';

class GlobalVar {
  GlobalVar._();

  static Color black = const Color(0xff1c1c1c);
  static Color orange = const Color(0xffdc582a);
  static Color red = const Color(0xffd3273e);

  static bool isProd = false;

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
    title: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
