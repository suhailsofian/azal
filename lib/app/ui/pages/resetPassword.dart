import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

HomeController homeController = HomeController();

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final AuthController authController = Get.find<AuthController>();
  TextEditingController phone = Get.find<AuthController>().phone;
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    phone.text =
        authController.showPhone() != null ? authController.showPhone() : "";
    print(phone.value);
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height * 0.88,
          decoration: BoxDecoration(
            color: Color(0x218BAB7F),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0x218BAB7F),
            ),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(6),
                          ),

                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 33),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                          keyboardType: TextInputType.phone,
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
                                              fillColor: Color(0xFFAD1917),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFAD1917),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(0.2, 0, 0, 0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFAD1917),
                                            padding:
                                                EdgeInsetsDirectional.all(10),
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // //print("checkBool");
                                              authController
                                                  .generateCode2ForgetPass(
                                                      phone.text);
                                              // Get.toNamed(AppRoutes.verifiedPage);
                                            }
                                          },
                                          child: Text(
                                            "Send_verfication_code".tr,
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
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // ],
      ),
    );
  }

  Container _buildTop() {
    return Container(
      child: Column(
        children: [
          Obx(
            () => Container(
              width: Get.width * 0.3,
              height: Get.height * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(homeController.logoSite.value.toString()),
                ),
              ),
            ),
          ),
          Text(
            "Forget_password".tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0x218BAB7F),
      centerTitle: true,
      foregroundColor: Colors.black87,
      elevation: 0,
      title: Text(
        "",
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      actions: [],
    );
  }
}
