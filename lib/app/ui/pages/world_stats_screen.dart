import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neecoder/app/ui/pages/landingPage.dart';
import 'package:neecoder/app/ui/widgets/helper_widgets.dart';
import '../../controllers/landingPage_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../controllers/orders_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> {
  Size? _size;

  final formatter = intl.NumberFormat.decimalPattern();
  var id = Get.arguments['id'];
  var status = Get.arguments['status'];
  LandingPageController landingBinding = Get.arguments['land'];

  @override
  Widget build(BuildContext context) {
    OrdersController ordersController = OrdersController();

    ordersController.loadFundingReviewIdFromApi(id);
    _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(8, 44.0, 8, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(""),
                  Container(
                    width:
                        Get.find<LanguageController>().savedLang.value == 'AR'
                            ? Get.width * 0.43
                            : Get.width * 0.20,
                    //  Get.size.width * 0.20,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "show_order".tr,
                        style: TextStyle(
                            fontSize: Get.width * 0.02,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        Get.back();
                      },
                      child: Icon(Icons.close)),
                ]),
          ),
          Expanded(
            child: Obx(
              () {
                if (ordersController.loadingOne.value) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Color(0xFFAD1917),
                      size: 80,
                    ),
                  );
                }

                return _buildBody(ordersController.funding, landingBinding);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody(funding, landingBinding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _size!.height * 0.011),
      child: Column(
        children: [
          _buildReportDetails(funding),
          if (landingBinding.isCompleted == false)
            const Expanded(flex: 1, child: SizedBox()),
          if (landingBinding.isCompleted == false) _buildHeader(landingBinding),
          if (status == '0') _buildCountryButton(landingBinding),
          const Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }

  Widget _buildReportDetails(funding) {
    return Expanded(
      flex: 350,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_size!.height * 0.03),
          border: Border.all(color: MyColors.kLoblolly, width: 2.0),
        ),
        child: _buildReportItems(funding),
      ),
    );
  }

  Widget _buildHeader(landingBinding) {
    return Expanded(
      flex: 67,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            child: _buildHeaderStats(landingBinding),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStats(landingBinding) {
    return Container(
      width: Get.width,
      child: dailyWidget2('Remaining_Amount', '0', '2024/3/3', 'welcome',
          Get.height, Get.width, landingBinding),
    );
  }

  // methods to build world report
  Widget _buildReportItems(funding) {
    final NumberFormat usCurrency = NumberFormat('#,##0', 'en_US');
    return Column(
      children: [
        _buildReportItem(
          'Product'.tr,
          (funding['product_id'] as List).isEmpty
              ? ''
              : funding['product_id'][0]['name'],
        ),
        _addHorizontalDivider(),
        _buildReportItem(
          'Request_amount'.tr,
          usCurrency.format(int.parse(funding['request_amount'].toString())),
        ),
        _addHorizontalDivider(),
        _buildReportItem(
          'Request_period'.tr,
          (funding['request_period'] as List).isEmpty
              ? ''
              : funding['request_period'][0]['name'],
        ),
        _addHorizontalDivider(),
        _buildReportItem(
          'Product_type'.tr,
          (funding['period_type'] as List).isEmpty
              ? ''
              : funding['period_type'][0]['name'],
        ),
        _addHorizontalDivider(),
        _buildReportItem(
          'Activity_class'.tr,
          (funding['activity_class'] as List).isEmpty
              ? ''
              : funding['activity_class'][0]['classname'],
        ),
        _addHorizontalDivider(),
        _buildReportItem(
            'Activity'.tr,
            (funding['activity_id'] as List).isEmpty
                ? ''
                : funding['activity_id'][0]['activity_name']),
        _addHorizontalDivider(),
        _buildReportItem(
          'Activity_address'.tr,
          funding['activity_address'],
        ),
        _addHorizontalDivider(),
        _buildReportItem(
          'Activity_area'.tr,
          (funding['activity_area'] as List).isEmpty
              ? ''
              : funding['activity_area'][0]['name'],
        ),
        _addHorizontalDivider(),
        _buildReportItem(
          'Grantee_type'.tr,
          (funding['grantee_type'] as List).isEmpty
              ? ''
              : funding['grantee_type'][0]['name'],
        ),
        SizedBox(
          height: 33,
        ),
      ],
    );
  }

  Widget _buildReportItem(String title, String count) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildReportText(title),
          _buildReportText(count),
        ],
      ),
    );
  }

  Widget _buildReportText(String text) {
    return Container(
        width: Get.width * 0.42,
        child: Text(
          text,
          overflow: TextOverflow.fade,
          softWrap: true,
          style: TextStyle(
              fontSize: Get.find<LanguageController>().savedLang.value == 'AR'
                  ? Get.width * 0.035
                  : Get.width * 0.032,
              fontWeight: FontWeight.w700),
          maxLines: 60,
        ));
  }

  Widget _buildCountryButton(landingBinding) {
    OrdersController controller = OrdersController();
    return Expanded(
      flex: 26,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: _size!.height * 0.0,
          horizontal: _size!.width * 0.0,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: _size!.height * 0.015),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              print(landingBinding.isCompleted);
              if (landingBinding.isCompleted == false) {
                landingBinding.dialogMS("complete_your_data".tr);
              } else {
                var res =
                    await controller.postFundingRequests(id, landingBinding);

                print(res['data']);
                print(res['message']);
                print(res['errors']);
                if (res['status'] == false) {
                  Get.find<LandingPageController>()
                      .dialogMS(res['message'].toString());
                } else {
                  LandingPageController con = new LandingPageController();
                  con.tabIndex.value = 4;

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LandingPage(loans: con),
                  ));
                  Get.find<LandingPageController>().dialogCheckMS(
                      AppRoutes.orderListPage, false,
                      steps: null,
                      message: res['data'].toString(),
                      obj: Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                        builder: (context) => LandingPage(loans: con),
                      )));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              enableFeedback: true,
              primary: Color(0xFFAD1917),
              onPrimary: MyColors.kPorcelain,
              fixedSize: const Size.fromWidth(double.infinity),
            ),
            child: Text(
              'Confirm_Order'.tr,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontSize: _size!.height * 0.025,
                    color: MyColors.kPorcelain,
                  ),
            ),
          ),
        ),
      ),
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
