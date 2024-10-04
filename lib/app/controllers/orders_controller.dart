import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:neecoder/app/controllers/auth_controller.dart';
import 'package:neecoder/app/controllers/landingPage_controller.dart';
import 'package:neecoder/app/controllers/languages_controller.dart';
import 'package:neecoder/app/controllers/registration_controller.dart';
import 'package:neecoder/app/utils/httpConfig/HttpsConnect.dart' as httpp;

class OrdersController extends GetxController {
  RxBool loadingOne = false.obs;
  RxBool loading = false.obs;
  List allFunding = [].obs;
  Map funding = {}.obs;
  RxList userOrdersItems = [].obs;
  TextEditingController LoanPurpose = TextEditingController();
  TextEditingController rerquestAmount = TextEditingController();
  TextEditingController address = TextEditingController();
  var selectedPeriodTypeValue = ''.obs;
  var selectedGarenteeTypeValue = ''.obs;
  var selectedOtherGarenteeValue = ''.obs;
  var selectedClassActivityValue = ''.obs;
  var clientGovernorate = ''.obs;
  var clientDirectorate = ''.obs;
  var clientArea = ''.obs;
  var clientProduct = ''.obs;
  var selectedProductsPeriodValue = ''.obs;
  var selectedActivityValue = ''.obs;
  var selectedClassValue = ''.obs;
  OrdersController() {
    loadfundingReviewFromApi(null);
    Get.find<RegistrationController>().loadActivityClassFromApi(null);
    Get.find<RegistrationController>().loadClientGovernorateFromApi(null);
    Get.find<RegistrationController>().loadPeriodTypeFromApi(null);
  }

  loadFundingReviewIdFromApi(id) async {
    var url =
        Uri.parse("https://apply.azal-ye.com/api/funding-review-for-edit");

    var currentToken = Get.find<AuthController>().showToken();
    loadingOne(true);
    var lang = Get.find<LanguageController>().savedLang.value;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "v_app_id": id,
      "v_application_type": "2"
    };
    final IOClient httppo = await httpp.HttpsConnect().https();
    var response =
        await httppo.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    funding = json['data'];

