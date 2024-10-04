import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

HomeController homeController = HomeController();

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        children: <Widget>[
          Container(
            height: Get.height * 0.86,
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
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 4),
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
                                                if (t.length < 8) {
                                                  return "Enter_valid_length_8"
                                                      .tr;
                                                }
                                                return null;
                                              },
                                              obscureText: authController
                                                  .obscureds1.value,
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
                                                      authController.obscureds1
                                                              .value =
                                                          !authController
                                                              .obscureds1.value;
                                                    },
                                                    child: Icon(
                                                      authController
                                                              .obscureds1.value
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
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 17),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 0, 0, 9),
                                          child: Text(
                                            'Confirm_Password'.tr,
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
                                              controller: confirmPassword,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              keyboardType: TextInputType.text,
                                              validator: (t) {
                                                if (t!.isEmpty) {
                                                  return "Please_enter_your_confirm_password"
                                                      .tr;
                                                }
                                                if (t != password.text) {
                                                  return "Password_not_match"
                                                      .tr;
                                                }

                                                if (t.length < 8) {
                                                  return "Enter_valid_length_8"
                                                      .tr;
                                                }
                                                return null;
                                              },
                                              obscureText: authController
                                                  .obscureds2.value,
                                              decoration: InputDecoration(
                                                hintText: 'Confirm_Password'.tr,
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
                                                      authController.obscureds2
                                                              .value =
                                                          !authController
                                                              .obscureds2.value;
                                                    },
                                                    child: Icon(
                                                      authController
                                                              .obscureds2.value
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
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFAD1917),
                                        padding: EdgeInsetsDirectional.all(9),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          authController.changePassword(
                                              password.text,
                                              confirmPassword.text);
                                        }
                                      },
                                      child: Text(
                                        "Reset_Password".tr,
                                        style: TextStyle(
                                          // color: kcPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                          // fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildTop() {
    return Column(
      children: [
        Obx(
          () => Container(
            width: Get.width * 0.3,
            height: Get.height * 0.23,
            // height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(homeController.logoSite.value.toString()),
              ),
              // shape: BoxShape.circle,
            ),
          ),
        ),
        Text(
          "change_password".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0x218BAB7F),
      foregroundColor: Colors.black87,
      elevation: 0,
    );
  }
}
