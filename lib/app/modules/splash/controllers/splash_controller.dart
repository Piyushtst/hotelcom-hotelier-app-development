import 'dart:async';
import 'package:get/get.dart';
import 'package:hotel_customer/app/routes/app_pages.dart';
import '../../../../global/constants/app_string.dart';
import '../../../../global/utils/prefUtils.dart';
import '../../../../main.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // initFcm();

    Timer(
      Duration(seconds: 2),
      () => Get.offAllNamed((!isNullEmptyOrFalse(box.read(Constant.tokenKey)))
          ? Routes.HOME
          : Routes.LOGIN),
    );
    if (box.read(Constant.category) == null) {
      box.write(Constant.category, [1, 2, 3, 4, 5]);
    }
  }

  /*initFcm() async {
    Get.put<FCMService>(FCMService()..init());
  }*/

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
