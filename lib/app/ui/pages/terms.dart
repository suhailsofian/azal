import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:neecoder/app/controllers/languages_controller.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key, this.title, this.body}) : super(key: key);
  final String? title;
  final String? body;
  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(15, 55.0, 14, 15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back)),
                Text(
                  widget.title!,
                  style: TextStyle(
                      fontSize:
                          Get.find<LanguageController>().savedLang.value == 'AR'
                              ? Get.width * 0.07
                              : Get.width * 0.06,
                      fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close)),
              ]),
        ),
        Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: HtmlWidget(
                    widget.body!,
                  ),
                )))
      ]),
    );
  }
}
