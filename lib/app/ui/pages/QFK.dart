import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/languages_controller.dart';

class QFKPage extends StatefulWidget {
  const QFKPage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _QFKPageState createState() => _QFKPageState();
}

class _QFKPageState extends State<QFKPage> {
  HomeController homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                      homeController.logoSite.value.toString() != null
                          ? homeController.logoSite.value.toString()
                          : "",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Container(
                width: Get.find<LanguageController>().savedLang.value == 'AR'
                    ? Get.width * 0.2
                    : Get.width * 0.06,
              ),
              Container(
                width: Get.find<LanguageController>().savedLang.value == 'AR'
                    ? Get.width * 0.33
                    : Get.width * 0.55,
                // margin: const EdgeInsets.only(left: 70, right: 66),
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(widget.title == null ? '' : widget.title!,
                        // "",
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
          ],
        ),
        body: Obx(
          () {
            if (homeController.loading.value)
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Color(0xFFAD1917),
                  size: 80,
                ),
              );
            if (homeController.itemss.isEmpty) {
              return Center(
                  child: Container(
                width: Get.width * 0.44,
                height: Get.height * 0.44,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text("No_QFK_found".tr,
                        style: TextStyle(fontWeight: FontWeight.w600))),
              ));
            }
            return ListView.builder(
                itemCount: homeController.itemss.length,
                itemBuilder: (_, index) {
                  final item = homeController.itemss[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 7, left: 7, top: 4),
                    child: Card(
                      key: PageStorageKey(item['id']),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(3), // if you need this
                      ),
                      child: ExpansionTile(
                          iconColor: Colors.black87,
                          collapsedIconColor: Colors.black87,
                          childrenPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          expandedCrossAxisAlignment: CrossAxisAlignment.end,
                          title: Text(
                              item['quastion'] != null ? item['quastion'] : "",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: Get.find<LanguageController>()
                                              .savedLang
                                              .value ==
                                          'AR'
                                      ? Get.width * 0.035
                                      : Get.width * 0.032,
                                  fontWeight: FontWeight.bold)),
                          children: [
                            Text(item['answer'],
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: Get.find<LanguageController>()
                                              .savedLang
                                              .value ==
                                          'AR'
                                      ? Get.width * 0.03
                                      : Get.width * 0.032,
                                )),
                          ]),
                    ),
                  );
                });
          },
        ));
  }
}
