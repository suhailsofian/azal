import 'package:get/get.dart';
import 'package:neecoder/app/controllers/landingPage_controller.dart';
import 'package:neecoder/app/routes/app_routes.dart';
import 'package:neecoder/app/ui/pages/changePassword.dart';
import 'package:neecoder/app/ui/pages/complaints.dart';
import 'package:neecoder/app/ui/pages/complaintsList.dart';
import 'package:neecoder/app/ui/pages/details.dart';
import 'package:neecoder/app/ui/pages/editFundRequest.dart';
import 'package:neecoder/app/ui/pages/installments.dart';
import 'package:neecoder/app/ui/pages/landingPage.dart';
import 'package:neecoder/app/ui/pages/location.dart';
import 'package:neecoder/app/ui/pages/login.dart';
import 'package:neecoder/app/ui/pages/orderList.dart';
import 'package:neecoder/app/ui/pages/payments.dart';
import 'package:neecoder/app/ui/pages/registration.dart';
import 'package:neecoder/app/ui/pages/resetPassword.dart';
import 'package:neecoder/app/ui/pages/root_app.dart';
import 'package:neecoder/app/ui/pages/signup.dart';
import 'package:neecoder/app/ui/pages/splash.dart';
import 'package:neecoder/app/ui/pages/summaryComplaints.dart';
import 'package:neecoder/app/ui/pages/verifiedPage.dart';
import 'package:neecoder/app/ui/pages/verifiedPageAfterSignup.dart';
import 'package:neecoder/app/ui/pages/world_stats_screen.dart';
import 'package:neecoder/main.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.registration,
      page: () => SignupPage(),
    ),
    GetPage(
      name: AppRoutes.landing,
      page: () => LandingPage(
        loans: LandingPageController(),
      ),
    ),
    GetPage(
      name: AppRoutes.detailsPage,
      page: () => DetailsPage(),
    ),
    GetPage(
      name: AppRoutes.installmentsPage,
      page: () => InstallmentsView(),
    ),
    GetPage(
      name: AppRoutes.paymentPage,
      page: () => PaymentsView(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => RootApp(),
    ),
    GetPage(
      name: AppRoutes.orderListPage,
      page: () => OrderListPage(loans: LandingPageController()),
    ),
    GetPage(
      name: AppRoutes.summaryPage,
      page: () => WorldStatsScreen(),
    ),
    GetPage(
      name: AppRoutes.summaryComplaintsPage,
      page: () => SummaryComplaintScreen(),
    ),
    GetPage(
      name: AppRoutes.resetPasswordPage,
      page: () => ResetPasswordPage(),
    ),
    GetPage(
      name: AppRoutes.verifiedPage,
      page: () => VerifiedPage(),
    ),
    GetPage(
      name: AppRoutes.changePasswordPage,
      page: () => ChangePasswordPage(),
    ),
    GetPage(
      name: AppRoutes.registrationDetails,
      page: () => RegistrationPage(),
    ),
    GetPage(
      name: AppRoutes.myApp,
      page: () => MyApp(),
    ),
    GetPage(
      name: AppRoutes.verifiedPageAfterSignUp,
      page: () => VerifiedPageAfterSignUp(),
    ),
    GetPage(
      name: AppRoutes.comolaintsList,
      page: () => ComplaintsListPage(),
    ),
    GetPage(
      name: AppRoutes.editfundRequestPage,
      page: () => EditFundRequestPage(),
    ),
    GetPage(
      name: AppRoutes.comolaints,
      page: () => ComplaintsPage(),
    ),
    GetPage(
      name: AppRoutes.locationPage,
      page: () => LocationView(),
    ),
  ];
}
