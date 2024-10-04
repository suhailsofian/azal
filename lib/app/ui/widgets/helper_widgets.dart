import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neecoder/app/controllers/auth_controller.dart';
import 'package:neecoder/app/controllers/landingPage_controller.dart';
import 'package:neecoder/app/controllers/languages_controller.dart';
import 'package:neecoder/app/routes/app_routes.dart';

Widget addVerticalSpace(double space) => SizedBox(height: space);
Widget addHorizontalSpace(double space) => SizedBox(width: space);
Widget gridWeatherBuilder2(String header, String body, IconData icon,
    double height, double width, tabIndex, tabNo) {
  final NumberFormat usCurrency = NumberFormat('#,##0', 'en_US');
  // print(body);
  // print('body');
  return Container(
    // height: 95,
    height: width * 0.24,
    width: width * 0.44,
    // width: 177,
    // width: MediaQuery.of(context as BuildContext).size.width,
    margin: const EdgeInsets.symmetric(horizontal: 1.5, vertical: 8.0),
    child: InkWell(
      onTap: () {
        // tabIndex.tabIndex.value = tabNo;
        // Get.back();
        //   landingPageController.dialogCheckMS("", true);
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(9),
        color: Color.fromARGB(255, 225, 232, 215),
        child: Padding(
          padding: const EdgeInsets.only(right: 0, left: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width * 0.08,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(
                    icon,
                    color: Color(0xFF92AD76),
                    // size: 35,
                  ),
                ),
              ),
              // Icon(
              //   icon,
              //   color: Colors.blue,
              //   size: 35,
              // ),
              SizedBox(
                  width: Get.find<LanguageController>().savedLang.value == 'AR'
                      ? Get.width * 0.01
                      : Get.width * 0.01),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.3,
                    // child: FittedBox(
                    //   fit: BoxFit.cover,
                    child:
                        Get.find<LandingPageController>().rebuild.value == true
                            ? Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: Color(0xFFAD1917),
                                  size: Get.width * 0.1,
                                ),
                              )
                            : Text(
                                header.tr != '0'
                                    ? usCurrency.format(int.parse(header.tr))
                                    : '0.0',
                                // maxLines: 1,
                                style: TextStyle(
                                  color: Color(0xFFAD1917),
                                  fontSize: Get.find<LanguageController>()
                                              .savedLang
                                              .value ==
                                          'AR'
                                      ? Get.width * 0.05
                                      : Get.width * 0.05,
                                  // fontWeight: FontWeight.w400,
                                ),
                                // ),
                              ),
                  ),
                  // Flexible(
                  //   child: FittedBox(
                  //     fit: BoxFit.contain,
                  //     child: Text(
                  //       header.tr,
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w700,
                  //         fontSize: 18,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   width: width * 0.25,
                  //   child: FittedBox(
                  //     fit: BoxFit.fitWidth,
                  //     child: AutoSizeText(
                  //       body.tr,
                  //       maxLines: 1,
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //         // fontSize: 15,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    child: Text(
                      body.tr,
                      style: TextStyle(
                        color: Color(0xFFAD1917),
                        fontSize:
                            Get.find<LanguageController>().savedLang.value ==
                                    'AR'
                                ? Get.width * 0.042
                                : Get.width * 0.03,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),

                  // Flexible(
                  //   child: FittedBox(
                  //     fit: BoxFit.contain,
                  //     child: Text(
                  //       body.tr,
                  //       style:
                  //           TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget dailyWidget2(
    branch, count, c, welcome, double height, double width, landingController) {
  // final time = weather.date;
  // final hours = DateFormat.Hm().format(time);
  return landingController.isCompleted.value == true
      ? Container()
      : Container(
          height: height / 6,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          child: Material(
            // elevation: 5,
            color: Color.fromARGB(103, 240, 161, 161),
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 33, top: 11, right: 39, bottom: 0),
              child: Column(
                children: [
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  Container(
                    width:
                        Get.find<LanguageController>().savedLang.value == 'AR'
                            ? width * 0.6
                            : width * 0.8,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: AutoSizeText(
                        "complete_your_data".tr,
                        maxLines: 1,
                        style: TextStyle(
                            // fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  // Text(
                  //   "complete_your_data".tr,
                  //   style: TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.grey),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    width:
                        Get.find<LanguageController>().savedLang.value == 'AR'
                            ? width * 0.4
                            : width * 0.7,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: TextButton(
                        onPressed: () async {
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(
                          //   builder: (context) => LandingPage(),
                          // ));
                          await Get.find<AuthController>()
                              .viewUserProfileFromApi(null);
                          Get.toNamed(AppRoutes.registrationDetails);
                          //  Navigator.of(context).push(MaterialPageRoute(
                          //           builder: (context) => RegistrationPage(),
                          //         ));
                        },
                        child: AutoSizeText(
                          "click_your_data".tr,
                          maxLines: 1,
                          style: TextStyle(
                              // fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),

                        // Text(
                        //   "click_your_data".tr,
                        //   style: TextStyle(
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.bold,
                        //       color: Color.fromARGB(180, 62, 16, 16)),
                        // ),
                      ),
                      // AutoSizeText(
                      //   "complete_your_data".tr,
                      //   maxLines: 1,
                      //   style: TextStyle(
                      //       // fontSize: 14,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.grey),
                      // ),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     // Navigator.of(context)
                  //     //     .push(MaterialPageRoute(
                  //     //   builder: (context) => LandingPage(),
                  //     // ));
                  //     Get.toNamed(AppRoutes.registrationDetails);
                  //     //  Navigator.of(context).push(MaterialPageRoute(
                  //     //           builder: (context) => RegistrationPage(),
                  //     //         ));
                  //   },
                  //   child: Text(
                  //     "click_your_data".tr,
                  //     style: TextStyle(
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color.fromARGB(180, 62, 16, 16)),
                  //   ),
                  // ),
                  // ],
                  // ),
                  // const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
}
