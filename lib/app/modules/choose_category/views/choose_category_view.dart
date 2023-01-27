import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotel_customer/app/routes/app_pages.dart';
import 'package:hotel_customer/global/constants/app_asset.dart';
import 'package:hotel_customer/global/constants/app_string.dart';
import 'package:hotel_customer/main.dart';

import '../../../../global/constants/app_color.dart';
import '../../../../global/constants/app_sizeConstant.dart';
import '../controllers/choose_category_controller.dart';

class ChooseCategoryView extends GetView<ChooseCategoryController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Text(
            "Choose categories",
            style: TextStyle(
              color: AppColor.textGrayColor,
              fontWeight: FontWeight.bold,
              fontSize: MySize.size20!,
            ),
          ),
          centerTitle: false,
          backgroundColor: AppColor.primary,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              size: 35,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                List a = box.read(Constant.category);
                controller.list.forEach((element) {
                  if (element.isSelected!.value) {
                    a.add(element.index);
                  } else {
                    a.remove(element.index);
                  }
                });
                List b = a.toSet().toList();
                print(b);
                box.write(Constant.category, b);
                Get.offAllNamed(Routes.HOME,
                    arguments: {ArgumentConstant.isFromRefresh: true});
              },
              child: Center(
                child: Text(
                  "Done",
                  style: TextStyle(
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MySize.size18!,
                  ),
                ),
              ),
            ),
            Space.width(12),
          ],
        ),
        body: Container(
          height: MySize.screenHeight,
          width: MySize.screenWidth,
          padding: EdgeInsets.symmetric(
              horizontal: MySize.size25!, vertical: MySize.size30!),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Container(
              //         child: Checkbox(
              //           value: controller.selectAll.value,
              //           onChanged: (val) {
              //             controller.selectAll.toggle();
              //             if (controller.selectAll.isTrue) {
              //               controller.list.forEach((element) {
              //                 element.isSelected!.value = true;
              //               });
              //             } else {
              //               controller.list.forEach((element) {
              //                 element.isSelected!.value = false;
              //               });
              //             }
              //           },
              //           activeColor: AppColor.primary,
              //         ),
              //         height: 25,
              //       ),
              //       Text(
              //         "Select All",
              //         style: TextStyle(
              //           color: AppColor.primary,
              //           fontWeight: FontWeight.w500,
              //           fontSize: MySize.size16!,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Space.height(15),
              ListView.separated(
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      controller.list[i].isSelected!.toggle();
                      List l = controller.list
                          .where((p0) => !p0.isSelected!.value)
                          .toList();
                      if (l.isEmpty) {
                        controller.selectAll.value = true;
                      } else {
                        controller.selectAll.value = false;
                      }
                      controller.list.refresh();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  (controller.list[i].isSelected!.value)
                                      ? AppAsset.radioSelectedPng
                                      : AppAsset.radioPng),
                              height: MySize.size22,
                            ),
                            Space.width(15),
                            Text(
                              controller.list[i].name.toString(),
                              style: TextStyle(
                                color: AppColor.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: MySize.size16!,
                              ),
                            )
                          ],
                        ),
                        if (i == 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Checkbox(
                                  value: controller.selectAll.value,
                                  onChanged: (val) {
                                    controller.selectAll.toggle();
                                    if (controller.selectAll.isTrue) {
                                      controller.list.forEach((element) {
                                        element.isSelected!.value = true;
                                      });
                                    } else {
                                      controller.list.forEach((element) {
                                        element.isSelected!.value = false;
                                      });
                                    }
                                  },
                                  activeColor: AppColor.primary,
                                ),
                                height: 25,
                              ),
                              Text(
                                "Select All",
                                style: TextStyle(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: MySize.size16!,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, i) {
                  return Space.height(20);
                },
                itemCount: controller.list.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
