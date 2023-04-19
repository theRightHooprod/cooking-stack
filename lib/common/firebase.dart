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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_stack/common/utils.dart';

class MyFirebase {
  MyFirebase._();

  static var miscellaneous =
      FirebaseFirestore.instance.collection('miscellaneous');
  static var orders = FirebaseFirestore.instance.collection('orders');

  static Future<void> addMiscellaneous(
      {required String name,
      double price = 0,
      required String picture,
      required List<String> description,
      bool isInventoried = false,
      int cantidad = 0}) async {
    try {
      if (name.isEmpty) {
        throw Exception('El nombre no puede estar vacío');
        //   } else if (picture.isEmpty) {
        //     throw Exception('La imagen no puede estar vacía');
      } else {
        cantidad != 0 ? description = [] : description = description;
        miscellaneous.add({
          'name': await MyUtils.cutAndLowerString(name),
          'picture': picture,
          'created': DateTime.now(),
          'cantidad': cantidad,
          'properties': await MyUtils.cutAndLowerList(description),
          'price': price
        });
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> addOrder({required CustomOrder order}) async {
    try {
      orders.add(order.toJson());
    } catch (error) {
      rethrow;
    }
  }
}
