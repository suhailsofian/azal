import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:neecoder/app/controllers/auth_controller.dart';
import 'package:neecoder/app/controllers/languages_controller.dart';

import 'package:neecoder/app/utils/httpConfig/HttpsConnect.dart' as httpp;

class LoanController extends GetxController {
  List allLoans = [].obs;
  List allinstallments = [].obs;
  List allBonds = [].obs;
  RxBool loadingLoan = false.obs;
  RxBool loadingPay = false.obs;
  RxBool loadingIns = false.obs;

  LoanController() {
    loadLoanReviewFromApi();
  }

  loadLoanReviewFromApi() async {
    try {
      var url = Uri.parse("https://apply.azal-ye.com/api/loan");
      loadingLoan(true);
      var currentToken = Get.find<AuthController>().showToken();
      ;

      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $currentToken',
      };
      Map body = {
        "lang_id": Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase()
      };
      // final IOClient httppo = await httpp.HttpsConnect().https();
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      print("loadLoanReviewFromApi");
      print(json);
      allLoans = json['data'];
      // allLoans = data;
      loadingLoan(false);
    } catch (error) {
      //print("loadLoanReviewFromApi catch");
    }
  }

  loadInstallmentsReviewFromApi(id) async {
    try {
      var url = Uri.parse("https://apply.azal-ye.com/api/Installment");
      loadingIns(true);
      var currentToken = Get.find<AuthController>().showToken();
      ;

      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $currentToken',
      };
      Map body = {
        "lang_id": Get.find<LanguageController>()
            .savedLang
            .value
            .toString()
            .toLowerCase(),
        "loan_id": id
      };
      final IOClient httppo = await httpp.HttpsConnect().https();
      var response =
          await httppo.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);

      allinstallments = json['data'];
      loadingIns(false);
    } catch (error) {
      //print("loadInstallmentsReviewFromApi catch");
    }
  }

  loadBondsReviewFromApi(loanId, installmentId) async {
    var url = Uri.parse("https://apply.azal-ye.com/api/bond");
    loadingPay(true);
    var currentToken = Get.find<AuthController>().showToken();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $currentToken',
    };
    Map body = {
      "lang_id": Get.find<LanguageController>()
          .savedLang
          .value
          .toString()
          .toLowerCase(),
      "loan_id": loanId,
      "installment_id": installmentId
    };
    final IOClient httppo = await httpp.HttpsConnect().https();
    var response =
        await httppo.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    //print("loadBondsReviewFromApi");
    //print(json);
    allBonds = json['data'];
    loadingPay(false);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
