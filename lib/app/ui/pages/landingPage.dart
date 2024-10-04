import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neecoder/app/controllers/languages_controller.dart';
import 'package:neecoder/app/ui/pages/dash.dart';
import 'package:neecoder/app/ui/pages/fundOrders.dart';
import 'package:neecoder/app/ui/pages/fundRequest.dart';
import 'package:neecoder/app/ui/pages/orderList.dart';
import 'package:neecoder/app/ui/pages/products.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import '../../controllers/landingPage_controller.dart';
import '../../controllers/orders_controller.dart';
import '../../controllers/registration_controller.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key, required this.loans}) : super(key: key);
  final LandingPageController loans;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => Container(
          height: Get.height * 0.15,
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: Get.height * 0.95,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                child: BottomNavigationBar(
                  // unselectedFontSize: ,
                  selectedFontSize:
                      Get.find<LanguageController>().savedLang.value == 'AR'
                          ? Get.width * 0.029
                          : Get.width * 0.03,
                  unselectedFontSize:
                      Get.find<LanguageController>().savedLang.value == 'AR'
                          ? Get.width * 0.029
                          : Get.width * 0.03,
                  showUnselectedLabels: true,
                  iconSize: Get.width * 0.10,
                  onTap: landingPageController.changeTabIndex,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  unselectedItemColor: Color(0xFF92AD76),

                  selectedItemColor: Color(0xFFAD1917),
                  currentIndex: landingPageController.tabIndex.value,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.space_dashboard_outlined),
                      label: 'home'.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.pix,
                      ),
                      label: 'Products'.tr,
                    ),
                    BottomNavigationBarItem(
                      activeIcon: null,
                      icon: Icon(null),
                      // : Text(title'Search'),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.fact_check,
                      ),
                      label: 'myFinance'.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.pending_actions),
                      label: ' ' + 'orderListTab'.tr,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    LandingPageController landingController = LandingPageController();
    if (widget.loans != Null) {
      landingController = widget.loans;
    }

    Widget _buildNavigator(int index, Widget child) {
      return Navigator(
        key: landingController.navigatorKeys[index],
        reportsRouteUpdateToEngine: true,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => child,
          );
        },
      );
    }

    return WillPopScope(
        onWillPop: landingController.onWillPop, // Handle back button
        child: SafeArea(child: Obx(() {
          // bool checkToken = Get.find<LandingPageController>().isTokenExpired();
          // if (!checkToken) {
          if (landingController.loadings.value) {
            OverlayLoadingProgress.start(context,
                widget: Container(
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Color.fromARGB(255, 248, 247, 247),
                      size: 90,
                    ),
                  ),
                ),
                // gifOrImagePath: 'assets/load5.gif',
                barrierDismissible: false,
                loadingWidth: Get.width * 0.9);

            return Scaffold(
              bottomNavigationBar:
                  buildBottomNavigationMenu(context, landingController),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                child: Container(
                  width: Get.width * 0.17,
                  height: Get.height * 0.17,
                  child: FloatingActionButton(
                    hoverElevation: 10,
                    focusColor: Color(0xFFAD1917),
                    backgroundColor: Color(0xFF92AD76),
                    hoverColor: Color(0xFFAD1917),
                    elevation: 4,
                    child: Icon(Icons.add),
                    onPressed: () async {
                      bool checkToken = landingController.isTokenExpired();
                      if (!checkToken) {
                        bool check = await Get.find<OrdersController>()
                            .checkAddNewRequest();
                        if (check) {
                          Get.find<OrdersController>().userOrdersItems.clear();
                          Get.find<RegistrationController>()
                              .clientGovernorate2
                              .value = '';

                          Get.find<RegistrationController>()
                              .clientDirectorate2
                              .value = '';
                          Get.find<RegistrationController>().clientArea2.value =
                              '';
                          Get.find<RegistrationController>()
                              .selectedPeriodTypeValue
                              .value = '';
                          Get.find<RegistrationController>()
                              .selectedProductsPeriodValue
                              .value = '';
                          Get.find<RegistrationController>()
                              .selectedActivityValue
                              .value = '';

                          landingController.tabIndex.value = 2;
                          landingController.pageOneKey.value = UniqueKey();
                        }
                      }
                    },
                  ),
                ),
              ),
              body: IndexedStack(
                index: landingController.tabIndex.value,
                children: [
                  DashScreen(loans: landingController),
                  ProductsView(),
                  FundRequestPage(loans: landingController),
                  FundOrdersView(),
                  OrderListPage(loans: landingController),
                ],
              ),
            );
          } else {
            return Obx(() => WillPopScope(
                onWillPop: landingController.onWillPop, // Handle back button
                child: Scaffold(
                  bottomNavigationBar:
                      buildBottomNavigationMenu(context, landingController),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                    child: Container(
                      width: Get.width * 0.17,
                      height: Get.height * 0.17,
                      child: FloatingActionButton(
                        hoverElevation: 10,
                        focusColor: Color(0xFFAD1917),
                        backgroundColor: Color(0xFF92AD76),
                        hoverColor: Color(0xFFAD1917),
                        elevation: 4,
                        child: Icon(Icons.add),
                        onPressed: () async {
                          bool checkToken = landingController.isTokenExpired();
                          if (!checkToken) {
                            bool check = await Get.find<OrdersController>()
                                .checkAddNewRequest();
                            if (check) {
                              Get.find<OrdersController>()
                                  .userOrdersItems
                                  .clear();
                              Get.find<RegistrationController>()
                                  .clientGovernorate2
                                  .value = '';
                              Get.find<RegistrationController>()
                                  .clientDirectorate2
                                  .value = '';
                              Get.find<RegistrationController>()
                                  .clientArea2
                                  .value = '';
                              Get.find<RegistrationController>()
                                  .selectedPeriodTypeValue
                                  .value = '';
                              Get.find<RegistrationController>()
                                  .selectedProductsPeriodValue
                                  .value = '';
                              Get.find<RegistrationController>()
                                  .selectedActivityValue
                                  .value = '';

                              landingController.tabIndex.value = 2;
                              landingController.pageOneKey.value = UniqueKey();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  body: IndexedStack(
                    index: landingController.tabIndex.value,
                    children: [
                      DashScreen(loans: landingController),
                      _buildNavigator(1, ProductsView()),
                      FundRequestPage(
                          key: landingController.pageOneKey.value,
                          loans: landingController),
                      _buildNavigator(3, FundOrdersView()),
                      OrderListPage(loans: landingController),
                    ],
                  ),
                )));
          }
        })));
  }
}
