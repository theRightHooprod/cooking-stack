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
