import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4)).then((_) {
      Get.toNamed(AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeController controller = HomeController();
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0x218BAB7F),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Obx(
                  () {
                    if (controller.loading.value) return Center();
                    return Container(
                      width: Get.width * 0.44,
                      height: Get.height * 0.44,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              controller.logoSplash.value.toString()),
                        ),
                      ),
                    );
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
