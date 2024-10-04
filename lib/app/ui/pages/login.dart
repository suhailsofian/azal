import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phone = Get.find<AuthController>().phone;

  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // AuthController authController = AuthController();
  HomeController controller = HomeController();
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    phone.text =
        authController.showPhone() != null ? authController.showPhone() : "";
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: Get.height,
                decoration: BoxDecoration(
                  color: Color(0x218BAB7F),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTop(),
                    Form(
                      key: _formKey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0x218BAB7F),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Container(
                            // height: Get.height,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(6),
                            ),

                            child: Container(
                              // height: Get.height,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    // margin: EdgeInsets.fromLTRB(1, 0, 0, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Phone_Number'.tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              height: 1.5,
                                              color: Color(0xFF212529),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: TextFormField(
                                            controller: phone,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            keyboardType: TextInputType.number,
                                            maxLength: 9,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please_enter_your_phone_number"
                                                    .tr;
                                              }
                                              if (!GetUtils.isNumericOnly(
                                                  value!)) {
                                                return "isNumericOnly".tr;
                                              }
                                              if (GetUtils.isPhoneNumber(
                                                  value!)) {
                                                return null;
                                              }

                                              return "Enter_valid_phone_number"
                                                  .tr;
                                            },
                                            decoration: InputDecoration(
                                                hintText: '********* 967+',
                                                // labelText: "Mobile Number",
                                                fillColor: Color.fromARGB(
                                                    255, 146, 173, 118),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 146, 173, 118),
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Password'.tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              height: 1.5,
                                              color: Color(0xFF212529),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Obx(
                                            () => TextFormField(
                                              controller: password,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              keyboardType: TextInputType.text,
                                              validator: (t) {
                                                if (t!.isEmpty) {
                                                  return "Please_enter_your_password"
                                                      .tr;
                                                }

                                                return null;
                                              },
                                              obscureText:
                                                  authController.obscured.value,
                                              decoration: InputDecoration(
                                                hintText: 'Password'.tr,
                                                // labelText: "Mobile Number",
                                                fillColor: Color.fromARGB(
                                                    255, 146, 173, 118),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 146, 173, 118),
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                border: OutlineInputBorder(),
                                                suffixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 4, 0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      authController
                                                              .obscured.value =
                                                          !authController
                                                              .obscured.value;
                                                    },
                                                    child: Icon(
                                                      authController.obscured.value
                                                          ? Icons
                                                              .visibility_rounded
                                                          : Icons
                                                              .visibility_off_rounded,
                                                      size: 24,
                                                      color: Color.fromARGB(
                                                          255, 146, 173, 118),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Obx(
                                            () => CheckboxListTile(
                                              title: Text("remember_me".tr),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: authController
                                                  .checkBool.value,
                                              onChanged: (value) => {
                                                authController.checkBool.value =
                                                    !authController
                                                        .checkBool.value,
                                              },
                                              activeColor: Color(0xFFAD1917),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(),
                                          padding:
                                              EdgeInsets.fromLTRB(0.2, 0, 0, 0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xFFAD1917),
                                              padding:
                                                  EdgeInsetsDirectional.all(9),
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                authController.loginWithEmail(
                                                    phone.text,
                                                    password.text,
                                                    authController
                                                        .checkBool.value);
                                              }
                                            },
                                            child: Container(
                                              width:
                                                  Get.find<LanguageController>()
                                                              .savedLang
                                                              .value ==
                                                          'AR'
                                                      ? Get.width * 0.27
                                                      : Get.width * 0.14,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  "Login".tr,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    // fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 10, 5, 0),
                                          // child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "If_you_do_not_have_an_account_now"
                                                    .tr,
                                                style: TextStyle(
                                                    fontSize:
                                                        Get.find<LanguageController>()
                                                                    .savedLang
                                                                    .value ==
                                                                'AR'
                                                            ? Get.width * 0.039
                                                            : Get.width *
                                                                0.033),
                                              ),
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1.0),
                                                child: InkWell(
                                                    onTap: () {
                                                      Get.toNamed(AppRoutes
                                                          .registration);
                                                    },
                                                    child: Text(
                                                      " " + "Register_Now".tr,
                                                      style: TextStyle(
                                                          fontSize: Get.find<
                                                                          LanguageController>()
                                                                      .savedLang
                                                                      .value ==
                                                                  'AR'
                                                              ? Get.width * 0.03
                                                              : Get.width *
                                                                  0.03,
                                                          color: Color(
                                                              0xFFAD1917)),
                                                    )),
                                              )
                                            ],
                                          ),
                                          // ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                5, 10, 5, 0),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 1.0),
                                              child: InkWell(
                                                  onTap: () {
                                                    Get.toNamed(AppRoutes
                                                        .resetPasswordPage);
                                                  },
                                                  child: Text(
                                                    "Forget_password".tr,
                                                    style: TextStyle(
                                                        fontSize:
                                                            Get.find<LanguageController>()
                                                                        .savedLang
                                                                        .value ==
                                                                    'AR'
                                                                ? Get.width *
                                                                    0.037
                                                                : Get.width *
                                                                    0.035,
                                                        color:
                                                            Color(0xFFAD1917)),
                                                  )),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTop() {
    return Container(
      width: Get.width * 0.5,
      height: Get.find<LanguageController>().savedLang.value == 'AR'
          ? Get.height * 0.29
          : Get.height * 0.29,
      child: Column(
        children: [
          Obx(
            () => Container(
              width: Get.width * 0.3,
              height: Get.height * 0.23,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(controller.logoSite.value.toString()),
                ),
              ),
            ),
          ),
          Text(
            "Login".tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Get.find<LanguageController>().savedLang.value == 'AR'
                  ? Get.width * 0.045
                  : Get.width * 0.043,
            ),
          ),
        ],
      ),
    );
  }
}
