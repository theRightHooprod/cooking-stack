class MyUtils {
  MyUtils._();

  static String listToJson(List<String> data) {
    String json = "[";
    for (int i = 0; i < data.length; i++) {
      json += '"${data[i]}"';
      if (i != data.length - 1) {
        json += ',';
      }
    }
    json += "]";
    return json;
  }

  static Future<String> cutAndLowerString(String data) async =>
      data.trimRight().trimLeft().toLowerCase();

  static Future<List> cutAndLowerList(List data) async {
    List<String> fixed = [];
    for (var element in data) {
      fixed.add(element.trimLeft().trimRight().toLowerCase());
    }
    return fixed;
  }

  static String getSingleString(List<dynamic> list) {
    String singlestring = '';

    for (int i = 0; i < list.length; i++) {
      if (i < list.length - 1) {
        singlestring += list[i] + ', ';
      } else {
        singlestring += list[i];
      }
    }

    return singlestring;
  }
}

class Order {
  double totalPrice;
  DateTime created = DateTime.now();
  List<Map<String, dynamic>> products;
  String clientname;
  String whatsappNumber;

  Order(
      {required this.totalPrice,
      required this.products,
      required this.clientname,
      required this.whatsappNumber});

  Map<String, dynamic> toJson() => {
        'totalprice': totalPrice,
        'created': created,
        'products': products,
        'clientname': clientname,
        'whatsappnumber': whatsappNumber
      };
}
