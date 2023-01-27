import 'package:get/get.dart';
import 'package:hotel_customer/app/modules/signup/bindings/signup_binding.dart';
import 'package:hotel_customer/app/modules/signup/views/signup_view.dart';

import '../modules/checkout_request/bindings/checkout_request_binding.dart';
import '../modules/checkout_request/views/checkout_request_view.dart';
import '../modules/choose_category/bindings/choose_category_binding.dart';
import '../modules/choose_category/views/choose_category_view.dart';
import '../modules/feedback/bindings/feedback_binding.dart';
import '../modules/feedback/views/feedback_view.dart';
import '../modules/forget_password/bindings/forget_password_binding.dart';
import '../modules/forget_password/views/forget_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/qr_code_view/bindings/qr_code_view_binding.dart';
import '../modules/qr_code_view/views/qr_code_view_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.QR_CODE_VIEW,
      page: () => QrCodeViewView(),
      binding: QrCodeViewBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT_REQUEST,
      page: () => CheckoutRequestView(),
      binding: CheckoutRequestBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK,
      page: () => FeedbackView(),
      binding: FeedbackBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_CATEGORY,
      page: () => ChooseCategoryView(),
      binding: ChooseCategoryBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
  ];
}
