import 'package:get/get.dart';
import 'package:neecoder/app/controllers/home_controller.dart';
import 'package:neecoder/app/controllers/loan_controller.dart';
import '../controllers/landingPage_controller.dart';
import '../controllers/products_controller.dart';
import '../controllers/registration_controller.dart';

class LandingBinding implements Bindings {
  LandingBinding();

  @override
  void dependencies() {
    // Get.lazyPut(() => LanguageController());
    Get.lazyPut(() => LandingPageController());
    Get.lazyPut(() => RegistrationController());
    Get.lazyPut(() => ProductsController());
    Get.lazyPut(() => LoanController());
    Get.lazyPut(() => HomeController());
    // Get.lazyPut(() => OrdersController());
    // Get.lazyPut(() => AuthController());
    // Get.put(() => ProfileController());
  }
}
