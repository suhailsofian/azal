import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:neecoder/app/controllers/auth_controller.dart';
import 'package:neecoder/app/controllers/landingPage_controller.dart';
import 'package:neecoder/app/controllers/languages_controller.dart';
import 'package:neecoder/app/utils/httpConfig/HttpsConnect.dart' as httpp;
import 'package:http/http.dart' as http;

import '../routes/app_routes.dart';

class RegistrationController extends GetxController {
  final boxs = GetStorage().obs;
  var selectedDate = DateTime.now().obs;
  var selectedissuanceDate = DateTime.now().obs;
  final birth_day = TextEditingController().obs;
  final issuance_date = TextEditingController().obs;
  var isCompleted = false.obs;
  RxBool checkidentityType = false.obs;
  RxBool checkClientGender = false.obs;
  RxBool checkMaritalStatus = false.obs;
  RxBool checkCleintEducation = false.obs;
  RxBool checkhow_to_know = false.obs;
  TextEditingController editUsername = TextEditingController();
  TextEditingController editMobile = TextEditingController();
  var editbirthDay = TextEditingController().obs;
  var selectedIdentityTypeValue = ''.obs;
  TextEditingController identityId = TextEditingController();
  var issuanceDate = TextEditingController().obs;
  var clientGender = ''.obs;
  var maritalStatus = ''.obs;
  //----------------------------------------------------------
  TextEditingController LoanPurpose = TextEditingController();
  TextEditingController rerquestAmount = TextEditingController();
  TextEditingController address = TextEditingController();
  var selectedPeriodTypeValue = ''.obs;
  var selectedGarenteeTypeValue = ''.obs;
  var selectedOtherGarenteeValue = ''.obs;
  var selectedClassActivityValue = ''.obs;
  //-----------------------------------------------------------
  TextEditingController sourceIncome = TextEditingController();
  TextEditingController ClientAddress = TextEditingController();
  var clientGovernorate = ''.obs;
  var clientDirectorate = ''.obs;
  var clientArea = ''.obs;
  var clientGovernorate2 = ''.obs;
  var clientDirectorate2 = ''.obs;
  var clientArea2 = ''.obs;
  var clientProduct = ''.obs;
  var selectedProductsPeriodValue = ''.obs;
  var selectedActivityValue = ''.obs;
  var selectedClassValue = ''.obs;
  TextEditingController numberFamily = TextEditingController();
  TextEditingController NumberMale = TextEditingController();
  TextEditingController numberFamale = TextEditingController();
  var cleintEducation = ''.obs;
  var how_to_know = ''.obs;
  RxList identityTypesList = [].obs;
  RxList genderList = [].obs;
  RxList statusCleintList = [].obs;
  RxList directoratesList = [].obs;
  RxList areasList = [].obs;
  RxList citiesList = [].obs;
  RxList educationlevelList = [].obs;
  RxList productsList = [].obs;
  RxList identifytheprogramList = [].obs;
  RxList periodTypeList = [].obs;
  RxList productsperiodList = [].obs;
  RxList granteetypeList = [].obs;
  RxList activityClassList = [].obs;
  RxList activityList = [].obs;
  RxList complaintsTypeList = [].obs;
  RxList mainClassList = [].obs;
  RxList classList = [].obs;

  RxBool loading = false.obs;
  RxBool loadingOne = false.obs;
  List alss = [].obs;

  RegistrationController() {
    loadIdentityTypesFromApi(null);
    loadClientGenderFromApi(null);
    loadMaritalStatusFromApi(null);

    loadClientGovernorateFromApi(null);
    loadEducationlevelFromApi(null);
    loadIdentifytheprogramFromApi(null);
    loadProductsFromApi(null);
    loadPeriodTypeFromApi(null);

    loadGranteetypeFromApi(null);
    loadActivityClassFromApi(null);

    loadComplaintsTypeFromApi(null);
    loadMainClassificationFromApi(null);
  }
  @override
  void onInit() {
    super.onInit();
  }

