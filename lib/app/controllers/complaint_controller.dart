import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:neecoder/app/controllers/auth_controller.dart';
import 'package:neecoder/app/controllers/landingPage_controller.dart';
import 'package:neecoder/app/controllers/languages_controller.dart';
import 'package:neecoder/app/controllers/registration_controller.dart';

import 'package:neecoder/app/utils/httpConfig/HttpsConnect.dart' as httpp;

import '../routes/app_routes.dart';

class ComplaintController extends GetxController {
  List allComplaints = [].obs;
  List complaints = [].obs;
  RxBool loadingOne = false.obs;
  var isButtonEnabled = true.obs;
  // RxList complaintsTypeList = [].obs;
  RxList userSearchItems = [].obs;
  RxBool loading = false.obs;
  ComplaintController() {
    loadcomplaintsReviewFromApi(null);
    Get.find<RegistrationController>().loadComplaintsTypeFromApi(null);
  }

  void onButtonClick() async {
    if (isButtonEnabled.value) {
      // Directly disable the button
      isButtonEnabled.value = false;

      // Simulate a delay (e.g., for a network request)
      await Future.delayed(Duration(seconds: 2));

      // Re-enable the button
      isButtonEnabled.value = true;
    }
  }

  loadcomplaintsReviewIdFromApi(id) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/complaints-review-id");

    var currentToken = Get.find<AuthController>().showToken();
    //print(loadingOne);
    loadingOne(true);
    var lang = Get.find<LanguageController>().savedLang.value;

    //print(lang);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    Map body = {"lang_id": lang.toString().toLowerCase(), "v_code_id": id};
    //print(body);
    final IOClient httppo = await httpp.HttpsConnect().https();
    var response =
        await httppo.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    print("loadcomplaintsReviewIdFromApi");
    print(json['data']);
    complaints = json['data'];
    loadingOne(false);
  }

  loadcomplaintsReviewFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/complaints-review");
    loading(true);
    var currentToken = Get.find<AuthController>().showToken();
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    //print(lang);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    Map body = {"lang_id": lang.toString().toLowerCase()};
    // final IOClient httppo = await httpp.HttpsConnect().https();
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    print("loadcomplaintsReviewFromApi");
    // print(json);
    allComplaints = json['data'];
    for (var element in allComplaints) {
      //print(element['main_classification']);
      element['main_classification'] =
          element['main_classification'][0]['issue_name'];
    }
    loading(false);
  }

  Future<dynamic> checkAddNewComplaints() async {
    bool ff;
    var mo;
    var currentToken = Get.find<AuthController>().showToken();
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    try {
      var url2 = Uri.parse('https://apply.azal-ye.com/api/check-complaints');
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

      if (response2.statusCode == 200) {
        final json = jsonDecode(response2.body);
        print(json);
        if (json["status"] == true) {
          // print(json["message"]);
          ff = true;
          mo = {"status": ff, "message": json["message"]};
          return true;
        } else {
          ff = false;
          mo = {"status": ff, "message": json["message"]};
          Get.find<LandingPageController>()
              .dialogMS(json["message"].toString());
          return false;
        }
      } else {
        ff = false;
        mo = {"status": ff, "message": "error"};

        throw jsonDecode(response2.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (message) {
      Get.find<LandingPageController>().dialogMS(message.toString());
      return false;
    }
  }

  Future<void> insertNewComplaints(complaintDetails, complaintSubject,
      selectedValue, selectedMainClassValue, selectedClassValue) async {
    print(userSearchItems.length);
    userSearchItems.add(1);
    // userSearchItems.clear();
    print(userSearchItems.length);
    if (userSearchItems.length == 1) {
      //   isButtonEnabled.value = false; // Disable the button after the first click
      var currentToken = Get.find<AuthController>().showToken();
      var headers2 = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $currentToken',
      };
      try {
        var url2 =
            Uri.parse('https://apply.azal-ye.com/api/complaints-requests');
        //print(url2);
        Map body2 = {
          "lang_id": Get.find<LanguageController>()
              .savedLang
              .value
              .toString()
              .toLowerCase(),
          "complaints": complaintSubject,
          "text": complaintDetails,
          "complaints_type": selectedValue,
          "main_classification": selectedMainClassValue,
          "classification": selectedClassValue,
          "token": "fDFrQkU3AwuC4aWuSCiUfrDQPV0NQX1tgkDJsxNK"
        };

        print(body2);
        final IOClient httppo = await httpp.HttpsConnect().https();
        var response2 =
            await httppo.post(url2, headers: headers2, body: jsonEncode(body2));
        //print(response2.body);

        if (response2.statusCode == 200) {
          final json = jsonDecode(response2.body);
          if (json["status"] == true) {
            // loadcomplaintsReviewFromApi(null);

            Get.find<LandingPageController>().dialogCheckMS(
                AppRoutes.comolaintsList, false,
                message: json["data"]);
            // isButtonEnabled.value = true;
          } else {
            throw json["message"] ?? "Unknown Error Occured";
          }
        } else {
          throw jsonDecode(response2.body)["errors"] ?? "Unknown Error Occured";
        }
      } catch (message) {
        Get.find<LandingPageController>().dialogMS(message.toString());
      }
    }
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
