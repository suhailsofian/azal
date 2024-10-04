import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controllers/complaint_controller.dart';
import '../../controllers/landingPage_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../controllers/registration_controller.dart';
import '../../routes/app_routes.dart';

class ComplaintsListPage extends StatefulWidget {
  const ComplaintsListPage({Key? key}) : super(key: key);

  @override
  _ComplaintsListPageState createState() => _ComplaintsListPageState();
}

class _ComplaintsListPageState extends State<ComplaintsListPage> {
  List<dynamic> jobList = [];

  @override
  Widget build(BuildContext context) {
    // ComplaintController controller = Get.put(ComplaintController());
    ComplaintController complaintController = ComplaintController();

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: _buildAppBar(complaintController),
        body: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          child: Obx(
            () {
              if (complaintController.loading.value) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Color(0xFFAD1917),
                    size: 80,
                  ),
                );
              }
              if (complaintController.allComplaints.isEmpty) {
                // OverlayLoadingProgress.stop();
                return Center(
                    child: Container(
                  width: Get.width * 0.50,
                  height: Get.height * 0.50,
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text("No_Complaints_found".tr,
                          style: TextStyle(
                              // fontSize: 22,
                              // color: Color.fromARGB(255, 146, 4, 47),
                              fontWeight: FontWeight.w600))),
                ));
              }
              // OverlayLoadingProgress.stop();
              return ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: complaintController.allComplaints.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: jobComponent(
                          complaintController.allComplaints[index]
                              ['complaints'],
                          complaintController.allComplaints[index]
                              ['insert_date'],
                          complaintController.allComplaints[index]
                              ['main_classification'],
                          complaintController.allComplaints[index]['id']),
                      //   },
                      // )
                    );
                  });
              // ],
            },
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(complaintController) {
    return AppBar(
      toolbarHeight: Get.size.height * 0.1,
      // titleSpacing: 40,
      // automaticallyImplyLeading: false,

      elevation: 0,
      backgroundColor: Color.fromARGB(255, 199, 207, 189),
      centerTitle: true,
      iconTheme: IconThemeData(color: Color.fromARGB(255, 146, 4, 47)),
      leading: BackButton(
        onPressed: () {
          Get.toNamed(AppRoutes.profile);
        },
      ),

      // elevation: 0,
      title: Text("ComplaintsList".tr,
          // textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: Get.find<LanguageController>().savedLang.value == 'AR'
                  ? Get.width * 0.05
                  : Get.width * 0.037,
              color: Color(0xFFAD1917),
              fontWeight: FontWeight.w900)),

      actions: [
        Container(
          // width: 120.0,
          // height: 30.0,
          child: ElevatedButton(
            onPressed: () async {
              bool checkToken =
                  Get.find<LandingPageController>().isTokenExpired();
              if (!checkToken) {
                bool check = await complaintController.checkAddNewComplaints();
                if (check) {
                  final ComplaintController complaintController =
                      Get.put(ComplaintController());
                  Get.find<ComplaintController>().userSearchItems.clear();
                  Get.find<RegistrationController>().selectedClassValue.value =
                      '';
                  Get.find<RegistrationController>().classList.clear();
                  Get.toNamed(AppRoutes.comolaints);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFAD1917),
            ),
            // color: Color(0XFFFF0000),

            child: Row(
              children: <Widget>[
                Text(
                  'Add'.tr,
                  style: TextStyle(
                    color: Color.fromARGB(255, 244, 239, 241),
                  ),
                ),
                Icon(
                  Icons.add,
                  color: Color.fromARGB(255, 251, 246, 248),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  jobComponent(complaints, date, type, id) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // if you need this
        // side: BorderSide(
        //   color: Colors.grey.withOpacity(.2),
        //   width: 1,
        // ),
      ),
      elevation: 5.0,
      child: Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 2,
                // offset: Offset(0, 1),
              ),
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(children: [
                   
                    SizedBox(width: 2),
                    Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                // color: Colors.grey.shade200
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Complaint_Subject".tr + " : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Get.width * 0.035),
                                  ),
                                  Text(
                                    complaints,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Get.width * 0.035),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              // padding: EdgeInsets.symmetric(
                              //     vertical: 10, horizontal: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                // color: Colors.grey.shade200
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Complaints_type".tr + " : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Get.width * 0.035),
                                  ),
                                  Text(
                                    type,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Get.width * 0.035),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    )
                  ]),
                ),
                FloatingActionButton(
                  heroTag: "btn$id",
                  mini: true,
                  backgroundColor: Color.fromARGB(255, 198, 14, 69),
                  onPressed: (() => {
                        Get.put(ComplaintController()),
                        Get.find<ComplaintController>()
                            .loadcomplaintsReviewIdFromApi(id),
                        Get.toNamed(AppRoutes.summaryComplaintsPage,
                            arguments: {'id': id})

                        // Get.toNamed(AppRoutes.summaryComplaintsPage)
                      }),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  tooltip: 'Increment',
                  child: const Icon(FontAwesomeIcons.eye),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          // color: Colors.grey.shade200
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Date_Complaints".tr + " : ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Get.width * 0.035),
                            ),
                            Text(
                              date,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Get.width * 0.035),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
