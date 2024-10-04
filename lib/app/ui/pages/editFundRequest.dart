import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neecoder/app/ui/pages/landingPage.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/landingPage_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../controllers/orders_controller.dart';
import '../../controllers/registration_controller.dart';
import '../../routes/app_routes.dart';

class EditFundRequestPage extends StatefulWidget {
  const EditFundRequestPage({Key? key}) : super(key: key);

  @override
  _EditFundRequestPageState createState() => _EditFundRequestPageState();
}

HomeController homeController = HomeController();

class _EditFundRequestPageState extends State<EditFundRequestPage> {
  final controller = Get.put(OrdersController());
  TextEditingController LoanPurpose = Get.find<OrdersController>().LoanPurpose;
  TextEditingController rerquestAmount =
      Get.find<OrdersController>().rerquestAmount;

  TextEditingController address = Get.find<OrdersController>().address;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RegistrationController registrationController =
      Get.find<RegistrationController>();
  var selectedPeriodTypeValue =
      Get.find<OrdersController>().selectedPeriodTypeValue;
  var selectedGarenteeTypeValue =
      Get.find<OrdersController>().selectedGarenteeTypeValue;
  var selectedOtherGarenteeValue =
      Get.find<OrdersController>().selectedOtherGarenteeValue;
  var selectedClassActivityValue =
      Get.find<OrdersController>().selectedClassActivityValue;

