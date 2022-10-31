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
}
