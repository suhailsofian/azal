import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:neecoder/app/controllers/auth_controller.dart';
import 'package:neecoder/app/controllers/languages_controller.dart';
import 'package:neecoder/app/utils/httpConfig/HttpsConnect.dart' as httpp;

import '../routes/app_routes.dart';

class LandingPageController extends GetxController {
  var tabIndex = 0.obs;
  var activePage = 0.obs;
  RxBool loadings = false.obs;
  var allapplication = 0.obs;
  var suspendedapplication = 0.obs;
  var approvalappliaction = 0.obs;
  var totalBalance = 0.obs;
  List loans = [].obs;
  var pageOneKey = UniqueKey().obs;
  var isCompleted = true.obs;
  var rebuild = false.obs;
  void changeTabIndex(int index) {
    tabIndex.value = index;
    print('tabIndexx');
    print(tabIndex);
    if (index == 0) {
      Get.find<LandingPageController>().loadMainDataFromApi();
    }
    if (index == 2) {
      pageOneKey.value = UniqueKey(); // Change the key to rebuild PageOne
    }
    if (index == 2) {
      isTokenExpired();
    }
    if (index == 3) {
      isTokenExpired();
    }
    if (index == 4) {
      isTokenExpired();
    }
  }

  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void changePageIndex(int index) {
    activePage.value = index;
  }

  // Method to handle back button
  Future<bool> onWillPop() async {
    if (tabIndex.value == 0) {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    }
    if (tabIndex.value == 2 || tabIndex.value == 4) {
      changeTabIndex(0);
      return false;
    }
    final currentNavigatorState = navigatorKeys[tabIndex.value].currentState;
    if (currentNavigatorState!.canPop()) {
      // Pop the current tab's navigator if there's anything to pop
      currentNavigatorState.pop();
      return false; // Don't exit the app
    } else if (tabIndex.value != 0) {
      changeTabIndex(0);
      return false; // Don't exit the app
    } else {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
      // Exit the app if on the first tab and no history
      return true;
    }
  }

