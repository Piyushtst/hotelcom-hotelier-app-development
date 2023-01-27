import 'package:get/get.dart';

import '../controllers/checkout_request_controller.dart';

class CheckoutRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutRequestController>(
      () => CheckoutRequestController(),
    );
  }
}
