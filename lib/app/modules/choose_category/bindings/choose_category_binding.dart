import 'package:get/get.dart';

import '../controllers/choose_category_controller.dart';

class ChooseCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseCategoryController>(
      () => ChooseCategoryController(),
    );
  }
}
