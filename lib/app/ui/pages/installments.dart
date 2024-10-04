import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../controllers/loan_controller.dart';
import '../../routes/app_routes.dart';

class InstallmentsView extends StatefulWidget {
  @override
  _InstallmentsViewState createState() => _InstallmentsViewState();
}

HomeController homeController = HomeController();

class _InstallmentsViewState extends State<InstallmentsView> {
  var id = Get.arguments['id'];
  var title = Get.arguments['title'];
  @override
  Widget build(BuildContext context) {
    Get.find<LoanController>().loadInstallmentsReviewFromApi(id);
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.grey[100],
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(242, 245, 248, 244),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              _buildTop(title),
              Expanded(
                child: Obx(
                  () {
                    if (Get.find<LoanController>().loadingIns.value) {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Color(0xFFAD1917),
                          size: 80,
                        ),
                      );
                    }
                    if (Get.find<LoanController>().allinstallments.isEmpty) {
                      return Center(
                          child: Container(
                        width: Get.width * 0.44,
                        height: Get.height * 0.44,
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text("No_Installments_found".tr,
                                style: TextStyle(fontWeight: FontWeight.w600))),
                      ));
                    }

                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _buildProductsList(),
                      ),
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

  ListView _buildProductsList() {
    final NumberFormat usCurrency = NumberFormat('#,##0', 'en_US');
    return ListView.builder(
      itemCount: Get.find<LoanController>().allinstallments.length,
      // padding: EdgeInsets.only(top: 3),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.fromLTRB(5, 8.0, 5, 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // if you need this
          ),
          elevation: 4.0,
          child: InkWell(
            onTap: () {
              // Get.toNamed(AppRoutes.paymentPage);
              Get.toNamed(AppRoutes.paymentPage, arguments: {
                'loanId': Get.find<LoanController>()
                    .allinstallments[index]['loan_id']
                    .toString(),
                'installmentId': Get.find<LoanController>()
                    .allinstallments[index]['installment_id'],
                'title': title
              });
            },
            child: Container(
              // width: 400,
              height: Get.width * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 0, 20.0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Instiluments_No'.tr,
                                    style: TextStyle(
                                      color: Color(0xFFAD1917),
                                      fontSize: Get.width * 0.043,
                                    ),
                                  ),
                                  Text(
                                    Get.find<LoanController>()
                                        .allinstallments[index]
                                            ['installment_id']
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Get.width * 0.043,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: .2,
                            indent: 1,
                            endIndent: 8,
                          ),
                          Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 0, 20.0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Entitlement_Amount'.tr,
                                    style: TextStyle(
                                      color: Color(0xFFAD1917),
                                      fontSize: Get.width * 0.043,
                                    ),
                                  ),
                                  Text(
                                    usCurrency.format(int.parse(
                                        Get.find<LoanController>()
                                            .allinstallments[index]
                                                ['installment_amount']
                                            .toString())),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Get.width * 0.043,
                                      fontWeight: FontWeight.w600,
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
                                  const EdgeInsets.fromLTRB(0.0, 0, 20.0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Amount_Paid'.tr,
                                    style: TextStyle(
                                      color: Color(0xFFAD1917),
                                      fontSize: Get.width * 0.043,
                                    ),
                                  ),
                                  Text(
                                    usCurrency.format(int.parse(
                                        Get.find<LoanController>()
                                            .allinstallments[index]
                                                ['paid_amount']
                                            .toString())),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Get.width * 0.043,
                                      fontWeight: FontWeight.w600,
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
                                  const EdgeInsets.fromLTRB(0.0, 0, 20.0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Remaining_Amount'.tr,
                                    style: TextStyle(
                                      color: Color(0xFFAD1917),
                                      fontSize: Get.width * 0.043,
                                    ),
                                  ),
                                  Text(
                                    usCurrency.format(int.parse(
                                        Get.find<LoanController>()
                                            .allinstallments[index]
                                                ['remaining_insta_amount']
                                            .toString())),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Get.width * 0.043,
                                      fontWeight: FontWeight.w600,
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
                      padding: const EdgeInsets.fromLTRB(13.0, 0, 18.0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Date_Installment'.tr,
                            style: TextStyle(
                              color: Color(0xFFAD1917),
                              fontSize: Get.width * 0.043,
                            ),
                          ),
                          GestureDetector(
                            onTap: null,
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    DateFormat("yyyy-MM-dd").format(
                                        DateTime.parse(
                                            Get.find<LoanController>()
                                                .allinstallments[index]
                                                    ['due_date']
                                                .toString())),
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 46, 45, 45),
                                      fontWeight: FontWeight.w600,
                                      fontSize: Get.width * 0.043,
                                    ),
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
    );
    //       ],
  }

  Row _buildTop(title) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // if you need this
            ),
            elevation: 4.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), // if you need this
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Loan_purpose'.tr + ":" + title,
                  style: TextStyle(
                      color: Color(0xFFAD1917),
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.045),
                ),
              ),
              //   ],
              // ),
            ),
          ),
        ),
      ],
    );
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
                : Get.width * 0.2,
          ),
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.21
                : Get.width * 0.36,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text("Installments".tr,
                    style: TextStyle(
                        // fontSize: 22,
                        color: Color(0xFFAD1917),
                        fontWeight: FontWeight.w900))),
          ),
        ],
      ),
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
