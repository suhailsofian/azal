import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neecoder/app/controllers/auth_controller.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/landingPage_controller.dart';

class VerifiedPage extends StatefulWidget {
  const VerifiedPage({Key? key}) : super(key: key);

  @override
  _VerifiedPageState createState() => _VerifiedPageState();
}

HomeController homeController = HomeController();

class _VerifiedPageState extends State<VerifiedPage> {
  TextEditingController phone = Get.find<AuthController>().phone;

  TextEditingController code = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    phone.text = authController.showPhone();
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        children: <Widget>[
          Container(
            height: Get.height * 0.87,
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
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 10, 0, 4),
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
                                            readOnly: true,
                                            controller: phone,
                                            onSaved: (value) {
                                              phone.text = value.toString();
                                            },
                                            onChanged: (value) {
                                              phone.text = value.toString();
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            keyboardType: TextInputType.number,
                                            maxLength: 9,
                                            validator: (value) {
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
                                    width: double.infinity,
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                            keyboardType: TextInputType.number,
                                            // maxLength: 15,
                                            validator: (t) {
                                              if (t!.isEmpty) {
                                                return "Please_enter_your_code_number"
                                                    .tr;
                                              }
                                              if (!GetUtils.isNumericOnly(t)) {
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
                                        SizedBox(height: 16),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(),
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                                authController
                                                    .verfiyPhoneNumber2(
                                                        code.text, phone.text);
                                              }
                                            },
                                            child: Text(
                                              "Send_Verification_Code".tr,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                // fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16),
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
                                              // if (_formKey.currentState!
                                              //     .validate()) {
                                              authController
                                                  .generateCode(phone.text);

                                              // }
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
    );
  }

  bool validEnglish(String value) {
    RegExp regex = RegExp('[a-z A-Z 0-9]');
    return (!regex.hasMatch(value)) ? false : true;
  }

  Column _buildTop() {
    return Column(
      children: [
        Obx(
          () => Container(
            width: Get.width * 0.3,
            height: Get.height * 0.20,
            // height: 200,
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
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0x218BAB7F),
      centerTitle: true,
      foregroundColor: Colors.black87,
      leading: BackButton(
        onPressed: () {
          if (!Get.find<AuthController>().backToauthenicated.value) {
            Get.back();
          } else {
            Get.find<LandingPageController>().dialogLogout("must_logout".tr);
          }
        },
      ),
      elevation: 0,
      title: Text(
        "",
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      actions: [],
    );
  }
}
