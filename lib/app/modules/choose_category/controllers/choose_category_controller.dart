import 'package:get/get.dart';

import '../../../../global/constants/app_string.dart';
import '../../../../main.dart';

class ChooseCategoryController extends GetxController {
  //TODO: Implement ChooseCategoryController

  final count = 0.obs;
  RxList<CategoryModel> list = [
    CategoryModel(name: "Restaurant", isSelected: false.obs, index: 1),
    CategoryModel(name: "Housekeeping", isSelected: false.obs, index: 2),
    CategoryModel(name: "Laundry", isSelected: false.obs, index: 3),
    CategoryModel(name: "Extra Supplies", isSelected: false.obs, index: 4),
    CategoryModel(name: "Feedbacks", isSelected: false.obs, index: 5),
  ].obs;
  RxBool selectAll = true.obs;
  @override
  void onInit() {
    super.onInit();
    List a = box.read(Constant.category);
    list.forEach((element) {
      if (a.contains(element.index)) {
        element.isSelected!.value = true;
      }
    });
    list.forEach((element) {
      if (element.isSelected!.isFalse) {
        selectAll.value = false;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}

class CategoryModel {
  String? name;
  RxBool? isSelected;
  int? index = 0;

  CategoryModel({this.name, this.isSelected, this.index});
}
