import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neecoder/app/controllers/location_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/languages_controller.dart';

class LocationView extends StatefulWidget {
  @override
  _LocationViewState createState() => _LocationViewState();
}

HomeController homeController = HomeController();

class _LocationViewState extends State<LocationView> {
  AuthController authController = AuthController();

  _launchURLInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    LocationController locationController = LocationController();
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (locationController.loadingLocation.value)
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Color(0xFFAD1917),
                        size: 80,
                      ),
                    );

                  if (locationController.location.isEmpty) {
                    return Center(
                        child: Container(
                      width: Get.width * 0.44,
                      height: Get.height * 0.44,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text("No_Locations_found".tr,
                              style: TextStyle(
                                  // fontSize: 22,
                                  // color: Color.fromARGB(255, 146, 4, 47),
                                  fontWeight: FontWeight.w600))),
                    ));
                  }
                  return ListView.builder(
                    itemCount: locationController.location.length,
                    padding: EdgeInsets.only(top: 12),
                    itemBuilder: (context, index) => Card(
                      elevation: 0.0,
                      child: InkWell(
                        onTap: () {
                          var lat = locationController.location[index]["lat"];
                          var long = locationController.location[index]["lng"];
                          var url =
                              "https://www.google.com/maps/search/?api=1&query=" +
                                  (lat).toString() +
                                  "," +
                                  (long).toString() +
                                  "";
                          _launchURLInBrowser(Uri.parse(url));
                        },
                        child: Container(
                          height: Get.width * 0.42,
                          padding: EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 14.0),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/map.jpg"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Get.find<LanguageController>()
                                                    .savedLang
                                                    .value ==
                                                'AR'
                                            ? locationController.location[index]
                                                ["lcation_name_ar"]
                                            : locationController.location[index]
                                                ["lcation_name_en"],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 8,
                                        overflow: TextOverflow.visible,
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: HtmlWidget(
                                          Get.find<LanguageController>()
                                                      .savedLang
                                                      .value ==
                                                  'AR'
                                              ? locationController
                                                  .location[index]["desc_ar"]
                                              : locationController
                                                  .location[index]["desc_en"],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } // return _buildProductsList();
                    ),
              ),
            ],
          ),
          // }
        ));
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
                ? Get.width * 0.21
                : Get.width * 0.28,
            // margin: const EdgeInsets.only(left: 70, right: 66),
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text("Map".tr,
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
            size: 30,
          ),
        ),
        // BackButton()
      ],
    );
  }
}
