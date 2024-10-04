import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:neecoder/app/controllers/landingPage_controller.dart';
import 'package:neecoder/app/controllers/languages_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:neecoder/app/utils/httpConfig/HttpsConnect.dart' as httpp;
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final box = GetStorage().obs;
  var authenicated = false.obs;
  var backToauthenicated = false.obs;
  var name = ''.obs;
  var checkBool = false.obs;
  var token = ''.obs;
  TextEditingController phone = TextEditingController();
  RxList identityTypesLists = [].obs;
  var obscured = true.obs;
  var obscureds1 = true.obs;
  var obscureds2 = true.obs;
  var selectedDate = DateTime.now().obs;
  var selectedissuanceDate = DateTime.now().obs;
  final birth_day = TextEditingController().obs;
  final issuance_date = TextEditingController().obs;
  var isCompleted = false.obs;
  TextEditingController editUsername = TextEditingController();
  TextEditingController editMobile = TextEditingController();
  var editbirthDay = TextEditingController().obs;
  var selectedIdentityTypeValue = ''.obs;
  TextEditingController identityId = TextEditingController();
  var issuanceDate = TextEditingController().obs;
  var clientGender = ''.obs;
  var maritalStatus = ''.obs;
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
  RxList genderList = [].obs;
  RxList statusCleintList = [].obs;
  RxList directoratesList = [].obs;
  RxList areasList = [].obs;
  RxList citiesList = [].obs;
  RxList educationlevelList = [].obs;
  RxList productsList = [].obs;
  RxList identifytheprogramList = [].obs;
  RxList periodTypeList = [].obs;
  AuthController() {
    authenicated(box.value.read("authenicated"));
    loadIdentityTypesFromApi();
  }

  logoutFromApi() async {
    var currentToken = Get.find<AuthController>().showToken();
    var url = Uri.parse("https://apply.azal-ye.com/api/logout");
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken'
    };
    Map body = {
      "lang_id": Get.find<LanguageController>()
          .savedLang
          .value
          .toString()
          .toLowerCase()
    };
    final IOClient httppo = await httpp.HttpsConnect().https();
    await httppo.post(url, body: jsonEncode(body), headers: headers);
    box.value.write("auth", null);
    box.value.write("username", null);
    authenicated(false);
    box.value.write("token", null);
    box.value.write("code", null);
    box.value.write("authenicated", false);
    Get.toNamed(AppRoutes.splash);
  }

  onlylogoutFromApi() async {
    var currentToken = Get.find<AuthController>().showToken();
    var url = Uri.parse("https://apply.azal-ye.com/api/logout");
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken'
    };
    Map body = {
      "lang_id": Get.find<LanguageController>()
          .savedLang
          .value
          .toString()
          .toLowerCase()
    };
    final IOClient httppo = await httpp.HttpsConnect().https();
    await httppo.post(url, body: jsonEncode(body), headers: headers);
    box.value.write("auth", null);
    box.value.write("username", null);
    authenicated(false);
    box.value.write("token", null);
    box.value.write("code", null);
    box.value.write("authenicated", false);
  }

  loadIdentityTypesFromApi() async {
    var url = Uri.parse("https://apply.azal-ye.com/api/identify-type");
    var headers = {'Content-Type': 'application/json'};
    var lang =
        Get.put(LanguageController()).savedLang.value.toString().toLowerCase();
    Map body = {
      "lang_id": lang,
      "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs"
    };
    List<dynamic> storedJsonidentityTypesListsListList =
        box.value.read<List<dynamic>>("identityTypesLists" + lang) ?? [];
    if (storedJsonidentityTypesListsListList.isEmpty) {
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print('loadIdentityTypesOutFromApi');
      print(json['data']);
      identityTypesLists.value = json['data'];
      box.value.write("identityTypesLists" + lang, json['data']);
    } else {
      print('cache identityTypesLists' + lang);
      print(box.value.read("identityTypesLists" + lang));
      identityTypesLists.value = box.value.read("identityTypesLists" + lang);
    }
  }

  Future<void> changePassword(password, confirmPassword) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      var url = Uri.parse('https://apply.azal-ye.com/api/update-password');
      Map body = {
        "phone": box.value.read("phone"),
        "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
        "code": box.value.read("code"),
        "password": password,
        "password_confirmation": confirmPassword,
        "lang_id": Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase()
      };

      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["status"] == true) {
          onlylogoutFromApi();
          Get.find<LandingPageController>()
              .dialogCheckMS(AppRoutes.splash, false, message: json["data"]);
        } else {
          throw json["message"] ?? "Unknown Error Occured";
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.find<LandingPageController>().dialogMS(error.toString());
    }
  }

  Future<void> verfiyPhoneNumber(code) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      var url =
          Uri.parse('https://apply.azal-ye.com/api/check-code-set-password');
      //print(url);
      Map body = {
        'lang_id': Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase(),
        'code': code.toString(),
        "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
        "phone": box.value.read("phone"),
      };
      print(body);
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["status"] == true) {
          backToauthenicated(false);
          Get.find<LandingPageController>()
              .dialogCheckMS(AppRoutes.splash, false, message: json["message"]);
          // Get.toNamed(AppRoutes.login);
        } else {
          throw json["message"] ?? "Unknown Error Occured";
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.find<LandingPageController>().dialogMS(error.toString());
    }
  }

  Future<void> verfiyPhoneNumber2(code, phones) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $tokens',
    };

    try {
      var url =
          Uri.parse('https://apply.azal-ye.com/api/check-code-set-password');

      Map body = {
        'lang_id': Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase(),
        'code': code.toString(),
        "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
        "phone": phones,
      };
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);

      print(response.body);
      // print(response.body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json["status"] == true) {
          final json = jsonDecode(response.body);
          box.value.write("code", code);
          box.value.write("phone", phones);
          backToauthenicated(false);
          Get.toNamed(AppRoutes.changePasswordPage);
        } else {
          throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      // Get.back();
      Get.find<LandingPageController>().dialogMS(error.toString());
    }
  }

  Future<void> generateCode(generatePhone) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      var myPhone = '';
      if (generatePhone == null) {
        myPhone = box.value.read("phone");
      } else {
        box.value.write("phone", generatePhone);
        myPhone = generatePhone;
      }
      phone.text = myPhone.toString();
      var url =
          Uri.parse('https://apply.azal-ye.com/api/send-code-set-password');
      //print(url);
      Map body = {
        "phone": myPhone,
        "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs"
      };
      print(body);
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      print(response.body);
      //print(response.statusCode);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["status"] == true) {
          if (generatePhone != null) {
            backToauthenicated(true);
          }

          Get.find<LandingPageController>().dialogCheckMS(
              AppRoutes.splash, true,
              message: json["message"].toString());
        } else {
          throw json["message"] ?? "Unknown Error Occured";
        }
      }
    } catch (error) {
      // Get.back();
      Get.find<LandingPageController>().dialogMS(error.toString());
    }
  }

  Future<void> generateCode2ForgetPass(generatePhone) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      var myPhone = '';
      if (generatePhone == null) {
        myPhone = box.value.read("phone");
      } else {
        box.value.write("phone", generatePhone);
        myPhone = generatePhone;
      }
      phone.text = myPhone.toString();
      var url =
          Uri.parse('https://apply.azal-ye.com/api/send-code-set-password');

      Map body = {
        "phone": myPhone,
        "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs"
      };

      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["status"] == true) {
          Get.find<LandingPageController>().dialogCheckMS(
              AppRoutes.verifiedPage, false,
              message: json["message"].toString());
        } else {
          throw json["message"] ?? "Unknown Error Occured";
        }
      }
    } catch (error) {
      // Get.back();
      Get.find<LandingPageController>().dialogMS(error.toString());
    }
  }

  Future<void> generateCodeWithToken(generatePhone) async {
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };

    try {
      var url = Uri.parse('https://apply.azal-ye.com/api/send-other-code');

      Map body = {
        "lang_id": Get.put(LanguageController())
            .savedLang
            .value
            .toString()
            .toLowerCase()
      };

      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      print(response.body);
      //print(response.statusCode);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        if (json["status"] == true) {
          backToauthenicated(true);
          // Get.toNamed(AppRoutes.verifiedPage);
          throw json["message"] ?? "Unknown Error Occured";
        } else {
          throw json["message"] ?? "Unknown Error Occured";
        }
      }
    } catch (error) {
      Get.find<LandingPageController>().dialogCheckMS(
          AppRoutes.verifiedPage, true,
          message: error.toString());
    }
  }

  Future<void> loginWithEmail(username, password, rememberMe) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      var device = await deviceInfo();
      print(device['devicetype']);
      print(device['osversion']);
      var urls = Uri.parse('https://apply.azal-ye.com/api/loginuser');
      Map bodys = {
        'phone': username,
        'lang_id': Get.put(LanguageController())
            .savedLang
            .value
            .toString()
            .toLowerCase(),
        'password': password,
        "devicetype": device['devicetype'], //ios or andriod
        "deviceid": device['deviceid'],
        "osversion": device['osversion'],
        "appVersion": device['appVersion'],
        "devicetimestamp": device['devicetimestamp'],
        "devicelang": device['devicelang']
      };
      // final IOClient httppo = await httpp.HttpsConnect().https();
      http.Response response = await http.post(
        urls,
        headers: headers,
        body: jsonEncode(bodys),
      );

      print(response.body);
      //print(response.statusCode);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["success"] == true) {
          //print(json);
          var token = json['token']['token'];
          var name = json['user']['name'];
          //print(token);
          print(username);

          box.value.write("token", token);
          var verf = await phoneVerfiy(username, token);
          if (verf['status'] == false) {
            try {
              throw "username_or_password_not_correct".tr;
            } catch (e) {
              Get.find<LandingPageController>().dialogMS(
                  verf['message'].toString(),
                  key: AppRoutes.verifiedPageAfterSignUp);
            }
          } else {
            if (rememberMe == true) {
              authenicated(true);
              box.value.write("authenicated", true);
              box.value.write("rememberMyPhone", username);
              box.value.write("phone", username);
              phone.text = username.toString();
            } else {
              authenicated(false);
              box.value.write("authenicated", false);
              box.value.write("phone", username);
              phone.text = '';
            }

            box.value.write("username", name);
            box.value.write("auth", json['user']['id']);
            var user = {
              "id": json['user']['id'],
              "username": json['user']['name'],
              "phone": json['user']['phone'],
              "identifytype": json['user']['identifytype'],
              "identifynum": json['user']['identifynum'],
              "identifydate": json['user']['identifydate'],
            };
            box.value.write("user", user);

            Get.toNamed(AppRoutes.landing);
          }
        } else {
          throw json['message'];
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.find<LandingPageController>().dialogMS(error.toString());
    }
  }

  viewUserProfileFromApi(lang) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/view-user-profile");
    var currentToken = box.value.read("token");
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
    // final IOClient httppo = await httpp.HttpsConnect().https();
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    print("viewUserProfileFromApi");
    print(json['data']);

    if (json['status'] == true) {
      print(json['data']['user'][0]['name']);
      editUsername.text = json['data']['user'][0]['name'] != null
          ? json['data']['user'][0]['name']
          : '';
      editMobile.text = json['data']['user'][0]['phone'] != null
          ? json['data']['user'][0]['phone']
          : '';
      editbirthDay.value.text =
          json['data']['user'][0]['cleintbirthday'] != null
              ? json['data']['user'][0]['cleintbirthday']
              : '';
      selectedIdentityTypeValue.value =
          json['data']['user'][0]['identifytype'] != null
              ? json['data']['user'][0]['identifytype']
              : '';
      identityId.text = json['data']['user'][0]['identifynum'] != null
          ? json['data']['user'][0]['identifynum']
          : '';
      issuanceDate.value.text = json['data']['user'][0]['identifydate'] != null
          ? json['data']['user'][0]['identifydate']
          : '';
      clientGender.value = json['data']['user'][0]['cleintgender'] != null
          ? json['data']['user'][0]['cleintgender']
          : '';
      maritalStatus.value = json['data']['user'][0]['cleintstatus'] != null
          ? json['data']['user'][0]['cleintstatus']
          : '';
      sourceIncome.text = json['data']['user'][0]['sourceofincome'] != null
          ? json['data']['user'][0]['sourceofincome']
          : '';
      ClientAddress.text = json['data']['user'][0]['clientaddress'] != null
          ? json['data']['user'][0]['clientaddress']
          : '';
      clientGovernorate.value =
          json['data']['user'][0]['clientgovernorate'] != null
              ? json['data']['user'][0]['clientgovernorate']
              : '';
      clientDirectorate.value =
          json['data']['user'][0]['clientdirectorate'] != null
              ? json['data']['user'][0]['clientdirectorate']
              : '';
      clientArea.value = json['data']['user'][0]['clientarea'] != null
          ? json['data']['user'][0]['clientarea']
          : '';
      numberFamily.text = json['data']['user'][0]['familycount'] != null
          ? json['data']['user'][0]['familycount']
          : '';
      NumberMale.text = json['data']['user'][0]['mailcount'] != null
          ? json['data']['user'][0]['mailcount']
          : '';
      numberFamale.text = json['data']['user'][0]['femailcount'] != null
          ? json['data']['user'][0]['femailcount']
          : '';
      cleintEducation.value = json['data']['user'][0]['cleinteducation'] != null
          ? json['data']['user'][0]['cleinteducation']
          : '';
      how_to_know.value = json['data']['user'][0]['identifytheprogram'] != null
          ? json['data']['user'][0]['identifytheprogram']
          : '';

      phone.text = showPhone();
    }
  }

  phoneVerfiy(phone, token) async {
    //------------------------------------------------------------
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    print(headers);
    var urlsVerf =
        Uri.parse('https://apply.azal-ye.com/api/check-phone-verify');
    Map bodysVerf = {
      'lang_id':
          Get.put(LanguageController()).savedLang.value.toString().toLowerCase()
    };
    // final IOClient httppo = await httpp.HttpsConnect().https();
    http.Response response = await http.post(
      urlsVerf,
      headers: headers,
      body: jsonEncode(bodysVerf),
    );
    print('phoneVerfiy');
    print(response.body);
    //-----------------------------------------------------------
    bool verfiy = false;
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json["status"] == true) {
        verfiy = true;
        return {"status": verfiy, "message": json["message"]};
      } else {
        box.value.write("phone", phone);
        return {"status": verfiy, "message": json["message"]};
      }
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }

  showVersion() {
    // name.value = box.value.read("username");
    return box.value.read("version");
  }

  showName() {
    // name.value = box.value.read("username");
    return box.value.read("username");
  }

  showToken() {
    // name.value = box.value.read("username");
    return box.value.read("token");
  }

  showPhone() {
    // name.value = box.value.read("username");
    return box.value.read("phone");
  }

  Future<void> register(username, password, confirmPassword, mobile, identityId,
      identityType) async {
    var device = await deviceInfo();

    var headers2 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      var url2 = Uri.parse('https://apply.azal-ye.com/api/registeruser');
      //print(url2);
      Map body2 = {
        "lang_id": Get.put(LanguageController())
            .savedLang
            .value
            .toString()
            .toLowerCase(),
        "Client_secret": "1xgv3HFT6s59BZ9P83iqdTCNHAm0uZ2j25jMCsIs",
        "name": username,
        "phone": mobile,
        "password": password,
        "password_confirmation": confirmPassword,
        "identifytype": identityType,
        "identifynum": identityId,
        "devicetype": device['devicetype'], //ios or andriod
        "deviceid": device['deviceid'],
        "osversion": device['osversion'],
        "appVersion": device['appVersion'],
        "devicetimestamp": device['devicetimestamp'],
        "devicelang": device['devicelang']
      };
//  final IOClient ioClient = https();
      print(body2);
      final IOClient httpps = await httpp.HttpsConnect().https();
      var response2 =
          await httpps.post(url2, headers: headers2, body: jsonEncode(body2));

      if (response2.statusCode == 200) {
        final json = jsonDecode(response2.body);
        if (json["status"] == true) {
          box.value.write("phone", mobile);
          Get.toNamed(AppRoutes.verifiedPageAfterSignUp);
        } else {
          throw json["message"] ?? "Unknown Error Occured";
        }
      } else {
        throw jsonDecode(response2.body)["errors"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      // Get.back();
      Get.find<LandingPageController>().dialogMS(error.toString());
    }
  }

  deviceInfo() async {
    Map<String, String> deviceInfoMap = {};

    String? deviceid = '';
    String? osversion = '';
    String? appVersion = '';
    String? devicelang = '';
    String? devicetimestamp = '';
    String? devicetype = '';
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceid = iosDeviceInfo.identifierForVendor; // unique ID on iOS
      osversion = iosDeviceInfo.systemVersion;
      devicetype = "ios";
    } else if (Platform.isAndroid) {
      // var androidDeviceInfo = await deviceInfo.androidInfo;
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceid = androidInfo.id; // unique ID on Android
      osversion = androidInfo.version.release;
      devicetype = "android";
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appVersion = packageInfo.version;
    box.value.write("version", appVersion);
    devicelang = Platform.localeName.split('_')[0].toString().toUpperCase();
    devicetimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    // Add elements to the Map
    deviceInfoMap['deviceid'] = deviceid!;
    deviceInfoMap['osversion'] = osversion;
    deviceInfoMap['appVersion'] = appVersion;
    deviceInfoMap['devicelang'] = devicelang;
    deviceInfoMap['devicetimestamp'] = devicetimestamp;
    deviceInfoMap['devicetype'] = devicetype;
    return deviceInfoMap;
  }

  Future<String> getReleaseVersion() async {
    final contents = await rootBundle.loadString('pubspec.yaml');
    final lines = contents.split('\n');

    for (var line in lines) {
      if (line.startsWith('version:')) {
        final version = line.split(':')[1].trim();
        return version;
      }
    }
    return 'Error: Version not found';
  }

  logout() {
    box.value.write("auth", null);
    box.value.write("username", null);
    authenicated(false);
    box.value.write("token", null);
    // box.value.write("phone", null);
    box.value.write("code", null);
    logoutFromApi();
  }
}