  var selectedProductValue = Get.find<OrdersController>().clientProduct;
  var selectedProductsPeriodValue =
      Get.find<OrdersController>().selectedProductsPeriodValue;
  var selectedActivityValue =
      Get.find<OrdersController>().selectedActivityValue;
  var clientGovernorate = Get.find<OrdersController>().clientGovernorate;
  var clientDirectorate = Get.find<OrdersController>().clientDirectorate;
  var clientArea = Get.find<OrdersController>().clientArea;
  var id = Get.arguments['id'];
  var status = Get.arguments['status'];
  LandingPageController landingBinding = Get.arguments['land'];
  @override
  Widget build(BuildContext context) {
    Get.put(OrdersController());
    print(rerquestAmount.text);
    print('rerquestAmount');
    registrationController.loadClientDirectorateFromApi(
        null, clientGovernorate.value);
    registrationController.loadClientAreaFromApi(null, clientDirectorate.value);
    registrationController.loadActivityFromApi(
        null, selectedClassActivityValue.value);
    registrationController.loadProductsPeriodFromApi(
        null, selectedProductValue.value);

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
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        'Request_data'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          height: 1.5,
                                          color: Color(0xFF212529),
                                        ),
                                      ),
                                    ),
                                    Container(),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(1, 0, 0, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(8, 0, 0, 4),
                                      child: Text(
                                        'Loan_purpose'.tr,
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
                                        controller: LoanPurpose,
                                        validator: (t) {
                                          if (t!.isEmpty) {
                                            return "Please_enter_your_Loan_purpose"
                                                .tr;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Loan_purpose'.tr,
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
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                                      child: Text(
                                        'Request_amount'.tr,
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
                                        controller: rerquestAmount,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.number,
                                        validator: (t) {
                                          if (t!.isEmpty) {
                                            return "Please_enter_your_Request_amount"
                                                .tr;
                                          }
                                          if (!GetUtils.isNumericOnly(t)) {
                                            return "isNumericOnly".tr;
                                          }
                                          if (!validEnglish(t)) {
                                            return "Please_enter_valid_text".tr;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Request_amount'.tr,
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
                                        'Product'.tr,
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
                                          items: registrationController
                                              .productsList
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
                                              return 'Please_select_choice'.tr;
                                            }
                                            return null;
                                          },
                                          value:
                                              selectedProductValue.value == ''
                                                  ? null
                                                  : selectedProductValue.value,
                                          onChanged: (value) {
                                            selectedProductValue.value =
                                                value.toString();
                                            registrationController
                                                .productsperiodList
                                                .clear();
                                            registrationController
                                                .loadProductsPeriodFromApi(null,
                                                    selectedProductValue.value);
                                            selectedProductsPeriodValue.value =
                                                '';
                                          },
                                          onSaved: (value) {
                                            selectedProductValue.value =
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
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(13, 0, 0, 8),
                                      child: Text(
                                        'Product_type'.tr,
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
                                          items: registrationController
                                              .periodTypeList
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
                                              return 'Please_select_choice'.tr;
                                            }
                                            return null;
                                          },
                                          value: selectedPeriodTypeValue
                                                      .value ==
                                                  ''
                                              ? null
                                              : selectedPeriodTypeValue.value,
                                          onChanged: (value) {
                                            selectedPeriodTypeValue.value =
                                                value.toString();
                                            //Do something when selected item is changed.
                                          },
                                          onSaved: (value) {
                                            selectedPeriodTypeValue.value =
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
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(13, 0, 0, 8),
                                      child: Text(
                                        'Request_period'.tr,
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
                                          items: registrationController
                                              .productsperiodList
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
                                              return 'Please_select_choice'.tr;
                                            }
                                            return null;
                                          },
                                          value: selectedProductsPeriodValue
                                                      .value ==
                                                  ''
                                              ? null
                                              : selectedProductsPeriodValue
                                                  .value,
                                          onChanged: (value) {
                                            selectedProductsPeriodValue.value =
                                                value.toString();
                                            //Do something when selected item is changed.
                                          },
                                          onSaved: (value) {
                                            selectedProductsPeriodValue.value =
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
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(7, 0, 0, 8),
                                      child: Text(
                                        'Grantee_type'.tr,
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
                                          items: registrationController
                                              .granteetypeList
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
                                              return 'Please_select_choice'.tr;
                                            }
                                            return null;
                                          },
                                          value: selectedGarenteeTypeValue
                                                      .value ==
                                                  ''
                                              ? null
                                              : selectedGarenteeTypeValue.value,
                                          onChanged: (value) {
                                            selectedGarenteeTypeValue.value =
                                                value.toString();
                                            //Do something when selected item is changed.
                                          },
                                          onSaved: (value) {
                                            selectedGarenteeTypeValue.value =
                                                value.toString();
                                          },
                                          buttonStyleData: const ButtonStyleData(
                                              // padding: EdgeInsets.only(right: 4),
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
                                                horizontal: 1),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(5, 0, 0, 8),
                                      child: Text(
                                        'Other_grantee_type'.tr,
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
                                          items: registrationController
                                              .granteetypeList
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
                                              return 'Please_select_choice'.tr;
                                            }
                                            return null;
                                          },
                                          value: selectedOtherGarenteeValue
                                                      .value ==
                                                  ''
                                              ? null
                                              : selectedOtherGarenteeValue
                                                  .value,
                                          onChanged: (value) {
                                            selectedOtherGarenteeValue.value =
                                                value.toString();
                                            //Do something when selected item is changed.
                                          },
                                          onSaved: (value) {
                                            selectedOtherGarenteeValue.value =
                                                value.toString();
                                          },
                                          buttonStyleData:
                                              const ButtonStyleData(
                                            padding: EdgeInsets.only(right: 3),
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
                                                horizontal: 0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: .2,
                                indent: 8,
                                endIndent: 8,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(1, 0, 0, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        'Activity_data'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          height: 1.5,
                                          color: Color(0xFF212529),
                                        ),
                                      ),
                                    ),
                                    Container(),
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
                                        'Activity_class'.tr,
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
                                          items: registrationController
                                              .activityClassList
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item['code_id']
                                                        .toString(),
                                                    child: Text(
                                                      item['classname']
                                                          .toString(),
                                                      style: const TextStyle(
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
                                          value: selectedClassActivityValue
                                                      .value ==
                                                  ''
                                              ? null
                                              : selectedClassActivityValue
                                                  .value,
                                          onChanged: (value) {
                                            selectedClassActivityValue.value =
                                                value.toString();
                                            registrationController.activityList
                                                .clear();

                                            registrationController
                                                .loadActivityFromApi(
                                                    null,
                                                    selectedClassActivityValue
                                                        .value);

                                            selectedActivityValue.value = '';
                                            //Do something when selected item is changed.
                                          },
                                          onSaved: (value) {
                                            selectedClassActivityValue.value =
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
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(13, 0, 0, 8),
                                      child: Text(
                                        'Activity'.tr,
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
                                          // value: 'lkp',
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
                                          items: registrationController
                                              .activityList
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item['CODE_ID']
                                                        .toString()
                                                    // '-' +
                                                    ,
                                                    child: Text(
                                                      item['activity_name']
                                                          .toString(),
                                                      style: const TextStyle(
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
                                          value:
                                              selectedActivityValue.value == ''
                                                  ? null
                                                  : selectedActivityValue.value,
                                          onChanged: (value) {
                                            selectedActivityValue.value =
                                                value.toString();
                                            //Do something when selected item is changed.
                                          },
                                          onSaved: (value) {
                                            selectedActivityValue.value =
                                                value.toString();
                                          },
                                          buttonStyleData: const ButtonStyleData(
                                              // padding: EdgeInsets.only(right: 4),
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
                                                horizontal: 4),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(13, 0, 0, 8),
                                      child: Text(
                                        'Business_governorate'.tr,
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
                                          items: registrationController
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
                                              return 'Please select choice.';
                                            }
                                            return null;
                                          },
                                          value: clientGovernorate.value == ''
                                              ? null
                                              : clientGovernorate.value,
                                          onChanged: (value) {
                                            clientGovernorate.value =
                                                value.toString();
                                            registrationController.citiesList
                                                .clear();
                                            registrationController
                                                .loadClientDirectorateFromApi(
                                                    null,
                                                    clientGovernorate.value);
                                            clientDirectorate.value = '';
                                            clientArea.value = '';
                                            //Do something when selected item is changed.
                                          },
                                          onSaved: (value) {
                                            clientGovernorate.value =
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
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(13, 0, 0, 8),
                                      child: Text(
                                        'Business_directorate'.tr,
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
                                          items: registrationController
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
                                              return 'Please select choice.';
                                            }
                                            return null;
                                          },
                                          value: clientDirectorate.value == ''
                                              ? null
                                              : clientDirectorate.value,
                                          onChanged: (value) {
                                            clientDirectorate.value =
                                                value.toString();
                                            registrationController.areasList
                                                .clear();
                                            registrationController
                                                .loadClientAreaFromApi(null,
                                                    clientDirectorate.value);
                                            clientArea.value = '';
                                            //Do something when selected item is changed.
                                          },
                                          onSaved: (value) {
                                            clientDirectorate.value =
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
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(13, 0, 0, 8),
                                      child: Text(
                                        'Business_area'.tr,
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
                                          items: registrationController
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
                                              return 'Please select choice.';
                                            }
                                            return null;
                                          },
                                          value: clientArea.value == ''
                                              ? null
                                              : clientArea.value,
                                          onChanged: (value) {
                                            clientArea.value = value.toString();
                                            //Do something when selected item is changed.
                                          },
                                          onSaved: (value) {
                                            clientArea.value = value.toString();
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
                                        'Activity_address'.tr,
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
                                        controller: address,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.text,
                                        validator: (t) {
                                          if (t!.isEmpty) {
                                            return "Please_enter_your_Activity_address"
                                                .tr;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Activity_address'.tr,
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
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFFFFFFF)),
                                  color: Color(0xFFAD1917),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 45,
                                  padding: EdgeInsets.fromLTRB(0.2, 0, 0, 0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFAD1917),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var res =
                                            await controller.updateFundRequest(
                                                id,
                                                LoanPurpose.text,
                                                rerquestAmount.text,
                                                address.text,
                                                selectedPeriodTypeValue.value,
                                                selectedGarenteeTypeValue.value,
                                                selectedOtherGarenteeValue
                                                    .value,
                                                selectedClassActivityValue
                                                    .value,
                                                clientGovernorate.value,
                                                clientDirectorate.value,
                                                clientArea.value,
                                                selectedProductValue.value,
                                                selectedProductsPeriodValue
                                                    .value,
                                                selectedActivityValue.value);

                                        if (res['errors'] != null) {
                                          Get.find<LandingPageController>()
                                              .dialogMS(
                                                  res['errors'].toString());
                                        } else if (res['status'] == false) {
                                          Get.find<LandingPageController>()
                                              .dialogMS(
                                                  res['message'].toString());
                                        } else {
                                          LandingPageController con =
                                              new LandingPageController();
                                          con.tabIndex.value = 4;
                                          // Get.toNamed(AppRoutes.landing);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                LandingPage(loans: con),
                                          ));
                                          Get.find<LandingPageController>()
                                              .dialogCheckMS(
                                                  AppRoutes.orderListPage,
                                                  false,
                                                  steps: null,
                                                  message:
                                                      res['data'].toString(),
                                                  obj: Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                    builder: (context) =>
                                                        LandingPage(loans: con),
                                                  )));
                                        }
                                      }
                                    },
                                    child: Text(
                                      "save".tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
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
                child:
                    // NetworkImage(controller.logoSplash.value.toString()),
                    Image.network(
                  homeController.logoSite.value.toString(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.2
                : Get.width * 0.07,
          ),
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.41
                : Get.width * 0.55,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text("Edit_Finance_Request".tr,
                    style: TextStyle(
                        // fontSize: 22,
                        color: Color(0xFFAD1917),
                        fontWeight: FontWeight.w900))),
          ),
        ],
      ),
      // centerTitle: true,
      actions: [
        Container(
          width: Get.size.width * 0.11,
          child: FittedBox(
            fit: BoxFit.contain,
            child: IconButton(
              color: Color.fromARGB(255, 146, 4, 47),
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_forward,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
