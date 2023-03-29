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
      required List<String> description}) async {
    try {
      if (name.isEmpty) {
        throw Exception('El nombre no puede estar vacío');
        //   } else if (picture.isEmpty) {
        //     throw Exception('La imagen no puede estar vacía');
      } else {
        miscellaneous.add({
          'name': await MyUtils.cutAndLowerString(name),
          'picture': picture,
          'created': DateTime.now(),
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
