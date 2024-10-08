import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../controllers/registration_controller.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

HomeController homeController = HomeController();

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController editUsername = TextEditingController();
  RegistrationController landingPageController = RegistrationController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  onTapFunction({required BuildContext context}) async {
    landingPageController.chooseDate();
    if (DateFormat("dd-MM-yyyy")
            .format(landingPageController.selectedDate.value) ==
        null) return;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController editUsername =
        Get.find<AuthController>().editUsername;
    TextEditingController editMobile = Get.find<AuthController>().editMobile;
    var editbirthDay = Get.find<AuthController>().editbirthDay;
    var selectedIdentityTypeValue =
        Get.find<AuthController>().selectedIdentityTypeValue;
    TextEditingController identityId = Get.find<AuthController>().identityId;
    var issuanceDate = Get.find<AuthController>().issuanceDate;
    var clientGender = Get.find<AuthController>().clientGender;
    var maritalStatus = Get.find<AuthController>().maritalStatus;
    TextEditingController sourceIncome =
        Get.find<AuthController>().sourceIncome;
    TextEditingController ClientAddress =
        Get.find<AuthController>().ClientAddress;
    var clientGovernorate = Get.find<AuthController>().clientGovernorate;
    var clientDirectorate = Get.find<AuthController>().clientDirectorate;
    var clientArea = Get.find<AuthController>().clientArea;
    TextEditingController numberFamily =
        Get.find<AuthController>().numberFamily;
    TextEditingController NumberMale = Get.find<AuthController>().NumberMale;
    TextEditingController numberFamale =
        Get.find<AuthController>().numberFamale;
    var cleintEducation = Get.find<AuthController>().cleintEducation;
    var how_to_know = Get.find<AuthController>().how_to_know;
    landingPageController.loadClientDirectorateFromApi(
        null, clientGovernorate.value);
    landingPageController.loadClientAreaFromApi(null, clientDirectorate.value);
    for (var element in Get.find<RegistrationController>().identityTypesList) {
      if (element['code_id'].toString() == selectedIdentityTypeValue.value) {
        Get.find<RegistrationController>().checkidentityType(true);
      }
    }

    for (var element in Get.find<RegistrationController>().genderList) {
      if (element['code_id'] == clientGender.value) {
        Get.find<RegistrationController>().checkClientGender(true);
      }
    }
    for (var element in Get.find<RegistrationController>().statusCleintList) {
      if (element['code_id'] == maritalStatus.value) {
        Get.find<RegistrationController>().checkMaritalStatus(true);
      }
    }

    for (var element in Get.find<RegistrationController>().educationlevelList) {
      if (element['code_id'] == cleintEducation.value) {
        Get.find<RegistrationController>().checkCleintEducation(true);
      }
    }

    for (var element
        in Get.find<RegistrationController>().identifytheprogramList) {
      if (element['code_id'] == how_to_know.value) {
        Get.find<RegistrationController>().checkhow_to_know(true);
      }
    }
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
                    child: Obx(
                      () => Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                        child: Text(
                                          'Quartet_name'.tr,
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
                                          controller: editUsername,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.text,
                                          validator: (t) {
                                            if (t!.isEmpty) {
                                              return "Please_enter_your_username"
                                                  .tr;
                                            }
                                            return null;
                                          },
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
                                              hintText: 'Write_Name'.tr,
                                              // labelText: "Username",
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          readOnly: true,
                                          controller: editMobile,
                                          onChanged: (value) {
                                            editMobile.text = value.toString();
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.phone,
                                          maxLength: 9,
                                          validator: (value) {
                                            if (GetUtils.isPhoneNumber(
                                                value!)) {
                                              return null;
                                            }
                                            return "Enter_valid_phone_number"
                                                .tr;
                                          },
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
                                              hintText: '********* 967+',
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                                        child: Text(
                                          'Client_birthDay'.tr,
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
                                          controller: editbirthDay.value,
                                          onChanged: (value) {
                                            editbirthDay.value.text =
                                                value.toString();
                                          },
                                          onTap: () {
                                            landingPageController.chooseDate();
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please_enter_your_birthday_date"
                                                  .tr;
                                            }
                                            return null;
                                          },
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
                                              hintText: 'Client_birthDay'.tr,
                                              suffixIcon: Icon(
                                                  Icons.calendar_today,
                                                  color: Color.fromARGB(
                                                      255, 146, 173, 118)),
                                              // labelText: "Mobile Number",

                                              border: OutlineInputBorder()),
                                        ),
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                  indent: 8,
                                  endIndent: 8,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(13, 0, 0, 8),
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
                                          () =>
                                              DropdownButtonFormField2<String>(
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
                                            items: Get.find<
                                                    RegistrationController>()
                                                .identityTypesList
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
                                                return 'Please_select_choice'
                                                    .tr;
                                              }
                                              return null;
                                            },
                                            value: Get.find<RegistrationController>()
                                                        .checkidentityType ==
                                                    true
                                                ? (selectedIdentityTypeValue
                                                            .value ==
                                                        ''
                                                    ? null
                                                    : selectedIdentityTypeValue
                                                        .value)
                                                : null,
                                            onChanged: null,
                                            onSaved: null,
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 24,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          readOnly: true,
                                          controller: identityId,
                                          onChanged: (value) {
                                            identityId.text = value.toString();
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please_enter_your_identityId"
                                                  .tr;
                                            }
                                            if (!GetUtils.isNumericOnly(
                                                value)) {
                                              return "isNumericOnly".tr;
                                            }
                                            if (!validEnglish(value)) {
                                              return "Please_enter_valid_text"
                                                  .tr;
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
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                                        child: Text(
                                          'issuance_date'.tr,
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
                                            controller: issuanceDate.value,

                                            onChanged: (value) {
                                              issuanceDate.value.text =
                                                  value.toString();
                                            },
                                            onTap: () {
                                              landingPageController
                                                  .chooseIssuanceDate();
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            // keyboardType: TextInputType.text,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please_enter_your_IssuanceDate"
                                                    .tr;
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'issuance_date'.tr,
                                                suffixIcon: Icon(
                                                    Icons.calendar_today,
                                                    color: Color.fromARGB(
                                                        255, 146, 173, 118)),
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
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                  indent: 8,
                                  endIndent: 8,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(13, 0, 0, 8),
                                        child: Text(
                                          'client_gender'.tr,
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
                                          () =>
                                              DropdownButtonFormField2<String>(
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
                                            ),
                                            hint: Text(
                                              'Select_Your_Choice'.tr,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            items: landingPageController
                                                .genderList
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
                                                return 'Please_select_choice'
                                                    .tr;
                                              }
                                              return null;
                                            },
                                            value:
                                                Get.find<RegistrationController>()
                                                            .checkClientGender ==
                                                        true
                                                    ? (clientGender.value == ''
                                                        ? null
                                                        : clientGender.value)
                                                    : null,
                                            onChanged: (value) {
                                              clientGender.value =
                                                  value.toString();
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 24,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(13, 0, 0, 8),
                                        child: Text(
                                          'marital_status'.tr,
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
                                          () =>
                                              DropdownButtonFormField2<String>(
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
                                            ),
                                            hint: Text(
                                              'Select_Your_Choice'.tr,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            items: landingPageController
                                                .statusCleintList
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
                                                return 'Please_select_choice'
                                                    .tr;
                                              }
                                              return null;
                                            },
                                            value:
                                                Get.find<RegistrationController>()
                                                            .checkMaritalStatus ==
                                                        true
                                                    ? (maritalStatus.value == ''
                                                        ? null
                                                        : maritalStatus.value)
                                                    : null,
                                            onChanged: (value) {
                                              maritalStatus.value =
                                                  value.toString();
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 24,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                                        child: Text(
                                          'source_income'.tr,
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
                                          controller: sourceIncome,
                                          onChanged: (value) {
                                            sourceIncome.text =
                                                value.toString();
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please_enter_your_source_income"
                                                  .tr;
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'source_income'.tr,
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
                                SizedBox(height: 10),
                                Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                  indent: 8,
                                  endIndent: 8,
                                ),
                                SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 0, 0, 17),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                                        child: Text(
                                          'Client_address'.tr,
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
                                          controller: ClientAddress,
                                          onChanged: (value) {
                                            ClientAddress.text =
                                                value.toString();
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please_enter_Client_address"
                                                  .tr;
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Client_address'.tr,
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
                                //   SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(13, 0, 0, 8),
                                        child: Text(
                                          'Client_governorate'.tr,
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
                                          () =>
                                              DropdownButtonFormField2<String>(
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
                                            ),
                                            hint: Text(
                                              'Select_Your_Choice'.tr,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            items: landingPageController
                                                .directoratesList
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
                                                return 'Please_select_choice'
                                                    .tr;
                                              }
                                              return null;
                                            },
                                            value: clientGovernorate.value == ''
                                                ? null
                                                : clientGovernorate.value,
                                            onChanged: (value) {
                                              clientGovernorate.value =
                                                  value.toString();
                                              landingPageController.citiesList
                                                  .clear();
                                              landingPageController
                                                  .loadClientDirectorateFromApi(
                                                      null,
                                                      clientGovernorate.value);
                                              clientDirectorate.value = '';
                                              clientArea.value = '';
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 24,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(13, 0, 0, 8),
                                        child: Text(
                                          'Client_directorate'.tr,
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
                                          () =>
                                              DropdownButtonFormField2<String>(
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
                                            ),
                                            hint: Text(
                                              'Select_Your_Choice'.tr,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            items: landingPageController
                                                .citiesList
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
                                                return 'Please_select_choice'
                                                    .tr;
                                              }

                                              return null;
                                            },
                                            value: clientDirectorate.value == ''
                                                ? null
                                                : clientDirectorate.value,
                                            onChanged: (value) {
                                              clientDirectorate.value =
                                                  value.toString();
                                              landingPageController.areasList
                                                  .clear();
                                              landingPageController
                                                  .loadClientAreaFromApi(null,
                                                      clientDirectorate.value);
                                              clientArea.value = '';
                                              //Do something when selected item is changed.
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 24,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(13, 0, 0, 8),
                                        child: Text(
                                          'Client_area'.tr,
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
                                          () =>
                                              DropdownButtonFormField2<String>(
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
                                            items: landingPageController
                                                .areasList
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
                                                return 'Please_select_choice'
                                                    .tr;
                                              }
                                              return null;
                                            },
                                            value: clientArea.value == ''
                                                ? null
                                                : clientArea.value,
                                            onChanged: (value) {
                                              clientArea.value =
                                                  value.toString();
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 24,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                  indent: 8,
                                  endIndent: 8,
                                ),
                                SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 0, 0, 17),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                                        child: Text(
                                          'number_family'.tr,
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
                                          controller: numberFamily,
                                          onChanged: (value) {
                                            numberFamily.text =
                                                value.toString();
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please_enter_your_number_of_family"
                                                  .tr;
                                            }
                                            if (!value.isNumericOnly) {
                                              return "Please_enter_Numeric_number"
                                                  .tr;
                                            }
                                            if (!validEnglish(value)) {
                                              return "Please_enter_valid_text"
                                                  .tr;
                                            }

                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'number_family'.tr,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                                        child: Text(
                                          'Number_male'.tr,
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
                                          controller: NumberMale,
                                          onChanged: (value) {
                                            NumberMale.text = value.toString();
                                            //Do something when selected item is changed.
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please_enter_your_number_of_male"
                                                  .tr;
                                            }
                                            if (!value.isNumericOnly) {
                                              return "Please_enter_Numeric_number"
                                                  .tr;
                                            }
                                            if (!validEnglish(value)) {
                                              return "Please_enter_valid_text"
                                                  .tr;
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Number_male'.tr,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                                        child: Text(
                                          'Number_famale'.tr,
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
                                          controller: numberFamale,
                                          onChanged: (value) {
                                            numberFamale.text =
                                                value.toString();
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please_enter_your_number_of_famale"
                                                  .tr;
                                            }
                                            if (!value.isNumericOnly) {
                                              return "Please_enter_Numeric_number"
                                                  .tr;
                                            }
                                            if (!validEnglish(value)) {
                                              return "Please_enter_invalid_text"
                                                  .tr;
                                            }

                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Number_famale'.tr,
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
                                Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                  indent: 8,
                                  endIndent: 8,
                                ),
                                SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(13, 0, 0, 8),
                                        child: Text(
                                          'Cleint_education'.tr,
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
                                          () =>
                                              DropdownButtonFormField2<String>(
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
                                            items: landingPageController
                                                .educationlevelList
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
                                                return 'Please_select_choice'
                                                    .tr;
                                              }
                                              return null;
                                            },
                                            value: Get.find<RegistrationController>()
                                                        .checkCleintEducation ==
                                                    true
                                                ? (cleintEducation.value == ''
                                                    ? null
                                                    : cleintEducation.value)
                                                : null,
                                            onChanged: (value) {
                                              cleintEducation.value =
                                                  value.toString();
                                              //Do something when selected item is changed.
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 24,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(13, 0, 0, 8),
                                        child: Text(
                                          'How_to_know'.tr,
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
                                          () =>
                                              DropdownButtonFormField2<String>(
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
                                            items: landingPageController
                                                .identifytheprogramList
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
                                                return 'Please_select_choice'
                                                    .tr;
                                              }
                                              return null;
                                            },
                                            value:
                                                Get.find<RegistrationController>()
                                                            .checkhow_to_know ==
                                                        true
                                                    ? (how_to_know.value == ''
                                                        ? null
                                                        : how_to_know.value)
                                                    : null,
                                            onChanged: (value) {
                                              how_to_know.value =
                                                  value.toString();
                                              //Do something when selected item is changed.
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 24,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                  indent: 8,
                                  endIndent: 8,
                                ),

                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFFFFFFFF)),
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
                                          landingPageController.editRegister(
                                              editUsername.text,
                                              editMobile.text,
                                              editbirthDay.value.text,
                                              selectedIdentityTypeValue.value,
                                              identityId.text,
                                              issuanceDate.value.text,
                                              clientGender.value,
                                              maritalStatus.value,
                                              sourceIncome.text,
                                              ClientAddress.text,
                                              clientGovernorate.value,
                                              clientDirectorate.value,
                                              clientArea.value,
                                              numberFamily.text,
                                              NumberMale.text,
                                              numberFamale.text,
                                              cleintEducation.value,
                                              how_to_know.value);
                                        }
                                      },
                                      child: Text(
                                        "save_modification".tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          // fontSize: 13,
                                        ),
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
      toolbarHeight: Get.height * 0.1,
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
                : Get.width * 0.1,
          ),
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.4
                : Get.width * 0.48,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text("Registration_Details".tr,
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
