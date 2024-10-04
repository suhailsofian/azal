import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../controllers/loan_controller.dart';
import '../../routes/app_routes.dart';

class FundOrdersView extends StatefulWidget {
  @override
  _FundOrdersViewState createState() => _FundOrdersViewState();
}

HomeController homeController = HomeController();

class _FundOrdersViewState extends State<FundOrdersView> {
  @override
  Widget build(BuildContext context) {
    Get.put(LoanController());
    LoanController loanController = LoanController();
    final NumberFormat usCurrency = NumberFormat('#,##0', 'en_US');
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.grey[100],
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(205, 252, 255, 251),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () {
                    if (loanController.loadingLoan.value) {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Color(0xFFAD1917),
                          size: 80,
                        ),
                      );
                    }
                    if (loanController.allLoans.isEmpty) {
                      return Center(
                          child: Container(
                        width: Get.width * 0.50,
                        height: Get.height * 0.50,
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text("No_finance_found".tr,
                                style: TextStyle(fontWeight: FontWeight.w800))),
                      ));
                    }

                    return ListView.builder(
                      itemCount: loanController.allLoans.length,

                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.fromLTRB(10, 8.0, 10, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // if you need this
                          ),
                          elevation: 5.0,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.installmentsPage,
                                  arguments: {
                                    'id': loanController.allLoans[index]
                                                ['loan_id'] !=
                                            null
                                        ? loanController.allLoans[index]
                                                ['loan_id']
                                            .toString()
                                        : "",
                                    'title': loanController.allLoans[index]
                                                ['loan_purpose'] !=
                                            null
                                        ? loanController.allLoans[index]
                                            ['loan_purpose']
                                        : ""
                                  });
                            },
                            child: Container(
                              width: Get.width * 0.4,
                              height: Get.width * 0.66,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(8.0, 4.0, 15.0, 0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 4.0, 0, 0),
                                              child: Text(
                                                loanController.allLoans[index]
                                                            ['loan_purpose'] !=
                                                        null
                                                    ? loanController
                                                            .allLoans[index]
                                                        ['loan_purpose']
                                                    : "",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 146, 173, 118),
                                                  fontSize: Get.width * 0.06,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
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
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0.0, 0, 20.0, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    'Number_of_Installments'.tr,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFAD1917),
                                                        fontSize:
                                                            Get.width * 0.043,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    loanController
                                                        .allLoans[index][
                                                            'number_of_installments']
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          Get.width * 0.043,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0.0, 0, 20.0, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    'Financing_Amount'.tr,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFAD1917),
                                                        fontSize:
                                                            Get.width * 0.043,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    usCurrency.format(int.parse(
                                                        loanController
                                                            .allLoans[index][
                                                                'funding_amount']
                                                            .toString())),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          Get.width * 0.043,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0.0, 0, 20.0, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    'Balance'.tr,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFAD1917),
                                                        fontSize:
                                                            Get.width * 0.043,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    usCurrency.format(int.parse(
                                                        loanController
                                                            .allLoans[index]
                                                                ['balance']
                                                            .toString())),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          Get.width * 0.043,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: .2,
                                    indent: 8,
                                    endIndent: 8,
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          13.0, 0, 18.0, 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Date_Loan'.tr,
                                            style: TextStyle(
                                                color: Color(0xFFAD1917),
                                                fontSize: Get.width * 0.043,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          GestureDetector(
                                            onTap: null,
                                            child: Container(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    DateFormat("yyyy-MM-dd")
                                                        .format(DateTime.parse(
                                                            loanController
                                                                .allLoans[index]
                                                                    [
                                                                    'funding_date']
                                                                .toString())),
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 46, 45, 45),
                                                        fontSize:
                                                            Get.width * 0.043,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
            () => Image.network(
              homeController.logoSite.value.toString(),
              fit: BoxFit.contain,
            ),
            // ),
          ),
        ),
        Container(
          width: Get.find<LanguageController>().savedLang.value == 'AR'
              ? Get.width * 0.2
              : Get.width * 0.2,
        ),
        Container(
          width: Get.find<LanguageController>().savedLang.value == 'AR'
              ? Get.width * 0.27
              : Get.width * 0.22,
          child: FittedBox(
              fit: BoxFit.contain,
              child: Text("myFinance".tr,
                  style: TextStyle(
                      // fontSize: 22,
                      color: Color(0xFFAD1917),
                      fontWeight: FontWeight.w900))),
        ),
      ],
    ),
  );
}
