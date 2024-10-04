import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:neecoder/app/data/models/CustomListTile.dart';
import 'package:neecoder/app/ui/pages/QFK.dart';
import 'package:neecoder/app/ui/pages/terms.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/landingPage_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../controllers/registration_controller.dart';
import '../../routes/app_routes.dart';

class RootApp extends StatelessWidget {
  RootApp({Key? key}) : super(key: key);

  final AuthController authController = Get.find<AuthController>();
  final LanguageController lang = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // bottomOpacity: 90,
          toolbarHeight: Get.size.height * 0.1,

          elevation: 0,
          backgroundColor: Color.fromARGB(255, 185, 193, 175),

          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: Get.find<LanguageController>().savedLang.value == 'AR'
                    ? Get.width * 0.15
                    : Get.width * 0.15,
                child: Obx(
                  () => Image.network(
                    homeController.logoSite.value.toString(),
                    fit: BoxFit.contain,
                  ),
                  // ),
                ),
              ),
              Container(
                width: Get.find<LanguageController>().savedLang.value == 'AR'
                    ? Get.width * 0.2
                    : Get.width * 0.2,
              ),
              Container(
                width: Get.find<LanguageController>().savedLang.value == 'AR'
                    ? Get.width * 0.22
                    : Get.width * 0.22,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text("Profile".tr,
                        style: TextStyle(
                            // fontSize: 22,
                            color: Color(0xFFAD1917),
                            fontWeight: FontWeight.w900))),
              ),
            ],
          ),

          actions: [
            IconButton(
              color: Color.fromARGB(255, 146, 4, 47),
              onPressed: () {
                Get.toNamed(AppRoutes.landing);
              },
              icon: const Icon(
                Icons.arrow_forward,
                size: 30,
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(136, 244, 247, 243),
          ),
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3), // if you need this
                ),
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.person_circle,
                      size: 70,
                    ),
                    const SizedBox(height: 10),
                    Obx(() => Text(
                          "${authController.showName()}",
                          style: TextStyle(
                            color: Color.fromARGB(255, 146, 4, 47),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 146, 173, 118),
                      ),
                      width: double.infinity,
                      height: Get.width * 0.15,
                      child: ElevatedButton(
                        onPressed: () async {
                          bool checkToken = Get.find<LandingPageController>()
                              .isTokenExpired();
                          if (!checkToken) {
                            await Get.find<AuthController>()
                                .viewUserProfileFromApi(null);
                            Get.toNamed(AppRoutes.registrationDetails);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 146, 173, 118),
                        ),
                        child: Text(
                          "continue".tr,
                          style: TextStyle(
                            fontSize: Get.width * 0.047,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 20),
              ...List.generate(
                customListTiles.length,
                (index) {
                  final tile = customListTiles[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: GestureDetector(
                      onTap: () {
                        if (tile.code == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Obx(() => TermsScreen(
                                title: "location".tr,
                                body: homeController.terms.value)),
                          ));
                        }
                        if (tile.code == 2) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Obx(() => TermsScreen(
                                title: "noti".tr,
                                body: homeController.privacy.value)),
                          ));
                        }
                        if (tile.code == 3) {
                          bool checkToken = Get.find<LandingPageController>()
                              .isTokenExpired();
                          if (!checkToken) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => QFKPage(title: "QFK".tr),
                            ));
                          }
                        }

                        if (tile.code == 4) {
                          bool checkToken = Get.find<LandingPageController>()
                              .isTokenExpired();
                          if (!checkToken) {
                            Get.toNamed(AppRoutes.comolaintsList);
                          }
                        }
                        if (tile.code == 5) {
                          bool checkToken = Get.find<LandingPageController>()
                              .isTokenExpired();
                          if (!checkToken) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Choose_The_Language".tr),
                                content: GetBuilder<LanguageController>(
                                    init: LanguageController(),
                                    builder: (value) {
                                      return DropdownButtonFormField2<String>(
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 2),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          // Add more decoration..
                                        ),
                                        hint: Text(
                                          'Select_Your_Choice'.tr,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: <String>[
                                          'EN',
                                          'AR',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select choice.';
                                          }
                                          return null;
                                        },
                                        onChanged: (String? newValue) {
                                          value.saveLocale(newValue!);
                                          value.setLocale();
                                          Get.find<RegistrationController>()
                                              .onInitLoad(newValue);

                                          Get.back();
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.only(right: 8),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: 24,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                        ),
                                      );
                                    }),
                              ),
                            );
                          }
                        }
                        if (tile.code == 6) {
                          Get.find<LandingPageController>()
                              .dialogLogout("are_you_sure_want_to_logout".tr);
                        }
                        if (tile.code == 7) {
                          bool checkToken = Get.find<LandingPageController>()
                              .isTokenExpired();
                          if (!checkToken) {
                            Get.toNamed(AppRoutes.locationPage);
                          }
                        }
                        if (tile.code == 8) {
                          bool checkToken = Get.find<LandingPageController>()
                              .isTokenExpired();
                          if (!checkToken) {
                            Get.find<LandingPageController>()
                                .dialogVerify("want_change_password".tr);
                          }
                        }
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // if you need this
                        ),
                        child: tile.code != 9
                            ? ListTile(
                                leading: Icon(tile.icon),
                                title: Text(tile.title.tr),
                                trailing: const Icon(Icons.chevron_right))
                            : ListTile(
                                leading: Icon(tile.icon),
                                title: Obx(() => Text(
                                      tile.title.tr +
                                          " : "
                                              "${authController.showVersion()}",
                                      style: TextStyle(),
                                    )),
                              ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    title: "Complaints",
    icon: CupertinoIcons.tag_circle,
    code: 4,
  ),
  CustomListTile(
    icon: FontAwesomeIcons.unlockKeyhole,
    title: "Change_password",
    code: 8,
  ),
  CustomListTile(
    icon: Icons.location_on_outlined,
    title: "Map",
    code: 7,
  ),
  CustomListTile(
    icon: Icons.policy_outlined,
    title: "location",
    code: 1,
  ),
  CustomListTile(
    title: "noti",
    icon: Icons.privacy_tip_outlined,
    code: 2,
  ),
  CustomListTile(
    title: "QFK",
    icon: CupertinoIcons.question_circle,
    code: 3,
  ),
  CustomListTile(
    title: 'language',
    icon: Icons.language,
    code: 5,
  ),
  CustomListTile(
    title: 'signOut',
    icon: CupertinoIcons.power,
    code: 6,
  ),
  CustomListTile(
    title: "version",
    icon: CupertinoIcons.check_mark,
    code: 9,
  ),
];