  void onInitLoad(lang) {
    loadIdentityTypesFromApi(lang);
    loadClientGenderFromApi(lang);
    loadMaritalStatusFromApi(lang);

    loadClientGovernorateFromApi(lang);
    loadEducationlevelFromApi(lang);
    loadIdentifytheprogramFromApi(lang);
    loadProductsFromApi(lang);
    loadPeriodTypeFromApi(lang);

    loadGranteetypeFromApi(lang);
    loadActivityClassFromApi(lang);

    loadComplaintsTypeFromApi(lang);
    loadMainClassificationFromApi(lang);
  }

  @override
  void dispose() {
    super.dispose();
  }

  removeCacheData(lang) {
    print("cache data deleting... " + lang);
    // if (lang == null) {
    //   lang = Get.find<LanguageController>().savedLang.value;
    // }
    boxs.value.remove("complaintsTypeList" + lang);
    boxs.value.remove("mainClassList" + lang);
    boxs.value.remove("activityClassList" + lang);
    boxs.value.remove("granteetypeList" + lang);
    boxs.value.remove("periodTypeList" + lang);
    boxs.value.remove("productsList" + lang);
    boxs.value.remove("educationlevelList" + lang);
    boxs.value.remove("identifytheprogramList" + lang);
    boxs.value.remove("directoratesList" + lang);
    boxs.value.remove("statusCleintList" + lang);
    boxs.value.remove("genderList" + lang);
    boxs.value.remove("identityTypesList" + lang);
    print("cache deleted all " + lang);
  }

  loadComplaintsTypeFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");

