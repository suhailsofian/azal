import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:neecoder/app/controllers/languages_controller.dart';
import 'package:neecoder/app/utils/httpConfig/HttpsConnect.dart' as httpp;

import '../data/models/QuastionAndAnswer.dart';

class HomeController extends GetxController {
  final boxs = GetStorage().obs;
  var terms = ''.obs;
  var privacy = ''.obs;
  var logoSite = ''.obs;
  var logoSplash = ''.obs;
  var facebook = ''.obs;
  var whatsapp = ''.obs;
  var hotline = ''.obs;
  var website = ''.obs;
  RxList<Map<dynamic, dynamic>> itemss =
      [{}].obs as RxList<Map<dynamic, dynamic>>;
  RxBool loading = false.obs;
  HomeController() {
    loadLogoSplashFromApi();
    loadLogoSiteFromApi();
    loadQuastionAndAnswerFromApi();
    loadHotLineFromApi();
    loadWHATSAPPFromApi();
    loadWEBSITEFromApi();
    loadFaceBookFromApi();
    loadTermsFromApi();
    loadPolicyFromApi();
  }

  loadWEBSITEFromApi() async {
    // loading(true);
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var url2 = Uri.parse('https://apply.azal-ye.com/api/company');
    //print(url2);
    Map body2;

    body2 = {
      "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
      "key": "site.WEBSITE"
    };

    //print(body2);
    if (boxs.value.read("website") == null) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response2 =
          await httppo.post(url2, headers: headers2, body: jsonEncode(body2));

      final json = jsonDecode(response2.body);
      print('WEBSITE');
      print(json);
      if (json['status'] == true) {
        website.value = json["data"][0][0][0]['value'];
        boxs.value.write("website", json["data"][0][0][0]['value']);
      }
    } else {
      print('cache website');
      print(boxs.value.read("website"));
      website.value = boxs.value.read("website");
    }
  }

  loadHotLineFromApi() async {
    // loading(true);
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var url2 = Uri.parse('https://apply.azal-ye.com/api/company');
    //print(url2);
    Map body2;

    body2 = {
      "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
      "key": "site.HOT_LINE"
    };

    //print(body2);
    if (boxs.value.read("hotline") == null) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response2 =
          await httppo.post(url2, headers: headers2, body: jsonEncode(body2));

      final json = jsonDecode(response2.body);
      print('HOT_LINE');
      print(json);
      if (json['status'] == true) {
        hotline.value = json["data"][0][0][0]['value'];
        boxs.value.write("hotline", json["data"][0][0][0]['value']);
      }
    } else {
      print('cache hotline');
      print(boxs.value.read("hotline"));
      hotline.value = boxs.value.read("hotline");
    }

    // loading(false);
  }

  loadWHATSAPPFromApi() async {
    // loading(true);
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var url2 = Uri.parse('https://apply.azal-ye.com/api/company');
    //print(url2);
    Map body2;

    body2 = {
      "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
      "key": "site.WHATSAPP"
    };

    //print(body2);
    if (boxs.value.read("whatsapp") == null) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response2 =
          await httppo.post(url2, headers: headers2, body: jsonEncode(body2));

      final json = jsonDecode(response2.body);
      print('WHATSAPP');
      print(json);
      if (json['status'] == true) {
        whatsapp.value = json["data"][0][0][0]['value'];
        boxs.value.write("whatsapp", json["data"][0][0][0]['value']);
      }
    } else {
      print('cache whatsapp');
      print(boxs.value.read("whatsapp"));
      whatsapp.value = boxs.value.read("whatsapp");
    }
  }

  loadLogoSiteFromApi() async {
    // loading(true);
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var url2 = Uri.parse('https://apply.azal-ye.com/api/company');
    //print(url2);
    Map body2;

    body2 = {
      "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
      "key": "site.logo"
    };

    //print(body2);
    if (boxs.value.read("logoSite") == null) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response2 =
          await httppo.post(url2, headers: headers2, body: jsonEncode(body2));

      final json = jsonDecode(response2.body);
      print('logoSite');
      print(json);
      if (json['status'] == true) {
        // logoSite.value = json["data"][0][1]['image_path'];
        logoSite.value = json["data"][0][1]['image_path'] +
            "/" +
            json["data"][0][0][0]['value'];
        print(logoSite);
        boxs.value.write(
            "logoSite",
            json["data"][0][1]['image_path'] +
                "/" +
                json["data"][0][0][0]['value']);
      }
    } else {
      print('cache logoSite');
      print(boxs.value.read("logoSite"));
      logoSite.value = boxs.value.read("logoSite");
    }
  }

  loadFaceBookFromApi() async {
    // loading(true);
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var url2 = Uri.parse('https://apply.azal-ye.com/api/company');
    //print(url2);
    Map body2;

    body2 = {
      "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
      "key": "site.FACEBOOK"
    };

    //print(body2);
    if (boxs.value.read("facebook") == null) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response2 =
          await httppo.post(url2, headers: headers2, body: jsonEncode(body2));

      final json = jsonDecode(response2.body);
      print('FACEBOOK');
      print(json);
      if (json['status'] == true) {
        facebook.value = json["data"][0][0][0]['value'];

        boxs.value.write("facebook", json["data"][0][0][0]['value']);
      }
    } else {
      print('cache facebook');
      print(boxs.value.read("facebook"));
      facebook.value = boxs.value.read("facebook");
    }
  }

  loadLogoSplashFromApi() async {
    // loading(true);
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var url2 = Uri.parse('https://apply.azal-ye.com/api/company');
    //print(url2);
    Map body2;

    body2 = {
      "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
      "key": "Splash.logo"
    };

    //print(body2);
    if (boxs.value.read("logoSplash") == null) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response2 =
          await httppo.post(url2, headers: headers2, body: jsonEncode(body2));

      final json = jsonDecode(response2.body);
      print('logoSplash');
      print(json);
      if (json['status'] == true) {
        logoSplash.value = json["data"][0][1]['image_path'] +
            "/" +
            json["data"][0][0][0]['value'];

        print(logoSplash);
        boxs.value.write(
            "logoSplash",
            json["data"][0][1]['image_path'] +
                "/" +
                json["data"][0][0][0]['value']);
      }
    } else {
      print('cache logoSplash');
      print(boxs.value.read("logoSplash"));
      logoSplash.value = boxs.value.read("logoSplash");
    }
  }

  loadQuastionAndAnswerFromApi() async {
    loading(true);
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var url2 = Uri.parse('https://www.azal-ye.com/api/questions-answers');
    //print(url2);
    Map body2 = {
      "lang_id": Get.find<LanguageController>()
          .savedLang
          .value
          .toString()
          .toLowerCase()
    };

    //print(body2);
    final IOClient httppo = await httpp.HttpsConnect().https();
    var response2 =
        await httppo.post(url2, headers: headers2, body: jsonEncode(body2));

    final json = jsonDecode(response2.body);
    List<QuastionAndAnswer> tagObjs;
    // List<Map<String, dynamic>> _items;
    var jsons = json["data"] as List;
    // print(jsons);
    if (Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase() ==
        'ar') {
      tagObjs = jsons
          .map((tagJson) => QuastionAndAnswer.fromJsonAr(tagJson))
          .toList();
      itemss.value = tagObjs.map((tagJson1) => tagJson1.toJson()).toList();
    } else {
      tagObjs = jsons
          .map((tagJson) => QuastionAndAnswer.fromJsonEn(tagJson))
          .toList();
      itemss.value = tagObjs.map((tagJson1) => tagJson1.toJson()).toList();
    }
    loading(false);
  }

  loadTermsFromApi() async {
    loading(true);
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var url2 = Uri.parse('https://apply.azal-ye.com/api/company');
    //print(url2);
    Map body2;
    if (Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase() ==
        'ar') {
      body2 = {
        "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
        "key": "site.Terms_of_use_ar"
      };
    } else {
      body2 = {
        "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
        "key": "site.Terms_OF_USE_en"
      };
    }

    final IOClient httppo = await httpp.HttpsConnect().https();
    var response2 =
        await httppo.post(url2, headers: headers2, body: jsonEncode(body2));

    final json = jsonDecode(response2.body);
    //print('terms');
    terms.value = json["data"][0][0][0]['value'];
    ;
    //print(terms);
    loading(false);
  }

  loadPolicyFromApi() async {
    loading(true);
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var url2 = Uri.parse('https://apply.azal-ye.com/api/company');
    //print(url2);
    Map body2;
    if (Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase() ==
        'ar') {
      body2 = {
        "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
        "key": "site.Privacy_policy_ar"
      };
    } else {
      body2 = {
        "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
        "key": "site.Privacy_policy_en"
      };
    }
    //print(body2);
    final IOClient httppo = await httpp.HttpsConnect().https();
    var response2 =
        await httppo.post(url2, headers: headers2, body: jsonEncode(body2));

    final json = jsonDecode(response2.body);

    privacy.value = json["data"][0][0][0]['value'];

    loading(false);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
