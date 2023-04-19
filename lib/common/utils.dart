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
        singlestring += list[i] + '.';
      }
    }

    return singlestring;
  }
}

class CustomOrder {
  double totalPrice;
  DateTime created = DateTime.now();
  List<Map<String, dynamic>> products;
  String clientname;
  String whatsappNumber;

  CustomOrder(
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