    var currentToken = Get.find<AuthController>().showToken();
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    print(lang);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };

    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "complaintstype"
    };
    print('complaintsTypeList read');
    print(boxs.value.read("complaintsTypeList" + lang));
    List<dynamic> storedJsoncomplaintsTypeListList =
        boxs.value.read<List<dynamic>>("complaintsTypeList" + lang) ?? [];
    print("vstoredJsonList");
    print(storedJsoncomplaintsTypeListList);
    if (storedJsoncomplaintsTypeListList.isEmpty) {
      print('api complaintsTypeList' + lang);
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      if (json['status'] == true) {
        complaintsTypeList.value = json['data'];
        boxs.value.write("complaintsTypeList" + lang, json['data']);
      }
    } else {
      print('cache complaintsTypeList' + lang);
      print(boxs.value.read("complaintsTypeList" + lang));
      complaintsTypeList.value = boxs.value.read("complaintsTypeList" + lang);
    }
  }

  loadClassFromApi(lang, String codeId) async {
    print(codeId);
    var url = Uri.parse("https://apply.azal-ye.com/api/list");
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "class",
      "v_p_code_id": codeId
    };
    print(body);
    //print(headers);
    print(boxs.value.read("classList" + codeId + lang));
    List<dynamic> storedJsonclassListListList =
        boxs.value.read<List<dynamic>>("classList" + codeId + lang) ?? [];
    print(storedJsonclassListListList);

    if (storedJsonclassListListList.isEmpty) {
      print('api classList' + codeId + lang);
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response222 =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      print("affter response");
      print(response222.body);
      final jsonsss = jsonDecode(response222.body);
      if (jsonsss['status'] == true) {
        print("loadClassFromApi");
        print(jsonsss);
        classList.value = jsonsss['data'];
        print("affter");
        print(classList);
        boxs.value.write("classList" + codeId + lang, jsonsss['data']);
      }
    } else {
      print('cache classList' + codeId + lang);
      print(boxs.value.read("classList" + codeId + lang));
      classList.value = boxs.value.read("classList" + codeId + lang);
    }
  }

  loadMainClassificationFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");

    var currentToken = Get.find<AuthController>().showToken();
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    print(lang);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    Map body = {"lang_id": lang.toString().toLowerCase(), "key": "mainclass"};
    List<dynamic> storedJsonmainClassListList =
        boxs.value.read<List<dynamic>>("mainClassList" + lang) ?? [];
    if (storedJsonmainClassListList.isEmpty) {
      print('api mainClassList' + lang);
      // final IOClient httppo = await httpp.HttpsConnect().https();
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadMainClassificationFromApi");
      if (json['status'] == true) {
        print(json);
        mainClassList.value = json['data'];
        boxs.value.write("mainClassList" + lang, json['data']);
      }
    } else {
      print('cache mainClassList' + lang);
      print(boxs.value.read("mainClassList" + lang));
      mainClassList.value = boxs.value.read("mainClassList" + lang);
    }
  }

  loadActivityFromApi(lang, codeId) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    Map body2 = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "activities",
      "v_p_code_id": codeId
    };
    print(body2);
    print(headers);
    List<dynamic> storedJsonactivityList = boxs.value
            .read<List<dynamic>>("activityList" + codeId.toString() + lang) ??
        [];
    print("vstoredJsonactivityListList");
    print(storedJsonactivityList);
    if (storedJsonactivityList.isEmpty) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body2), headers: headers);

      print("loadActivityFromApi");
      // print(response.body);
      final json = jsonDecode(response.body);
      if (json['status'] == true) {
        print(json);
        activityList.value = json['data'];
        boxs.value
            .write("activityList" + codeId.toString() + lang, json['data']);
      }
    } else {
      print('cache activityList' + codeId.toString() + lang);
      print(boxs.value.read("activityList" + codeId.toString() + lang));
      activityList.value =
          boxs.value.read("activityList" + codeId.toString() + lang);
    }
  }

  loadActivityClassFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");

    var currentToken = Get.find<AuthController>().showToken();
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    print(lang);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "activityclass"
    };
    List<dynamic> storedJsonactivityClassListList =
        boxs.value.read<List<dynamic>>("activityClassList" + lang) ?? [];
    if (storedJsonactivityClassListList.isEmpty) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadActivityClassFromApi");
      print(json);
      if (json['status'] == true) {
        activityClassList.value = json['data'];
        boxs.value.write("activityClassList" + lang, json['data']);
      }
    } else {
      print('cache activityClassList' + lang);
      print(boxs.value.read("activityClassList" + lang));
      activityClassList.value = boxs.value.read("activityClassList" + lang);
    }
  }

  loadGranteetypeFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");

    var currentToken = Get.find<AuthController>().showToken();
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    print(lang);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    Map body = {"lang_id": lang.toString().toLowerCase(), "key": "granteetype"};
    List<dynamic> storedJsongranteetypeListListList =
        boxs.value.read<List<dynamic>>("granteetypeList" + lang) ?? [];
    if (storedJsongranteetypeListListList.isEmpty) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadGranteetypeFromApi");
      print(json);
      if (json['status'] == true) {
        granteetypeList.value = json['data'];
        boxs.value.write("granteetypeList" + lang, json['data']);
      }
    } else {
      print('cache granteetypeList' + lang);
      print(boxs.value.read("granteetypeList" + lang));
      granteetypeList.value = boxs.value.read("granteetypeList" + lang);
    }
  }

  loadProductsPeriodFromApi(lang, codeId) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "productsperiod",
      "v_p_code_id": codeId
    };
    print(body);
    print(headers);
    List<dynamic> storedJsonproductsperiodListListList = boxs.value
            .read<List<dynamic>>(
                "productsperiodList" + codeId.toString() + lang) ??
        [];
    if (storedJsonproductsperiodListListList.isEmpty) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      if (json['status'] == true) {
        print("loadProductsPeriodFromApi");
        print(json);
        productsperiodList.value = json['data'];
        boxs.value.write(
            "productsperiodList" + codeId.toString() + lang, json['data']);
      }
    } else {
      print('cache productsperiodList' + codeId.toString() + lang);
      print(boxs.value.read("productsperiodList" + codeId.toString() + lang));
      productsperiodList.value =
          boxs.value.read("productsperiodList" + codeId.toString() + lang);
    }
  }

  loadPeriodTypeFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");

    var currentToken = Get.find<AuthController>().showToken();
    // final controller = Get.put(LanguageController());
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    print(lang);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    Map body = {"lang_id": lang.toString().toLowerCase(), "key": "periodtype"};
    List<dynamic> storedJsonperiodTypeListListList =
        boxs.value.read<List<dynamic>>("periodTypeList" + lang) ?? [];
    if (storedJsonperiodTypeListListList.isEmpty) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadPeriodTypeFromApi");
      print(json);
      if (json['status'] == true) {
        periodTypeList.value = json['data'];
        boxs.value.write("periodTypeList" + lang, json['data']);
      }
    } else {
      print('cache periodTypeList' + lang);
      print(boxs.value.read("periodTypeList" + lang));
      periodTypeList.value = boxs.value.read("periodTypeList" + lang);
    }
  }

  loadProductsFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");

    var currentToken = Get.find<AuthController>().showToken();
    // final controller = Get.put(LanguageController());
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }

    print(lang);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "products",
      "v_p_code_id": "1"
    };
    List<dynamic> storedJsonproductsListListList =
        boxs.value.read<List<dynamic>>("productsList" + lang) ?? [];
    if (storedJsonproductsListListList.isEmpty) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadProductsFromApi");
      print(json);
      if (json['status'] == true) {
        productsList.value = json['data'];
        boxs.value.write("productsList" + lang, json['data']);
      }
    } else {
      print('cache productsList' + lang);
      print(boxs.value.read("productsList" + lang));
      productsList.value = boxs.value.read("productsList" + lang);
    }
  }

  loadEducationlevelFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");
    var currentToken = Get.find<AuthController>().showToken();
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "educationlevel",
      "v_p_code_id": "1"
    };
    if (boxs.value.read("educationlevelList" + lang) == null) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadEducationlevelFromApi");
      print(json);
      if (json['status'] == true) {
        educationlevelList.value = json['data'];
        boxs.value.write("educationlevelList" + lang, json['data']);
      }
    } else {
      print('cache educationlevelList' + lang);
      print(boxs.value.read("educationlevelList" + lang));
      educationlevelList.value = boxs.value.read("educationlevelList" + lang);
    }
  }

  loadIdentifytheprogramFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }

    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "identifytheprogram",
      "v_p_code_id": "1"
    };
    if (boxs.value.read("identifytheprogramList" + lang) == null) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadEducationlevelFromApi");
      print(json);
      if (json['status'] == true) {
        identifytheprogramList.value = json['data'];
        boxs.value.write("identifytheprogramList" + lang, json['data']);
      }
    } else {
      print('cache identifytheprogramList' + lang);
      print(boxs.value.read("identifytheprogramList" + lang));
      identifytheprogramList.value =
          boxs.value.read("identifytheprogramList" + lang);
    }
  }

  loadClientAreaFromApi(lang, codeId) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "areas",
      "v_p_code_id": codeId
    };
    List<dynamic> storedJsonareasListListList = boxs.value
            .read<List<dynamic>>("areasList" + codeId.toString() + lang) ??
        [];
    if (storedJsonareasListListList.isEmpty) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadClientAreaFromApi");
      print(json);
      if (json['status'] == true) {
        areasList.value = json['data'];
        boxs.value.write("areasList" + codeId.toString() + lang, json['data']);
      }
    } else {
      print('cache areasList' + codeId.toString() + lang);
      print(boxs.value.read("areasList" + codeId.toString() + lang));
      areasList.value = boxs.value.read("areasList" + codeId.toString() + lang);
    }
  }

  loadClientDirectorateFromApi(lang, codeId) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "cities",
      "v_p_code_id": codeId
    };
    print(body);
    print(headers);
    List<dynamic> storedJsoncitiesListListList = boxs.value
            .read<List<dynamic>>("citiesList" + codeId.toString() + lang) ??
        [];
    print(storedJsoncitiesListListList);
    if (storedJsoncitiesListListList.isEmpty) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print(json);
      if (json['status'] == true) {
        print("cities");

        citiesList.value = json['data'];
        boxs.value.write("citiesList" + codeId.toString() + lang, json['data']);
      }
    } else {
      print('cache citiesList' + codeId.toString() + lang);
      print(boxs.value.read("citiesList" + codeId.toString() + lang));
      citiesList.value =
          boxs.value.read("citiesList" + codeId.toString() + lang);
    }
  }

  loadClientGovernorateFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "directorates",
    };
    if (boxs.value.read("directoratesList" + lang) == null) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      if (json['status'] == true) {
        print("loadClientGovernorateFromApi");
        print(json);
        directoratesList.value = json['data'];
        clientGovernorate2.value = json['data'][0]['code_id'];
        boxs.value.write("directoratesList" + lang, json['data']);
      }
    } else {
      print('cache directoratesList' + lang);
      print(boxs.value.read("directoratesList" + lang));
      directoratesList.value = boxs.value.read("directoratesList" + lang);
    }
  }

  loadMaritalStatusFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "statuscleint",
      "v_p_code_id": "1"
    };
    print(body);
    print(headers);
    if (boxs.value.read("statusCleintList" + lang) == null) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadMaritalStatusFromApi");
      if (json['status'] == true) {
        print(json);
        statusCleintList.value = json['data'];
        boxs.value.write("statusCleintList" + lang, json['data']);
      }
    } else {
      print('cache statusCleintList' + lang);
      print(boxs.value.read("statusCleintList" + lang));
      statusCleintList.value = boxs.value.read("statusCleintList" + lang);
    }
  }

  loadClientGenderFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/list");
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "key": "Gender",
      "v_p_code_id": "1"
    };
    if (boxs.value.read("genderList" + lang) == null) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadClientGenderFromApi");
      if (json['status'] == true) {
        // print(json);
        genderList.value = json['data'];
        boxs.value.write("genderList" + lang, json['data']);
      }
    } else {
      print('cache genderList' + lang);
      print(boxs.value.read("genderList" + lang));
      genderList.value = boxs.value.read("genderList" + lang);
    }
  }

  loadIdentityTypesFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/identify-type");
    var headers = {'Content-Type': 'application/json'};
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
      "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs"
    };
    List<dynamic> storedJsonidentityTypesListListList =
        boxs.value.read<List<dynamic>>("identityTypesList" + lang) ?? [];
    if (storedJsonidentityTypesListListList.isEmpty) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      if (json['status'] == true) {
        // print(json['data']);
        identityTypesList.value = json['data'];
        boxs.value.write("identityTypesList" + lang, json['data']);
      }
    } else {
      print('cache identityTypesList' + lang);
      print(boxs.value.read("identityTypesList" + lang));
      identityTypesList.value = boxs.value.read("identityTypesList" + lang);
    }
  }

  checkCompleteDataFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/check-complete-data");
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
    };
    final IOClient httppo = await httpp.HttpsConnect().https();
    var response =
        await httppo.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    // print(json);
    // print(json['status']);
    if (json['status'] == true) {
      isCompleted(true);
    }
    print(isCompleted);
  }

  viewUserProfileFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/view-user-profile");
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    if (lang == null) {
      lang = Get.find<LanguageController>().savedLang.value;
    }
    Map body = {
      "lang_id": lang.toString().toLowerCase(),
    };
    final IOClient httppo = await httpp.HttpsConnect().https();
    var response =
        await httppo.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    print("viewUserProfileFromApi");
    print(json['data']);

    if (json['status'] == true) {
      print(json['data']['user'][0]['name']);
      editUsername.text = json['data']['user'][0]['name'];
      editMobile.text = json['data']['user'][0]['phone'];
      editbirthDay.value.text = json['data']['user'][0]['cleintbirthday'];
      selectedIdentityTypeValue.value = json['data']['user'][0]['identifytype'];

      identityId.text = json['data']['user'][0]['identifynum'];
      issuanceDate.value.text = json['data']['user'][0]['identifydate'];
      clientGender.value = json['data']['user'][0]['cleintgender'];

      maritalStatus.value = json['data']['user'][0]['cleintstatus'];

      sourceIncome.text = json['data']['user'][0]['sourceofincome'];
      ClientAddress.text = json['data']['user'][0]['clientaddress'];
      clientGovernorate.value = json['data']['user'][0]['clientgovernorate'];
      clientDirectorate.value = json['data']['user'][0]['clientdirectorate'];
      clientArea.value = json['data']['user'][0]['clientarea'];
      numberFamily.text = json['data']['user'][0]['familycount'];
      NumberMale.text = json['data']['user'][0]['mailcount'];
      numberFamale.text = json['data']['user'][0]['femailcount'];
      cleintEducation.value = json['data']['user'][0]['cleinteducation'];
      how_to_know.value = json['data']['user'][0]['identifytheprogram'];
    }
  }

  Future<void> editRegister(
      editUsername,
      editMobile,
      editbirthDay,
      selectedIdentityTypeValue,
      identityId,
      issuanceDate,
      clientGender,
      maritalStatus,
      sourceIncome,
      ClientAddress,
      clientGovernorate,
      clientDirectorate,
      clientArea,
      numberFamily,
      NumberMale,
      numberFamale,
      cleintEducation,
      how_to_know) async {
    var currentToken = Get.find<AuthController>().showToken();
    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    try {
      var url2 = Uri.parse('https://apply.azal-ye.com/api/edit-user-profile');
      print(url2);
      Map body2 = {
        "lang_id": Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase(),
        "name": editUsername,
        "identifydate": issuanceDate,
        "clientaddress": ClientAddress,
        "clientgovernorate": clientGovernorate,
        "clientdirectorate": clientDirectorate,
        "clientarea": clientArea,
        "familycount": numberFamily,
        "mailcount": NumberMale,
        "femailcount": numberFamale,
        "cleintbirthday": editbirthDay,
        "cleintstatus": maritalStatus,
        "sourceofincome": sourceIncome,
        "cleinteducation": cleintEducation,
        "cleintgender": clientGender,
        "identifytheprogram": how_to_know,
      };

      print(body2);
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response2 =
          await httppo.post(url2, headers: headers2, body: jsonEncode(body2));

      print(response2.statusCode);

      print(response2.body);

      if (response2.statusCode == 200) {
        final json = jsonDecode(response2.body);
        if (json["status"] == true) {
          Get.find<LandingPageController>()
              .dialogCheckMS(AppRoutes.landing, false, message: json["data"]);
        } else {
          throw json["message"] ?? "Unknown Error Occured";
        }
      } else {
        throw jsonDecode(response2.body)["errors"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.find<LandingPageController>().dialogMS(error.toString());
    }
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(1900),
        lastDate: DateTime(2030),
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
        fieldHintText: 'Year-Month-Day',
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                // override MaterialApp ThemeData
                colorScheme: ColorScheme.light(
                  primary: Color.fromARGB(255, 146, 173,
                      118), //header and selced day background color
                  onPrimary: Colors.white, // titles and
                  onSurface: Colors.black, // Month days , years
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: Colors.black, // ok , cancel    buttons
                  ),
                ),
              ),
              child: child!); // pass child to this child
        });
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      print('daaate');
      print(DateFormat("yyyy-MM-dd").format(pickedDate).toString());
      Get.find<AuthController>().editbirthDay.value.text =
          DateFormat("yyyy-MM-dd").format(pickedDate).toString();
    }
  }

  chooseIssuanceDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedissuanceDate.value,
        firstDate: DateTime(1900),
        lastDate: DateTime(2030),
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
        //     fieldLabelText: 'DOB',
        fieldHintText: 'Year-Month-Day',
        builder: (context, child) {
//  here you can return  a child
          return Theme(
              data: Theme.of(context).copyWith(
                // override MaterialApp ThemeData
                colorScheme: ColorScheme.light(
                  primary: Color.fromARGB(255, 146, 173,
                      118), //header and selced day background color
                  onPrimary: Colors.white, // titles and
                  onSurface: Colors.black, // Month days , years
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: Colors.black, // ok , cancel    buttons
                  ),
                ),
              ),
              child: child!); // pass child to this child
        });
    if (pickedDate != null && pickedDate != selectedissuanceDate.value) {
      selectedissuanceDate.value = pickedDate;
      Get.find<AuthController>().issuanceDate.value.text =
          DateFormat("yyyy-MM-dd").format(pickedDate).toString();
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 5))))) {
      return true;
    }
    return false;
  }
}
