import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:neecoder/app/utils/shared_service.dart';

class LanguageController extends GetxController {
  final PrefService _prefService = PrefService();

  var savedLang = 'EN'.obs;
  var savedingVal = ''.obs;
  LanguageController() {
    if (!Platform.isWindows) {
      savedLang.value =
          Platform.localeName.split('_')[0].toString().toUpperCase();
    }

    savedingVal.value = savedLang.value;
  }
  saveLocale(String save) {
    _prefService.createString('locale', save);
  }

  Future<void> setLocale() async {
    _prefService.readString('locale').then((value) {
      if (value != '' && value != null) {
        savedLang.value = value.toString();
        //print(savedLang.value);
        Get.updateLocale(Locale(value.toString().toLowerCase()));
        saveingLang();
      }
    });
  }

  saveingLang() {
    return savedingVal.value = savedLang.value;
  }

  @override
  void onInit() async {
    setLocale();
    super.onInit();
  }
}
