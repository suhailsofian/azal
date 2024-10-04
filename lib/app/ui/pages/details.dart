import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/languages_controller.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  // final String? title;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

HomeController homeController = HomeController();

class _DetailsPageState extends State<DetailsPage> {
  int countWords(String text) {
    // Trim the text to remove leading and trailing whitespace
    text = text.trim();

    // Check if the text is empty
    if (text.isEmpty) {
      return 0;
    }

    // Split the text by one or more spaces
    List<String> words = text.split(RegExp(r'\s+'));

    // Return the number of words
    return words.length;
  }

  @override
  Widget build(BuildContext context) {
    final title = Get.arguments['title'];
    final img = Get.arguments['image'];
    final text = Get.arguments['text'];
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
                    homeController.logoSite.value.toString(),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              width: Get.find<LanguageController>().savedLang.value == 'AR'
                  ? Get.width * 0.17
                  : Get.width * 0.11,
            ),
            Container(
              child: countWords(title.toString()) > 1
                  ? Text("" + title.toString(),
                      style: TextStyle(
                          fontSize:
                              Get.find<LanguageController>().savedLang.value ==
                                      'AR'
                                  ? Get.width * 0.065
                                  : Get.width * 0.042,
                          color: Color(0xFFAD1917),
                          fontWeight: FontWeight.w900)
                      // )v
                      )
                  : Text("      " + title.toString(),
                      style: TextStyle(
                          fontSize:
                              Get.find<LanguageController>().savedLang.value ==
                                      'AR'
                                  ? Get.width * 0.073
                                  : Get.width * 0.052,
                          color: Color(0xFFAD1917),
                          fontWeight: FontWeight.w900)
                      // )
                      ),
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
      ),
      body: ListView(
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(img),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(243, 255, 255, 255),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(13.0, 12, 18.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  HtmlWidget(
                    text.toString(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
