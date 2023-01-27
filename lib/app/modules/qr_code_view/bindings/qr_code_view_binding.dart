import 'package:get/get.dart';

import '../controllers/qr_code_view_controller.dart';

class QrCodeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrCodeViewController>(
      () => QrCodeViewController(),
    );
  }
}
