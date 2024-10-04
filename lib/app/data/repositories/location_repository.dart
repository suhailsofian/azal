import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:neecoder/app/controllers/languages_controller.dart';

class LocationRepository {
  loadLocationFromRepo() async {
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var url2 = Uri.parse('https://www.azal-ye.com/api/branches');

    Map body = {
      "lang_id": Get.find<LanguageController>()
          .savedLang
          .value
          .toString()
          .toLowerCase()
    };

    http.Response response2 =
        await http.post(url2, headers: headers2, body: jsonEncode(body));
    if (response2.statusCode == 200) {
      final json = jsonDecode(response2.body);
      print('loadLocationFromRepo');

      if (json["status"] == true) {
        return json['data'];
      } else {
        throw json["message"] ?? "Unknown Error Occured";
      }
    } else {
      throw jsonDecode(response2.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
