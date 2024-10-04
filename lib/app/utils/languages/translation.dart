import 'package:get/get.dart';
import 'package:neecoder/app/utils/languages/ar.dart';
import 'package:neecoder/app/utils/languages/en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': ar,
        'en': en,
      };
}