    loadingOne(false);
  }

  loadfundingReviewFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/funding-review");
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
    print("loadfundingReviewFromApi1");

    allFunding.addAll(json['data'][0] as List);
    allFunding.addAll(json['data'][1] as List);

    loading(false);
  }

  Future<void> insertFundRequest(
      LoanPurpose,
      rerquestAmount,
      address,
      selectedPeriodTypeValue,
      selectedGarenteeTypeValue,
      selectedOtherGarenteeValue,
      selectedClassActivityValue,
      clientGovernorate,
      clientDirectorate,
      clientArea,
      selectedProductValue,
      selectedProductsPeriodValue,
      selectedActivityValue,
      landingPageController) async {
    print(userOrdersItems.length);
    userOrdersItems.add(1);
    // userOrdersItems.clear();
    print(userOrdersItems.length);
    if (userOrdersItems.length == 1) {
      var currentToken = Get.find<AuthController>().showToken();
      var headers2 = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $currentToken',
      };
      try {
        var url2 =
            Uri.parse('https://apply.azal-ye.com/api/insert-funding-requests');
        //print(url2);
        Map body2 = {
          "lang_id": Get.find<LanguageController>()
              .savedLang
              .value
              .toString()
              .toLowerCase(),
          "loanpurpose": LoanPurpose,
          "product_id": selectedProductValue,
          "request_amount": rerquestAmount,
          "request_period": selectedProductsPeriodValue,
          "activity_class": selectedClassActivityValue,
          "activity_id": selectedActivityValue,
          "activity_address": address,
          "clientgovernorate": clientGovernorate,
          "clientdirectorate": clientDirectorate,
          "activity_area": clientArea,
          "area_id": clientArea,
          "grantee_type": selectedGarenteeTypeValue,
          "other_garntee_type": selectedOtherGarenteeValue,
          "period_type": selectedPeriodTypeValue,
          "token": "fDFrQkU3AwuC4aWuSCiUfrDQPV0NQX1tgkDJsxNK"
        };

        //print(body2);
        final IOClient httppo = await httpp.HttpsConnect().https();
        var response2 =
            await httppo.post(url2, headers: headers2, body: jsonEncode(body2));
        print(response2.body);

        if (response2.statusCode == 200) {
          final json = jsonDecode(response2.body);
          if (json["status"] == true) {
            landingPageController.tabIndex.value = 4;

            landingPageController.dialogCheckMS("", true,
                message: json["data"].toString());
          } else {
            if (json["errors"] != null) {
              throw json["errors"] ?? "Unknown Error Occured";
            } else {
              throw json["message"] ?? "Unknown Error Occured";
            }
          }
        } else {
          if (jsonDecode(response2.body)["errors"] != null) {
            throw jsonDecode(response2.body)["errors"] ??
                "Unknown Error Occured";
          } else {
            throw jsonDecode(response2.body)["message"] ??
                "Unknown Error Occured";
          }
        }
      } catch (error) {
        landingPageController.dialogMS(error.toString());
      }
    }
  }

  Future<dynamic> updateFundRequest(
      id,
      LoanPurpose,
      rerquestAmount,
      address,
      selectedPeriodTypeValue,
      selectedGarenteeTypeValue,
      selectedOtherGarenteeValue,
      selectedClassActivityValue,
      clientGovernorate,
      clientDirectorate,
      clientArea,
      selectedProductValue,
      selectedProductsPeriodValue,
      selectedActivityValue) async {
    var currentToken = Get.find<AuthController>().showToken();
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    try {
      var url2 =
          Uri.parse('https://apply.azal-ye.com/api/update-funding-requests');
      //print(url2);
      Map body2 =
          // {
          {
        "lang_id": Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase(),
        "app_id": id,
        "loanpurpose": LoanPurpose.toString(),
        "product_id": selectedProductValue.toString(),
        "request_amount": rerquestAmount.toString(),
        "request_period": selectedProductsPeriodValue.toString(),
        "activity_class": selectedClassActivityValue.toString(),
        "activity_id": selectedActivityValue.toString(),
        "activity_address": address.toString(),
        "activity_area": clientArea.toString(),
        "area_id": clientArea.toString(),
        "grantee_type": selectedGarenteeTypeValue.toString(),
        "other_grantee_type": selectedOtherGarenteeValue.toString(),
        "period_type": selectedPeriodTypeValue.toString(),
        "token": "fDFrQkU3AwuC4aWuSCiUfrDQPV0NQX1tgkDJsxNK"
      };
      print('body2');
      print(body2);
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response2 =
          await httppo.post(url2, body: jsonEncode(body2), headers: headers2);
      print(response2.body);
      if (response2.statusCode == 200) {
        final json = jsonDecode(response2.body);
        print(json);
        if (json["status"] == true) {
          return jsonDecode(response2.body);
        } else {
          return jsonDecode(response2.body);
        }
      } else {
        return jsonDecode(response2.body);
      }
    } catch (error) {
      return error.toString();
    }
  }

  Future<dynamic> checkAddNewRequest() async {
    bool ff;
    var mo;
    var currentToken = Get.find<AuthController>().showToken();
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    try {
      var url2 =
          Uri.parse('https://apply.azal-ye.com/api/check-add-new-request');
      //print(url2);
      Map body2 = {
        "lang_id": Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase()
      };

      print(body2);
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response2 =
          await httppo.post(url2, headers: headers2, body: jsonEncode(body2));
      print(response2.body);

      if (response2.statusCode == 200) {
        final json = jsonDecode(response2.body);
        print(json["status"]);
        if (json["status"] == true) {
          // //print(json["message"]);
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
        mo = {"status": ff, "mesgsae": "error"};

        throw jsonDecode(response2.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      // Get.back();
      Get.find<LandingPageController>().dialogMS(error.toString());
      return false;
    }
  }

  Future<dynamic> postFundingRequests(id, landingPageController) async {
    print(id);

    var currentToken = Get.find<AuthController>().showToken();
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    try {
      var url2 =
          Uri.parse('https://apply.azal-ye.com/api/post-funding-requests');
      //print(url2);
      Map body2 = {
        "lang_id": Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase(),
        "app_id": id
      };

      final IOClient httppo = await httpp.HttpsConnect().https();
      var response2 =
          await httppo.post(url2, headers: headers2, body: jsonEncode(body2));
      print(response2.body);
      if (response2.statusCode == 200) {
        final json = jsonDecode(response2.body);
        if (json["status"] == true) {
          return json;
        } else {
          return json;
        }
      } else {
        return json;
      }
    } catch (error) {
      // Get.back();
      return jsonDecode(error.toString());
    }
    // }
  }

  viewfundingRequestIdFromApi(id) async {
    var url =
        Uri.parse("https://apply.azal-ye.com/api/funding-review-for-edit");
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };

    var lang = Get.find<LanguageController>().savedLang.value;

    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "v_app_id": id,
      "v_application_type": "2"
    };
    // print(body);
    final IOClient httppo = await httpp.HttpsConnect().https();
    var response =
        await httppo.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    print('viewfundingRequestIddddFromApi');
    // print(json['data']);

    if (json['status'] == true) {
      // print(json['data']['loanpurpose']);
      LoanPurpose.text = json['data']['loanpurpose'] != null
          ? json['data']['loanpurpose']
          : '';

      rerquestAmount.text = json['data']['request_amount'] != null
          ? json['data']['request_amount']
          : '';
      print(rerquestAmount.text);
      address.text = json['data']['activity_address'] != null
          ? json['data']['activity_address']
          : '';
      selectedPeriodTypeValue.value =
          (json['data']['period_type'] as List).isEmpty
              ? ''
              : json['data']['period_type'][0]['code_id'];
      selectedGarenteeTypeValue.value =
          (json['data']['grantee_type'] as List).isEmpty
              ? ''
              : json['data']['grantee_type'][0]['code_id'];
      selectedOtherGarenteeValue.value =
          (json['data']['OTHER_GARNTEE_TYPE'] as List).isEmpty
              ? ''
              : json['data']['OTHER_GARNTEE_TYPE'][0]['code_id'];
      selectedClassActivityValue.value =
          (json['data']['activity_class'] as List).isEmpty
              ? ''
              : json['data']['activity_class'][0]['code_id'];
      clientArea.value = (json['data']['activity_area'] as List).isEmpty
          ? ''
          : json['data']['activity_area'][0]['code_id'];

      if (clientArea.value.length < 4) {
        clientArea.value = '';
        clientGovernorate.value = '';
        clientDirectorate.value = '';
      } else {
        clientGovernorate.value = clientArea.substring(0, 2);

        clientDirectorate.value = clientArea.substring(0, 4);
      }

      clientProduct.value = (json['data']['product_id'] as List).isEmpty
          ? ''
          : json['data']['product_id'][0]['code_id'];
      selectedProductsPeriodValue.value =
          (json['data']['request_period'] as List).isEmpty
              ? ''
              : json['data']['request_period'][0]['code_id'];
      selectedActivityValue.value =
          (json['data']['activity_id'] as List).isEmpty
              ? ''
              : json['data']['activity_id'][0]['CODE_ID'];
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
