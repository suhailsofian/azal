import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:neecoder/app/controllers/languages_controller.dart';
import 'package:neecoder/app/data/models/product.dart';

class ProductsRepository {
  var url = "https://fakestoreapi.com/products";
  var imagePath = ''.obs;

  loadProductsFromApi() async {
    try {
      var headers2 = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var url2 = Uri.parse('https://www.azal-ye.com/api/products');

      Map body2 = {
        "lang_id": Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase()
      };

      http.Response response2 =
          await http.post(url2, headers: headers2, body: jsonEncode(body2));

      final json = jsonDecode(response2.body);

      List<Product> tagObjs;
      var jsons = json["data"][0] as List;
      if (Get.find<LanguageController>()
              .savedLang
              .value
              .toString()
              .toLowerCase() ==
          'ar') {
        tagObjs = jsons.map((tagJson) => Product.fromJsonAr(tagJson)).toList();
      } else {
        tagObjs = jsons.map((tagJson) => Product.fromJsonEn(tagJson)).toList();
      }

      imagePath.value = json["data"][1]['image_path'];

      return tagObjs;
    } catch (error) {}
  }
}
