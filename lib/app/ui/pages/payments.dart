import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../controllers/loan_controller.dart';

class PaymentsView extends StatefulWidget {
  @override
  _PaymentsViewState createState() => _PaymentsViewState();
}

HomeController homeController = HomeController();

class _PaymentsViewState extends State<PaymentsView> {
  var loanId = Get.arguments['loanId'];
  var installmentId = Get.arguments['installmentId'];
  var title = Get.arguments['title'];
  @override
  Widget build(BuildContext context) {
    Get.put(() => LoanController());
    Get.find<LoanController>().loadBondsReviewFromApi(loanId, installmentId);
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.grey[100],
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(222, 244, 246, 243),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              _buildTop(installmentId.toString(), title),
              Expanded(
                child: Obx(
                  () {
                    if (Get.find<LoanController>().loadingPay.value) {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Color(0xFFAD1917),
                          size: 80,
                        ),
                      );
                    }
                    if (Get.find<LoanController>().allBonds.isEmpty) {
                      return Center(
                          child: Container(
                        width: Get.width * 0.44,
                        height: Get.height * 0.44,
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text("No_Payments_found".tr,
                                style: TextStyle(
                                    // fontSize: 22,
                                    // color: Color.fromARGB(255, 146, 4, 47),
                                    fontWeight: FontWeight.w600))),
                      ));
                    }
                    // OverlayLoadingProgress.stop();
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
        //     ),
        //   ],
        // ),
      ),
    );
  }

  ListView _buildProductsList() {
    final NumberFormat usCurrency = NumberFormat('#,##0', 'en_US');
    return ListView.builder(
      itemCount: Get.find<LoanController>().allBonds.length,
      // padding: EdgeInsets.only(top: 1),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.fromLTRB(10, 8.0, 10, 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // if you need this
          ),
          elevation: 5.0,
          child: Container(
            height: Get.width * 0.55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0, 20.0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Bond_No'.tr,
                                  style: TextStyle(
                                      color: Color(0xFFAD1917),
                                      fontSize: Get.width * 0.043),
                                ),
                                Text(
                                  Get.find<LoanController>()
                                      .allBonds[index]['bond_id']
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
                        Divider(
                          color: Colors.black,
                          thickness: .2,
                          indent: 1,
                          endIndent: 8,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0, 20.0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Finance'.tr,
                                  style: TextStyle(
                                      color: Color(0xFFAD1917),
                                      fontSize: Get.width * 0.043),
                                ),
                                Text(
                                  Get.find<LoanController>()
                                      .allBonds[index]['loan_id']
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
                          height: 10,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0, 20.0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Bond_Amount'.tr,
                                  style: TextStyle(
                                      color: Color(0xFFAD1917),
                                      fontSize: Get.width * 0.043),
                                ),
                                Text(
                                  usCurrency.format(int.parse(
                                      Get.find<LoanController>()
                                          .allBonds[index]['bond_amount']
                                          .toString())),
                                  // Get.find<LoanController>()
                                  //     .allBonds[index]['bond_amount']
                                  //     .toString(),
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
                          'Date'.tr,
                          style: TextStyle(
                              color: Color(0xFFAD1917),
                              fontSize: Get.width * 0.043),
                        ),
                        GestureDetector(
                          onTap: null,
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  DateFormat("yyyy-MM-dd").format(
                                      DateTime.parse(Get.find<LoanController>()
                                          .allBonds[index]['bond_date']
                                          .toString())),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 46, 45, 45),
                                      fontWeight: FontWeight.w600,
                                      fontSize: Get.width * 0.043),
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
    );
  }

  Row _buildTop(title, titles) {
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
                  "Loan_purpose".tr +
                      " : " +
                      titles +
                      " - " +
                      "Instiluments_No".tr +
                      " : " +
                      title,
                  style: TextStyle(
                      color: Color(0xFFAD1917),
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.043),
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
      // bottomOpacity: 90,
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
                ? Get.width * 0.27
                : Get.width * 0.33,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text("Payments".tr,
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
              color: Color(0xFFAD1917),
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
