import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/complaint_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../controllers/registration_controller.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({Key? key}) : super(key: key);

  @override
  _ComplaintsPageState createState() => _ComplaintsPageState();
}

HomeController homeController = HomeController();

class _ComplaintsPageState extends State<ComplaintsPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var selectedClassValue =
      Get.find<RegistrationController>().selectedClassValue;
  TextEditingController complaintDetails = TextEditingController();
  TextEditingController complaintSubject = TextEditingController();
  @override
  Widget build(BuildContext context) {
    complaintDetails.clear();
    complaintSubject.clear();
    // selectedClassValue.te = '';
    String? selectedValue;
    String? selectedMainClassValue;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // _buildTop(),

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
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(13, 0, 0, 8),
                                      child: Text(
                                        'Complaints_type'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          height: 1.5,
                                          color: Color(0xFF212529),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // padding: const EdgeInsets.symmetric(
                                      //     horizontal: 15),
                                      // padding:
                                      //     EdgeInsets.fromLTRB(14, 0, 14, 0),
                                      child: Obx(
                                        () => DropdownButtonFormField2<String>(
                                          decoration: InputDecoration(
                                            // Add Horizontal padding using menuItemStyleData.padding so it matches
                                            // the menu padding when button's width is not specified.
                                            // contentPadding:
                                            //     const EdgeInsets.symmetric(
                                            //         vertical: 2),
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
                                          items:
                                              Get.find<RegistrationController>()
                                                  .complaintsTypeList
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item['code_id']
                                                            .toString(),
                                                        child: Text(
                                                          item['name']
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please_select_choice'.tr;
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
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(13, 0, 0, 8),
                                      child: Text(
                                        'Main_classification'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          height: 1.5,
                                          color: Color(0xFF212529),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // padding: const EdgeInsets.symmetric(
                                      //     horizontal: 15),
                                      // padding:
                                      //     EdgeInsets.fromLTRB(14, 0, 14, 0),
                                      child: Obx(
                                        () => DropdownButtonFormField2<String>(
                                          decoration: InputDecoration(
                                            // Add Horizontal padding using menuItemStyleData.padding so it matches
                                            // the menu padding when button's width is not specified.
                                            // contentPadding:
                                            //     const EdgeInsets.symmetric(
                                            //         vertical: 2),
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
                                          items:
                                              Get.find<RegistrationController>()
                                                  .mainClassList
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item['issue_id']
                                                            .toString(),
                                                        child: Text(
                                                          item['issue_name']
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please_select_choice'.tr;
                                            }
                                            return null;
                                          },
                                          onChanged: (value) async {
                                            selectedMainClassValue =
                                                value.toString();

                                            // =null;
                                            selectedClassValue.value = '';
                                            await Get.find<
                                                    RegistrationController>()
                                                .loadClassFromApi(
                                                    null, value.toString());
                                            // Get.find<RegistrationController>()
                                            //     .classList
                                            //     .clear();
                                            //Do something when selected item is changed.
                                          },
                                          onSaved: (value) {
                                            selectedMainClassValue =
                                                value.toString();
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
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(13, 0, 0, 8),
                                      child: Text(
                                        'Subcategory'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          height: 1.5,
                                          color: Color(0xFF212529),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // padding: const EdgeInsets.symmetric(
                                      //     horizontal: 15),
                                      // padding:
                                      //     EdgeInsets.fromLTRB(14, 0, 14, 0),
                                      child: Obx(
                                        () => DropdownButtonFormField2<String>(
                                          decoration: InputDecoration(
                                            // Add Horizontal padding using menuItemStyleData.padding so it matches
                                            // the menu padding when button's width is not specified.
                                            // contentPadding:
                                            //     const EdgeInsets.symmetric(
                                            //         vertical: 1),
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
                                          items:
                                              Get.find<RegistrationController>()
                                                  .classList
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item['seq']
                                                            .toString(),
                                                        child: Text(
                                                          item['issue_name']
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please_select_choice'.tr;
                                            }
                                            return null;
                                          },
                                          value: selectedClassValue.value == ''
                                              ? null
                                              : selectedClassValue.value,
                                          onChanged: (value) {
                                            selectedClassValue.value =
                                                value.toString();

                                            //Do something when selected item is changed.
                                          },
                                          onSaved: (value) {
                                            selectedClassValue.value =
                                                value.toString();
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
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                                      child: Text(
                                        'Complaint_Subject'.tr,
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
                                        controller: complaintSubject,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.text,
                                        validator: (t) {
                                          if (t!.isEmpty) {
                                            return "Please_enter_your_Complaint_Subject"
                                                .tr;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Complaint_Subject'.tr,
                                            // labelText: "Mobile Number",
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(1, 0, 0, 10),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(8, 0, 0, 4),
                                      child: Text(
                                        'Complaint_details'.tr,
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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.text,
                                        expands: false,
                                        minLines: 1,
                                        maxLines: 3,
                                        controller: complaintDetails,
                                        validator: (t) {
                                          if (t!.isEmpty) {
                                            return "Please_enter_your_Complaint_details"
                                                .tr;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Complaint_details'.tr,
                                            // labelText: "Mobile Number",
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFFFFFFF)),
                                  color: Color(0xFF7F0026),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 45,
                                  padding: EdgeInsets.fromLTRB(0.2, 0, 0, 0),
                                  // child: IgnorePointer(
                                  //   ignoring: false, // or false
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFAD1917),

                                      // padding: EdgeInsetsDirectional.all(4),
                                    ),
                                    onPressed: () {
                                      //print("hhhhhhhhhhhhh");
                                      if (_formKey.currentState!.validate()) {
                                        Get.find<ComplaintController>()
                                            .insertNewComplaints(
                                                complaintDetails.text,
                                                complaintSubject.text,
                                                selectedValue,
                                                selectedMainClassValue,
                                                selectedClassValue.value);
                                      }
                                    },
                                    child: Text(
                                      "send".tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        // height: 1.5,
                                        // color: Color(0xFF212529),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // ),
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

  Column _buildTop() {
    return Column(
      children: [
        Text(
          "Create Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "create a new account",
          style: TextStyle(
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      // bottomOpacity: 90,
      toolbarHeight: Get.size.height * 0.1,
      // titleSpacing: 40,
      // automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 199, 207, 189),

      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.15
                : Get.width * 0.15,
            child: Obx(
              () => FittedBox(
                fit: BoxFit.contain,
                child:
                    // NetworkImage(controller.logoSplash.value.toString()),
                    Image.network(
                  homeController.logoSite.value.toString(),
                  fit: BoxFit.contain,
                  // color: Colors.transparent,
                  // height: 60,
                ),
              ),
            ),
          ),
          // width: 100.0 * MediaQuery.of(context).devicPixelRatio ,
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.2
                : Get.width * 0.05,
          ),
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.40
                : Get.width * 0.53,
            // margin: const EdgeInsets.only(left: 70, right: 66),
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text("Complaints".tr,
                    style: TextStyle(
                        // fontSize: 22,
                        color: Color(0xFFAD1917),
                        fontWeight: FontWeight.w900))),
          ),
        ],
      ),

      actions: [
        IconButton(
          color: Color(0xFFAD1917),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_forward,
            size: 25,
          ),
        ),
        // BackButton()
      ],
    );
  }
}
