import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';

class VerifiedPageAfterSignUp extends StatefulWidget {
  const VerifiedPageAfterSignUp({Key? key}) : super(key: key);

  @override
  _VerifiedPageAfterSignUpState createState() =>
      _VerifiedPageAfterSignUpState();
}

HomeController homeController = HomeController();

class _VerifiedPageAfterSignUpState extends State<VerifiedPageAfterSignUp> {
  TextEditingController code = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: ListView(
          children: <Widget>[
            Container(
              height: Get.height * 0.88,
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
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0x218BAB7F),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: SizedBox(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 55),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(10, 10, 10, 17),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 9),
                                            child: Text(
                                              'Verification_Code'.tr,
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
                                              controller: code,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (t) {
                                                if (t!.isEmpty) {
                                                  return "Please_enter_your_code_number"
                                                      .tr;
                                                }
                                                if (!GetUtils.isNumericOnly(
                                                    t)) {
                                                  return "isNumericOnly".tr;
                                                }
                                                if (!validEnglish(t)) {
                                                  return "Please_enter_valid_text"
                                                      .tr;
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'enter_Verification_Code'
                                                          .tr,
                                                  fillColor: Color.fromARGB(
                                                      255, 146, 173, 118),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    146,
                                                                    173,
                                                                    118),
                                                            width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  border: OutlineInputBorder()),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xFFFFFFFF)),
                                              color: Color(0xFFAD1917),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            padding: EdgeInsets.fromLTRB(
                                                0.2, 0, 0, 0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xFFAD1917),
                                              ),
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  print(code.text);
                                                  authController
                                                      .verfiyPhoneNumber(
                                                          code.text);
                                                }
                                              },
                                              child: Text(
                                                "Send_Verification_Code".tr,
                                                style: TextStyle(
                                                  // color: kcPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  // fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xFFFFFFFF)),
                                              color: Color(0xFFAD1917),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            padding: EdgeInsets.fromLTRB(
                                                0.2, 0, 0, 0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xFFAD1917),
                                              ),
                                              onPressed: () {
                                                print(
                                                    "generate_verification_code");
                                                authController
                                                    .generateCode(null);
                                              },
                                              child: Text(
                                                "generate_verification_code".tr,
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(homeController.logoSite.value.toString()),
              ),
            ),
          ),
        ),
        Text(
          "Send_Verification_Code".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  bool validEnglish(String value) {
    RegExp regex = RegExp('[a-z A-Z 0-9]');
    return (!regex.hasMatch(value)) ? false : true;
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0x218BAB7F),
      centerTitle: true,
      elevation: 0,
      title: Text(
        "",
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      actions: [],
    );
  }
}