  Future<bool> onWillPopMain() async {
    // Get current navigator
    print('onWillPopMain');
    print(tabIndex.value);
    print('indddddd');
    if (tabIndex.value != 0) {
      changeTabIndex(0);
      return false; // Don't exit the app
    } else {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }

      return true;
    }
  }

  LandingPageController() {
    // isTokenExpired();
    checkCompleteDataFromApi();
    loadMainDataFromApi();
  }
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadMainTypesFromApi(key, parent, codeId, param, lang) async {
    try {
      var url = Uri.parse("https://apply.azal-ye.com/api/list-id");

      var currentToken = Get.find<AuthController>().showToken();
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $currentToken',
      };
      Map body = {
        "lang_id": lang,
        "key": key, // "complaintstype",
        "v_p_code_id": parent,
        "v_code_id": codeId
      };
      print('bodytypes');
      print(body);
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadMainTypesFromApi");
      print(json);

      //print(json['data'][0][param.toString()]);
      return json['data'][0][param.toString()].toString();
    } catch (error) {
      print("loadMainTypesFromApi catch");
    }
    //
  }

  loadMainDataFromApi() async {
    try {
      var url = Uri.parse("https://apply.azal-ye.com/api/main-data");
      loadings(true);
      rebuild(true);
      var currentToken = Get.find<AuthController>().showToken();

      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $currentToken',
      };
      Map body = {
        "lang_id": Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase()
      };
      print(body);
      // final IOClient httppo = await httpp.HttpsConnect().https();
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadMainDataFromApi");
      if (response.statusCode == 200) {
        // print(json);
        allapplication.value = json['data']['allapplication'];
        suspendedapplication.value = json['data']['suspendedapplication'];
        approvalappliaction.value = json['data']['approvalappliaction'];
        totalBalance.value = json['data']['total_balance'];
      }
    } catch (error) {
      print("loadMainDataFromApi catch");
    }
    loadings(false);
    rebuild(false);
  }

  checkCompleteDataFromApi() async {
    try {
      var url = Uri.parse("https://apply.azal-ye.com/api/check-complete-data");
      var currentToken = Get.find<AuthController>().showToken();
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $currentToken',
      };
      Map body = {
        "lang_id": Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase()
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      if (json['status'] == true) {
        isCompleted(true);
      } else {
        isCompleted(false);
      }
      print("isCompleted");
      print(isCompleted);
    } catch (error) {
      isCompleted(true);
      print("isCompleted catch");
      print(isCompleted);
    }
  }

  loading() {}
  isTokenExpired() {
    bool hasExpired =
        JwtDecoder.isExpired(Get.find<AuthController>().showToken());
    print(hasExpired);
    print('isTokenNotExpired');
    // bool hasExpired = Jwt.isExpired(Get.find<AuthController>().showToken());
    if (hasExpired) {
      Get.find<AuthController>().onlylogoutFromApi();
      print('isTokenExpired');
      dialogTimeOutToken("session_timeOut".tr);
    }
    return hasExpired;
  }

  dialogMS(message, {key}) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Material(
                  child: Column(
                    children: [
                      // const SizedBox(height: 2),
                      Text(
                        "message".tr,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),

                      Text(
                        message,
                        textAlign: TextAlign.center,
                      ),
                      // ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: Text(
                                'OK'.tr,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                primary: Color(0xFFAD1917),
                                onPrimary: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if (key != null) {
                                  Get.toNamed(key);
                                } else {
                                  Get.back();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  dialogCheckMS(key, back, {steps, obj, message}) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                              width: Get.width * 0.33,
                              height: Get.height * 0.13,
                              // height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage("assets/check2.png"),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                              child: Text(
                                message != null
                                    ? message
                                    : "correct_message".tr,
                                style: TextStyle(
                                    fontSize: message != null ? 15 : 20,
                                    fontWeight: FontWeight.w900),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                child: Text(
                                  'OK'.tr,
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(0, 45),
                                  primary: Color.fromARGB(255, 146, 173, 118),
                                  onPrimary: const Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () async {
                                  if (steps != null) {
                                    goBackTwoSteps(steps);
                                  } else if (back) {
                                    Get.back();
                                  } else if (obj != null) {
                                    obj;
                                    Get.back(closeOverlays: false);
                                  } else {
                                    await Get.toNamed(key);
                                  }
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void goBackTwoSteps(count) {
    int count = 0;
    Get.until((route) => count++ == 2);
  }

  dialogCheckMS2(key, back) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                              width: Get.width * 0.4,
                              height: Get.height * 0.2,
                              // height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage("assets/check2.png"),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                              child: Text(
                                "correct_message".tr,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w900),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: Text(
                                'OK'.tr,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                primary: Color.fromARGB(255, 146, 173, 118),
                                onPrimary: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if (back) {
                                  // Get.back();
                                  int count = 0;
                                  Get.until((route) => count++ == 2);
                                } else {
                                  Get.toNamed(key);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  dialogLogout(message) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Material(
                  child: Column(
                    children: [
                      // const SizedBox(height: 2),
                      Text(
                        "message".tr,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),

                      Text(
                        message,
                        textAlign: TextAlign.center,
                      ),
                      // ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: Text(
                                'OK'.tr,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                primary: Color.fromARGB(255, 146, 173, 118),
                                onPrimary: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.find<AuthController>().logoutFromApi();
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              child: Text(
                                'NO'.tr,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                primary: Color(0xFFAD1917),
                                onPrimary: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  dialogVerify(message) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Material(
                  child: Column(
                    children: [
                      Text(
                        "message".tr,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),

                      Text(
                        message,
                        textAlign: TextAlign.center,
                      ),
                      // ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: Text(
                                'OK'.tr,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                primary: Color.fromARGB(255, 146, 173, 118),
                                onPrimary: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.find<AuthController>()
                                    .generateCodeWithToken(
                                        Get.find<AuthController>().showPhone());
                                Get.toNamed(AppRoutes.verifiedPage);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              child: Text(
                                'NO'.tr,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                primary: Color(0xFFAD1917),
                                onPrimary: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  dialogTimeOutToken(message) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Material(
                  child: Column(
                    children: [
                      // const SizedBox(height: 2),
                      Text(
                        "message".tr,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),

                      Text(
                        message,
                        textAlign: TextAlign.center,
                      ),
                      // ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              child: Text(
                                'OK'.tr,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                primary: Color(0xFFAD1917),
                                onPrimary: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.find<AuthController>().logoutFromApi();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
