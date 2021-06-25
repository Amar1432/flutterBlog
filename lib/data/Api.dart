import 'dart:convert';

import 'package:blog_app/constants/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Api {
  static getData() async {
    try {
      var response = await http.get(Constants.url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        print(response.statusCode);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static addPost(Map postData) async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    postData['date'] = formatter.format(now);
    try {
      http.Response response = await http.post(Constants.url,
          body: jsonEncode(postData),
          headers: {"content-type": "application/json"});
      return response;
    } catch (e) {
      print(e);
      return {};
    }
  }

  static deletePost(String uid) async {
    try {
      await http.delete(Uri.parse('${Constants.url.toString()}/$uid'));
      return 'success';
    } catch (e) {
      print(e);
      return 'failed';
    }
  }
}
