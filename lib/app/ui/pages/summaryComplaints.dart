import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../controllers/complaint_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../utils/constants.dart';

class SummaryComplaintScreen extends StatefulWidget {
  const SummaryComplaintScreen({Key? key}) : super(key: key);

  @override
  State<SummaryComplaintScreen> createState() => _SummaryComplaintScreenState();
}

class _SummaryComplaintScreenState extends State<SummaryComplaintScreen> {
  Size? _size;
  final formatter = intl.NumberFormat.decimalPattern();
  var id = Get.arguments['id'];
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(5, 50.0, 5, 1),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(""),
                  Text(
                    "ComplaintsView".tr,
                    style: TextStyle(
                        fontSize:
                            Get.find<LanguageController>().savedLang.value ==
                                    'AR'
                                ? Get.width * 0.055
                                : Get.width * 0.07,
                        fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close)),
                ]),
          ),
          Expanded(
            child: Obx(
              () {
                if (Get.find<ComplaintController>().loadingOne.value) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Color(0xFFAD1917),
                      size: 80,
                    ),
                  );
                }

                return _buildBody(Get.find<ComplaintController>().complaints);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody(List complaints) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _size!.height * 0.015),
      child: Column(
        children: [
          _buildHeading(""),
          _buildReportDetails(complaints),
          const Expanded(flex: 33, child: SizedBox()),
        ],
      ),
    );
  }

  Widget _buildHeading(String heading) {
    return Container(
      child: Text(
        heading,
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildReportDetails(List complaints) {
    return Expanded(
        flex: 60,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: _size!.height * 0.011,
              horizontal: _size!.height * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_size!.height * 0.03),
            border: Border.all(color: MyColors.kLoblolly, width: 2.0),
          ),
          child: _buildReportItems(complaints),
        ));
  }

  Widget _buildReportItems(List complaints) {
    return Column(
      children: [
        _buildReportItem(
          'Complaint_Sender'.tr,
          complaints[0]['name'],
        ),
        _addHorizontalDivider(),
        _buildReportItem(
          'Complaint_Subject'.tr,
          complaints[0]['complaints'],
        ),
        _addHorizontalDivider(),
        _buildReportItem(
          'Complaint_details'.tr,
          complaints[0]['text'],
        ),
        _addHorizontalDivider(),
        _buildReportItem(
          'Complaints_type'.tr,
          complaints[0]['main_classification'][0]['issue_name'],
        ),
        _addHorizontalDivider(),
        _buildReportItem(
          'Subcategory'.tr,
          complaints[0]['classification'][0]['issue_name'],
        ),
        _addHorizontalDivider(),
        _buildReportItem(
          'Complaint_replay'.tr,
          complaints[0]['review'] != null
              ? complaints[0]['review']['review'] != null
                  ? complaints[0]['review']['review']
                  : ""
              : "",
        ),
        _addHorizontalDivider(),
        _buildReportItem(
          'Complaint_time'.tr,
          complaints[0]['insert_date'],
        ),
      ],
    );
  }

  Widget _buildReportItem(String title, String count) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildReportText(title),
          _buildReportText(count),
        ],
      ),
    );
  }

  Widget _buildReportText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: Get.find<LanguageController>().savedLang.value == 'AR'
              ? _size!.width * 0.035
              : _size!.width * 0.035,
          fontWeight: FontWeight.w600),
    );
  }

  Widget _addHorizontalDivider() {
    return Divider(
      color: MyColors.kLoblollyLight,
      thickness: 1.0,
      indent: _size!.height * 0.04,
      endIndent: _size!.height * 0.04,
    );
  }
}
