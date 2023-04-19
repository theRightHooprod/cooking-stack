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

import 'global_variables.dart';

class CustomTheme {
  CustomTheme._();

  static var theme = ThemeData(
      primaryColor: GlobalVar.orange,
      appBarTheme: AppBarTheme(
        color: GlobalVar.orange,
      ),
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: GlobalVar.orange),
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
