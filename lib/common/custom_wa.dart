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
        fromNumberId: int.parse(prefs.getString('numberid')!));
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
