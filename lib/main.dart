import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neecoder/app/bindings/landing_binding.dart';
import 'package:neecoder/app/controllers/auth_controller.dart';
import 'package:neecoder/app/controllers/languages_controller.dart';
import 'package:neecoder/app/routes/app_pages.dart';
import 'package:neecoder/app/ui/pages/home.dart';
import 'package:neecoder/app/ui/pages/splash.dart';
import 'package:neecoder/app/utils/languages/translation.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('assets/isrgrootx1.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Get.put(LanguageController());
    final AuthController authController = Get.find<AuthController>();
    final LanguageController lang = Get.find<LanguageController>();
    return GetMaterialApp(
      title: 'Azal Microfinance',
      debugShowCheckedModeBanner: false,
      translations: Translation(),
      locale: Locale(lang.savedLang.value.toString().toLowerCase()),
      fallbackLocale: Locale(lang.savedLang.value.toString().toLowerCase()),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          // fontFamily: fon.fontFamily.value,
          fontFamily: lang.savedLang.value == 'AR' ? 'Cairo' : 'Poppins'),
      initialRoute: '/',
      home: Obx(
        () {
          if (authController.authenicated.value) {
            return HomeView();
          } else {
            return SplashScreen();
          }
        },
      ),
      initialBinding: LandingBinding(),
      getPages: AppPages.pages,
    );
  }
}
