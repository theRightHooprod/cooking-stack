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

import 'package:cooking_stack/common/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/whatsapp.dart';

class CustomWa {
  CustomWa._();

  static late WhatsApp whatsapp;

  static void init() async {
    whatsapp = WhatsApp();
    final prefs = await SharedPreferences.getInstance();

    whatsapp.setup(
        accessToken: prefs.getString('wkey'),
        fromNumberId: int.parse(prefs.getString('numberid') ?? '0'));
  }

  static void sendAdded(int to, List<Map<String, dynamic>> orders) {
    List<String> products = [];

    for (var order in orders) {
      products.add(order['name']);
    }

    try {
      whatsapp.messagesText(
          to: to,
          message:
              'Hola 🤖! tu pedido ahora se encuentra en estado de *EN PREPARACIÓN* \n\nTu orden contiene: \n${MyUtils.getSingleString(products)}\n\n _*Mensaje automatico, no responder*_ \n\n *_Att. Cooking Stack_*');
    } catch (e) {
      rethrow;
    }
  }

  static void sendReady(int to) {
    try {
      whatsapp.messagesText(
          to: to,
          message:
              'Hola 🤖! tu pedido ya se encuentra *TERMINADO* \n\n¡Ya puedes pasar a la cafetería ☕️!\n\n _*Mensaje automatico, no responder*_ \n\n *_Att. Cooking Stack_*');
    } catch (e) {
      rethrow;
    }
  }

  static void sendNotPossible(int to) {
    try {
      whatsapp.messagesText(
          to: to,
          message:
              'Hola 🤖! tu pedido se ha marcado como *NO POSIBLE* \n\nTalvez se nos acabó algún ingrediente, lo siento 😪\n\n _*Mensaje automatico, no responder*_ \n\n *_Att. Cooking Stack_*');
    } catch (e) {
      rethrow;
    }
  }
}
