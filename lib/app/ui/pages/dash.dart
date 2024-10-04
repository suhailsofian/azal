import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/landingPage_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../routes/app_routes.dart';
import 'package:neecoder/app/ui/widgets/helper_widgets.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({Key? key, required this.loans});

  final LandingPageController loans;
  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
// class DashScreen extends StatefulWidget {
  HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    var _mediaQuary = MediaQuery.of(context);
    return Obx(
      () {
        if (widget.loans.loadings.value) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: _mediaQuary.size.height * 0.1,
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 188, 199, 174),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width:
                        Get.find<LanguageController>().savedLang.value == 'AR'
                            ? Get.width * 0.15
                            : Get.width * 0.15,
                    child: Obx(
                      () => Image.network(
                        controller.logoSite.value.toString(),
                        fit: BoxFit.contain,
                      ),
                      // ),
                    ),
                  ),
                  Container(
                    width:
                        Get.find<LanguageController>().savedLang.value == 'AR'
                            ? Get.width * 0.2
                            : Get.width * 0.2,
                  ),
                ],
              ),
              actions: [
                const SizedBox(width: 20.0),
                Container(
                  width: Get.width * 0.08,

                  child: IconButton(
                    color: Color(0xFFAD1917),
                    onPressed: () {
                      bool checkToken = widget.loans.isTokenExpired();
                      if (!checkToken) {
                        Get.toNamed(AppRoutes.locationPage);
                      }
                    },
                    icon: Icon(
                      Icons.location_on_sharp,
                      size: Get.width * 0.08,
                    ),
                  ),
                  // ),
                ),
                const SizedBox(width: 20.0),
                Container(
                  width: Get.width * 0.08,

                  child: IconButton(
                    color: Color(0xFFAD1917),
                    onPressed: () async {
                      bool checkToken = widget.loans.isTokenExpired();
                      if (!checkToken) {
                        await Get.find<AuthController>()
                            .viewUserProfileFromApi(null);
                        Get.toNamed(AppRoutes.registrationDetails);
                      }
                    },
                    icon: Icon(
                      CupertinoIcons.person_circle_fill,
                      size: Get.width * 0.08,
                    ),
                  ),
                  // ),
                ),
                const SizedBox(width: 20.0),
                Container(
                  width: _mediaQuary.size.width * 0.08,

                  child: IconButton(
                    color: Color(0xFFAD1917),
                    onPressed: () {
                      bool checkToken = widget.loans.isTokenExpired();
                      if (!checkToken) {
                        Get.toNamed(AppRoutes.profile);
                      }
                    },
                    icon: Icon(
                      Icons.settings_rounded,
                      size: Get.width * 0.08,
                    ),
                  ),
                  // ),
                ),
                const SizedBox(width: 20.0)
              ],
            ),
            body: Container(
              color: Color(0x218BAB7F),
              child: ListView(
                padding: EdgeInsets.only(bottom: 0, top: 0),
                children: [
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(210, 174, 189, 157),
                      borderRadius: new BorderRadius.only(
                        bottomRight: const Radius.circular(70.0),
                        bottomLeft: const Radius.circular(70.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 18.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: Get.width * 0.10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topRight: const Radius.circular(20.0),
                                  topLeft: const Radius.circular(20.0),
                                  bottomRight: const Radius.circular(20.0),
                                  bottomLeft: const Radius.circular(20.0),
                                ),
                              ),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: IconButton(
                                  color: Color.fromARGB(255, 242, 242, 242),
                                  onPressed: () => _launchURLInBrowser(
                                      Uri.parse(controller.facebook.value
                                          .toString())),
                                  icon: Icon(FontAwesomeIcons.facebook,
                                      color: Color.fromARGB(255, 15, 19, 236),
                                      size: Get.find<LanguageController>()
                                                  .savedLang
                                                  .value ==
                                              'AR'
                                          ? Get.width * 0.07
                                          : Get.width * 0.07),
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width * 0.10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topRight: const Radius.circular(20.0),
                                  topLeft: const Radius.circular(20.0),
                                  bottomRight: const Radius.circular(20.0),
                                  bottomLeft: const Radius.circular(20.0),
                                ), //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 2, //spread radius
                                    blurRadius: 2, // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: IconButton(
                                  color: Color.fromARGB(255, 242, 242, 242),
                                  onPressed: () => _launchURLInBrowser(
                                      Uri.parse("tel:" +
                                          (controller.hotline.value)
                                              .toString())),
                                  icon: Icon(FontAwesomeIcons.phone,
                                      color: Colors.blue,
                                      size: Get.find<LanguageController>()
                                                  .savedLang
                                                  .value ==
                                              'AR'
                                          ? Get.width * 0.07
                                          : Get.width * 0.07),
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width * 0.10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topRight: const Radius.circular(20.0),
                                  topLeft: const Radius.circular(20.0),
                                  bottomRight: const Radius.circular(20.0),
                                  bottomLeft: const Radius.circular(20.0),
                                ), //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 2, //spread radius
                                    blurRadius: 2, // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: IconButton(
                                  color: Color.fromARGB(255, 242, 242, 242),
                                  onPressed: () => _launchURLInBrowser(Uri.parse(
                                      "https://api.whatsapp.com/send/?phone=" +
                                          (controller.whatsapp.value)
                                              .toString() +
                                          "&text=مرحبا بكم")),
                                  icon: Icon(FontAwesomeIcons.whatsapp,
                                      color: Color.fromARGB(255, 3, 164, 54),
                                      size: Get.find<LanguageController>()
                                                  .savedLang
                                                  .value ==
                                              'AR'
                                          ? Get.width * 0.07
                                          : Get.width * 0.07),
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width * 0.10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topRight: const Radius.circular(20.0),
                                  topLeft: const Radius.circular(20.0),
                                  bottomRight: const Radius.circular(20.0),
                                  bottomLeft: const Radius.circular(20.0),
                                ), //border corner radius
                              ),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: IconButton(
                                  color: Color.fromARGB(255, 242, 242, 242),
                                  onPressed: () => _launchURLInBrowser(
                                      Uri.parse((controller.website.value)
                                          .toString())),
                                  icon: Icon(FontAwesomeIcons.globe,
                                      color: Color.fromARGB(255, 191, 106, 100),
                                      size: Get.find<LanguageController>()
                                                  .savedLang
                                                  .value ==
                                              'AR'
                                          ? Get.width * 0.07
                                          : Get.width * 0.07),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                    // ),
                  ),
                  SizedBox(height: Get.height * 0.15),
                  Container(
                    color: Color.fromARGB(197, 236, 245, 233),

                    width: Get.width,
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.04,
                            top: 0,
                            right: Get.width * 0.04),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => gridWeatherBuilder2(
                                      widget.loans.allapplication.toString(),
                                      'Customers',
                                      Icons.check,
                                      Get.height,
                                      Get.width,
                                      widget.loans,
                                      3),
                                ),
                                Obx(
                                  () => gridWeatherBuilder2(
                                      widget.loans.totalBalance.toString(),
                                      'totalBalance',
                                      Icons.check,
                                      Get.height,
                                      Get.width,
                                      widget.loans,
                                      4),
                                ),
                              ],
                            ),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => gridWeatherBuilder2(
                                      widget.loans.approvalappliaction
                                          .toString(),
                                      'loans_granted',
                                      Icons.check,
                                      Get.height,
                                      Get.width,
                                      widget.loans,
                                      3),
                                ),
                                Obx(
                                  () => gridWeatherBuilder2(
                                      widget.loans.suspendedapplication
                                          .toString(),
                                      'pending_orders',
                                      Icons.check,
                                      Get.height,
                                      Get.width,
                                      widget.loans,
                                      4),
                                ),
                              ],
                            ),
                          ],
                        )),
                    // ),
                  ),
                ],
              ),
            ),
          );
        } else {
          OverlayLoadingProgress.stop();
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              // bottomOpacity: 90,
              toolbarHeight: _mediaQuary.size.height * 0.1,

              elevation: 0,

              backgroundColor: Color.fromARGB(255, 199, 207, 189),

              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width:
                        Get.find<LanguageController>().savedLang.value == 'AR'
                            ? Get.width * 0.15
                            : Get.width * 0.15,
                    child: Obx(
                      () => Image.network(
                        controller.logoSite.value.toString(),
                        fit: BoxFit.contain,
                      ),
                      // ),
                    ),
                  ),
                  Container(
                    width:
                        Get.find<LanguageController>().savedLang.value == 'AR'
                            ? Get.width * 0.2
                            : Get.width * 0.2,
                  ),
                ],
              ),
              // centerTitle: true,
              actions: [
                const SizedBox(width: 20.0),
                Container(
                  width: _mediaQuary.size.width * 0.08,

                  child: IconButton(
                    color: Color(0xFFAD1917),
                    onPressed: () {
                      bool checkToken = widget.loans.isTokenExpired();
                      if (!checkToken) {
                        Get.toNamed(AppRoutes.locationPage);
                      }
                    },
                    icon: Icon(
                      Icons.location_on_sharp,
                      size: Get.width * 0.08,
                    ),
                  ),
                  // ),
                ),
                const SizedBox(width: 20.0),
                Container(
                  width: _mediaQuary.size.width * 0.08,
                  child: IconButton(
                    color: Color(0xFFAD1917),
                    onPressed: () async {
                      bool checkToken = widget.loans.isTokenExpired();
                      if (!checkToken) {
                        await Get.find<AuthController>()
                            .viewUserProfileFromApi(null);
                        Get.toNamed(AppRoutes.registrationDetails);
                      }
                    },
                    icon: Icon(
                      CupertinoIcons.person_circle_fill,
                      size: Get.width * 0.08,
                    ),
                  ),
                  // ),
                ),
                const SizedBox(width: 20.0),
                Container(
                  width: _mediaQuary.size.width * 0.08,

                  child: IconButton(
                    color: Color(0xFFAD1917),
                    onPressed: () {
                      bool checkToken = widget.loans.isTokenExpired();
                      if (!checkToken) {
                        Get.toNamed(AppRoutes.profile);
                      }
                    },
                    icon: Icon(
                      Icons.settings_rounded,
                      size: Get.width * 0.08,
                    ),
                  ),
                  // ),
                ),
                const SizedBox(width: 20.0)
              ],
            ),
            body: Container(
              color: Color(0x218BAB7F),
              child: ListView(
                padding: EdgeInsets.only(bottom: 0, top: 0),
                children: [
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(199, 188, 199, 180),
                      borderRadius: new BorderRadius.only(
                        bottomRight: const Radius.circular(70.0),
                        bottomLeft: const Radius.circular(70.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 18.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: Get.width * 0.10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topRight: const Radius.circular(20.0),
                                  topLeft: const Radius.circular(20.0),
                                  bottomRight: const Radius.circular(20.0),
                                  bottomLeft: const Radius.circular(20.0),
                                ),
                              ),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: IconButton(
                                  color: Color.fromARGB(255, 242, 242, 242),
                                  onPressed: () => _launchURLInBrowser(
                                      Uri.parse(controller.facebook.value
                                          .toString())),
                                  icon: Icon(FontAwesomeIcons.facebook,
                                      color: Color.fromARGB(255, 15, 19, 236),
                                      size: Get.find<LanguageController>()
                                                  .savedLang
                                                  .value ==
                                              'AR'
                                          ? Get.width * 0.07
                                          : Get.width * 0.07),
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width * 0.10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topRight: const Radius.circular(20.0),
                                  topLeft: const Radius.circular(20.0),
                                  bottomRight: const Radius.circular(20.0),
                                  bottomLeft: const Radius.circular(20.0),
                                ), //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 2, //spread radius
                                    blurRadius: 2, // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: IconButton(
                                  color: Color.fromARGB(255, 242, 242, 242),
                                  onPressed: () => _launchURLInBrowser(
                                      Uri.parse("tel:" +
                                          (controller.hotline.value)
                                              .toString())),
                                  icon: Icon(FontAwesomeIcons.phone,
                                      color: Colors.blue,
                                      size: Get.find<LanguageController>()
                                                  .savedLang
                                                  .value ==
                                              'AR'
                                          ? Get.width * 0.07
                                          : Get.width * 0.07),
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width * 0.10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topRight: const Radius.circular(20.0),
                                  topLeft: const Radius.circular(20.0),
                                  bottomRight: const Radius.circular(20.0),
                                  bottomLeft: const Radius.circular(20.0),
                                ), //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 2, //spread radius
                                    blurRadius: 2, // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: IconButton(
                                  color: Color.fromARGB(255, 242, 242, 242),
                                  onPressed: () => _launchURLInBrowser(Uri.parse(
                                      "https://api.whatsapp.com/send/?phone=" +
                                          (controller.whatsapp.value)
                                              .toString() +
                                          "&text=مرحبا بكم")),
                                  icon: Icon(FontAwesomeIcons.whatsapp,
                                      color: Color.fromARGB(255, 3, 164, 54),
                                      size: Get.find<LanguageController>()
                                                  .savedLang
                                                  .value ==
                                              'AR'
                                          ? Get.width * 0.07
                                          : Get.width * 0.07),
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width * 0.10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topRight: const Radius.circular(20.0),
                                  topLeft: const Radius.circular(20.0),
                                  bottomRight: const Radius.circular(20.0),
                                  bottomLeft: const Radius.circular(20.0),
                                ), //border corner radius
                              ),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: IconButton(
                                  color: Color.fromARGB(255, 242, 242, 242),
                                  onPressed: () => _launchURLInBrowser(
                                      Uri.parse((controller.website.value)
                                          .toString())),
                                  icon: Icon(FontAwesomeIcons.globe,
                                      color: Color.fromARGB(255, 191, 106, 100),
                                      size: Get.find<LanguageController>()
                                                  .savedLang
                                                  .value ==
                                              'AR'
                                          ? Get.width * 0.07
                                          : Get.width * 0.07),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                    // ),
                  ),
                  SizedBox(height: Get.height * 0.15),
                  Container(
                    color: Color.fromARGB(197, 236, 245, 233),
                    width: Get.width,
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.042,
                            top: 0,
                            right: Get.width * 0.042),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                gridWeatherBuilder2(
                                    widget.loans.allapplication.toString(),
                                    'Customers',
                                    Icons.check,
                                    Get.height,
                                    Get.width,
                                    widget.loans,
                                    3),

                                gridWeatherBuilder2(
                                    widget.loans.totalBalance.toString(),
                                    'totalBalance',
                                    Icons.check,
                                    Get.height,
                                    Get.width,
                                    widget.loans,
                                    4),
                                // ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                gridWeatherBuilder2(
                                    widget.loans.approvalappliaction.toString(),
                                    'loans_granted',
                                    Icons.check,
                                    Get.height,
                                    Get.width,
                                    widget.loans,
                                    3),
                                gridWeatherBuilder2(
                                    widget.loans.suspendedapplication
                                        .toString(),
                                    'pending_orders',
                                    Icons.check,
                                    Get.height,
                                    Get.width,
                                    widget.loans,
                                    4),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
          // );
        }
      },
    );
  }
}

_launchURLInBrowser(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
