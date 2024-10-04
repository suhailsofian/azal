import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../routes/app_routes.dart';
// import 'package:get_storage/get_storage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

HomeController homeController = HomeController();

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController mobile = TextEditingController();
    TextEditingController identityId = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    String? selectedValue = '';
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x218BAB7F),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 41),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(1, 0, 0, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                      child: Text(
                                        'Username'.tr,
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
                                        controller: username,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please_enter_your_username"
                                                .tr;
                                          }
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Write_Name'.tr,
                                            // labelText: "Username",
                                            fillColor: Color.fromARGB(
                                                255, 146, 173, 118),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 146, 173, 118),
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                                      child: Text(
                                        'Mobile'.tr,
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
                                        controller: mobile,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.number,
                                        maxLength: 9,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please_enter_your_phone_number"
                                                .tr;
                                          }
                                          if (!GetUtils.isNumericOnly(value!)) {
                                            return "isNumericOnly".tr;
                                          }
                                          if (GetUtils.isPhoneNumber(value!)) {
                                            return null;
                                          }
                                          if (!validEnglish(value!)) {
                                            return "Please_enter_valid_text".tr;
                                          }
                                          return "Enter_valid_phone_number".tr;
                                        },
                                        decoration: InputDecoration(
                                            hintText: '********* 967+',
                                            // labelText: "Mobile Number",
                                            fillColor: Color.fromARGB(
                                                255, 146, 173, 118),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 146, 173, 118),
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(13, 0, 0, 8),
                                      child: Text(
                                        'Identity_Type'.tr,
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
                                        () => DropdownButtonFormField2<String>(
                                          decoration: InputDecoration(
                                            fillColor: Color.fromARGB(
                                                255, 146, 173, 118),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 146, 173, 118),
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            // Add more decoration..
                                          ),
                                          hint: Text(
                                            'Select_Your_Choice'.tr,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          items: authController
                                              .identityTypesLists
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item['code_id']
                                                        .toString(),
                                                    child: Text(
                                                      item['name'].toString(),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Select_Your_Choice'.tr;
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            selectedValue = value.toString();
                                            //Do something when selected item is changed.
                                          },
                                          onSaved: (value) {
                                            selectedValue = value.toString();
                                          },
                                          buttonStyleData:
                                              const ButtonStyleData(
                                            padding: EdgeInsets.only(right: 8),
                                          ),
                                          iconStyleData: const IconStyleData(
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black45,
                                            ),
                                            iconSize: 24,
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(1, 0, 0, 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                                      child: Text(
                                        'IdentityId'.tr,
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
                                        controller: identityId,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please_enter_your_identityId"
                                                .tr;
                                          }
                                          if (!GetUtils.isNumericOnly(value)) {
                                            return "isNumericOnly".tr;
                                          }
                                          if (!validEnglish(value)) {
                                            return "Please_enter_valid_text".tr;
                                          }
                                          if (value.length > 11) {
                                            return "Enter_valid_length_11".tr;
                                          }

                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'IdentityId'.tr,
                                            // labelText: "Mobile Number",
                                            fillColor: Color.fromARGB(
                                                255, 146, 173, 118),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 146, 173, 118),
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(1, 0, 0, 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
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
                                              return "Enter_valid_length_8".tr;
                                            }
                                            return null;
                                          },
                                          obscureText:
                                              authController.obscureds1.value,
                                          decoration: InputDecoration(
                                            hintText: 'Password'.tr,
                                            // labelText: "Mobile Number",
                                            fillColor: Color.fromARGB(
                                                255, 146, 173, 118),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 146, 173, 118),
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            border: OutlineInputBorder(),
                                            suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 4, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  authController
                                                          .obscureds1.value =
                                                      !authController
                                                          .obscureds1.value;
                                                },
                                                child: Icon(
                                                  authController
                                                          .obscureds1.value
                                                      ? Icons.visibility_rounded
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
                                margin: EdgeInsets.fromLTRB(1, 0, 0, 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
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
                                              return "Password_not_match".tr;
                                            }

                                            if (t.length < 8) {
                                              return "Enter_valid_length_8".tr;
                                            }
                                            return null;
                                          },
                                          obscureText:
                                              authController.obscureds2.value,
                                          decoration: InputDecoration(
                                            hintText: 'Confirm_Password'.tr,
                                            // labelText: "Mobile Number",
                                            fillColor: Color.fromARGB(
                                                255, 146, 173, 118),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 146, 173, 118),
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            border: OutlineInputBorder(),
                                            suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 4, 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  authController
                                                          .obscureds2.value =
                                                      !authController
                                                          .obscureds2.value;
                                                },
                                                child: Icon(
                                                  authController
                                                          .obscureds2.value
                                                      ? Icons.visibility_rounded
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
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFFFFFFF)),
                                  color: Color(0xFFAD1917),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  padding: EdgeInsets.fromLTRB(0.2, 0, 0, 0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFAD1917),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        authController.register(
                                            username.text,
                                            password.text,
                                            confirmPassword.text,
                                            mobile.text,
                                            identityId.text,
                                            selectedValue);
                                      }
                                    },
                                    child: Container(
                                      width: Get.find<LanguageController>()
                                                  .savedLang
                                                  .value ==
                                              'AR'
                                          ? Get.width * 0.27
                                          : Get.width * 0.40,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          "CREATE_ACCOUNT".tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.find<LanguageController>()
                                                  .savedLang
                                                  .value ==
                                              'AR'
                                          ? Get.width * 0.5
                                          : Get.width * 0.55,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          "If_you_already_have_an_account".tr,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: Get.find<LanguageController>()
                                                  .savedLang
                                                  .value ==
                                              'AR'
                                          ? Get.width * 0.28
                                          : Get.width * 0.28,
                                      // margin: const EdgeInsets.only(left: 70, right: 66),
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: TextButton(
                                          onPressed: () {
                                            Get.toNamed(AppRoutes.login);
                                          },
                                          child: Text(
                                            "Login_Now".tr,
                                            style: TextStyle(
                                              color: Color(0xFFAD1917),
                                              // fontSize: 13,
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validEnglish(String value) {
    RegExp regex = RegExp('[a-z A-Z 0-9]');
    return (!regex.hasMatch(value)) ? false : true;
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: Get.size.height * 0.1,
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 199, 207, 189),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.15
                : Get.width * 0.15,
            child: Obx(
              () => FittedBox(
                fit: BoxFit.contain,
                child: Image.network(
                  homeController.logoSite.value.toString(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.2
                : Get.width * 0.13,
          ),
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.33
                : Get.width * 0.35,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text("Registration".tr,
                    style: TextStyle(
                        // fontSize: 22,
                        color: Color(0xFFAD1917),
                        fontWeight: FontWeight.w900))),
          ),
        ],
      ),
      actions: [
        IconButton(
          color: Color.fromARGB(255, 146, 4, 47),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_forward,
            size: 30,
          ),
        ),
      ],
    );
  }
}
