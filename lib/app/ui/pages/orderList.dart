import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/landingPage_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../controllers/orders_controller.dart';
import '../../routes/app_routes.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key, required this.loans}) : super(key: key);
  final LandingPageController loans;
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

HomeController homeController = HomeController();

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    OrdersController ordersController = OrdersController();
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: Obx(
          () {
            if (ordersController.loading.value) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Color(0xFFAD1917),
                  size: 80,
                ),
              );
            }
            if (ordersController.allFunding.isEmpty) {
              return Center(
                  child: Container(
                width: Get.width * 0.50,
                height: Get.height * 0.50,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text("No_Orders_found".tr,
                        style: TextStyle(fontWeight: FontWeight.w600))),
              ));
            }

            return ListView.builder(
                padding: EdgeInsets.all(13),
                itemCount: ordersController.allFunding.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: jobComponent(
                        ordersController.allFunding[index]['loan_purpose'] !=
                                null
                            ? ordersController.allFunding[index]['loan_purpose']
                            : "",
                        ordersController.allFunding[index]['loan_date'] != null
                            ? ordersController.allFunding[index]['loan_date']
                            : "",
                        ordersController.allFunding[index]['id'] != null
                            ? ordersController.allFunding[index]['id']
                            : "",
                        ordersController.allFunding[index]['app_status'] != null
                            ? ordersController.allFunding[index]['app_status']
                            : [],
                        ordersController.allFunding[index]['request_amount'] !=
                                null
                            ? ordersController.allFunding[index]
                                ['request_amount']
                            : "",
                        ordersController.allFunding[index]
                                    ['application_source'] !=
                                null
                            ? ordersController.allFunding[index]
                                ['application_source']
                            : []),
                  );
                });
          },
        ),
      ),
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
        // crossAxisAlignment: CrossAxisAlignment.start,
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
                : Get.width * 0.1,
          ),
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.38
                : Get.width * 0.48,
            height: Get.size.height * 0.32,
            // margin: const EdgeInsets.only(left: 70, right: 66),
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text("orderList".tr,
                    style: TextStyle(
                        // fontSize: 30,
                        color: Color(0xFFAD1917),
                        fontWeight: FontWeight.w900))),
          ),
        ],
      ),
    );
  }

  jobComponent(loanPurpose, date, id, status, request, List appSource) {
    final NumberFormat usCurrency = NumberFormat('#,##0', 'en_US');

    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // if you need this
      ),
      elevation: 5.0,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 0,
                    blurRadius: 3,
                    // offset: Offset(0, 1),
                  ),
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(children: [
                        SizedBox(width: 2),
                        Flexible(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Loan_purpose".tr + ":",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: Get.width * 0.04),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          loanPurpose,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: Get.width * 0.04),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Request_amount".tr + " : ",
                                        // "Request_period".tr + " :",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Get.width * 0.04,
                                        ),
                                      ),
                                      Text(
                                        usCurrency.format(
                                            int.parse(request.toString())),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Get.width * 0.04,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        )
                      ]),
                    ),
                    if (!appSource.isEmpty &&
                        appSource[0]['CODE_ID'].toString() != '1')
                      if (status[0]['CODE_ID'].toString() == '0')
                        FloatingActionButton(
                          mini: true,
                          backgroundColor: Color(0xFFAD1917),
                          onPressed: (() async => {
                                await Get.find<OrdersController>()
                                    .viewfundingRequestIdFromApi(id),
                                Get.toNamed(AppRoutes.editfundRequestPage,
                                    arguments: {
                                      'id': id,
                                      'status': status[0]['CODE_ID'].toString(),
                                      'land': widget.loans
                                    }),
                              }),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          tooltip: 'Increment',
                          child: const Icon(FontAwesomeIcons.edit),
                        ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              // color: Colors.grey.shade200
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Date_Request_loan".tr + " : ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Get.width * 0.04,
                                    // fontWeight: FontWeight.w800
                                  ),
                                ),
                                Text(
                                  date,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Get.width * 0.04,
                                    // fontWeight: FontWeight.w800
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (!appSource.isEmpty &&
                          appSource[0]['CODE_ID'].toString() != '1')
                        if (status[0]['CODE_ID'].toString() == '0')
                          FloatingActionButton(
                            heroTag: "btn$id",
                            mini: true,
                            backgroundColor: Color(0xFFAD1917),
                            onPressed: (() => {
                                  Get.toNamed(AppRoutes.summaryPage,
                                      arguments: {
                                        'id': id,
                                        'status':
                                            status[0]['CODE_ID'].toString(),
                                        'land': widget.loans
                                      })
                                }),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            tooltip: 'Increment',
                            child: const Icon(FontAwesomeIcons.check),
                          ),
                      if (!appSource.isEmpty &&
                          appSource[0]['CODE_ID'].toString() != '1')
                        if (status[0]['CODE_ID'].toString() != '0')
                          FloatingActionButton(
                            heroTag: "btn$id",
                            mini: true,
                            backgroundColor: Color(0xFFAD1917),
                            onPressed: (() => {
                                  Get.toNamed(AppRoutes.summaryPage,
                                      arguments: {
                                        'id': id,
                                        'status':
                                            status[0]['CODE_ID'].toString(),
                                        'land': widget.loans
                                      }),
                                  setState(() {})
                                }),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            tooltip: 'Increment',
                            child: const Icon(FontAwesomeIcons.eye),
                          ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // color: Colors.grey.shade200
                  ),
                  child: Row(
                    children: [
                      Text(
                        "appSource".tr + " : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Get.width * 0.04,
                          // fontWeight: FontWeight.w800
                        ),
                      ),
                      appSource.isEmpty
                          ? Container()
                          : Text(
                              appSource[0]['name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width * 0.04,
                                // fontWeight: FontWeight.w800
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // if (appSource[0]['CODE_ID'].toString() != '1')
          if (status[0]['CODE_ID'].toString() == '0')
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Color.fromARGB(255, 123, 125, 122),
              ),
              child: Text(
                status[0]['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Get.width * 0.04,
                  // fontWeight: FontWeight.w800
                ),
              ),
            ),
          // if (appSource[0]['CODE_ID'].toString() != '1')
          if (status[0]['CODE_ID'].toString() != '0')
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Color.fromARGB(255, 146, 173, 118),
              ),
              child: Text(
                status[0]['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Get.width * 0.04,
                  // fontWeight: FontWeight.w800
                ),
              ),
            ),
        ],
      ),
    );
  }
}
