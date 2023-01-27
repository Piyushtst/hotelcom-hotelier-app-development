import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

// import '../../../../global/constants/app_asset.dart';
import '../../../../global/constants/app_asset.dart';
import '../../../../global/constants/app_color.dart';
import '../../../../global/constants/app_sizeConstant.dart';
import 'package:flutter/src/widgets/icon.dart';
// import '../../../../global/widgets/app_logo.dart';
import '../../../../global/widgets/button.dart';
import '../../../../global/widgets/text_field.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetWidget<ForgetPasswordController> {
  const ForgetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MySize.screenHeight,
        width: MySize.screenWidth,
        padding:
            EdgeInsets.symmetric(horizontal: MySize.getScaledSizeWidth(40)),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space.height(45),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColor.black,
                      size: 35,
                    )),
                const Center(
                    child: Image(
                  image: AssetImage(AppAsset.logoPng),
                )),
                Space.height(10),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: MySize.size20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Space.height(5),
                Text(
                  "we will sent the password reset link on this email ",
                  style: TextStyle(
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Space.height(30),
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Space.height(8),
                commonTextField(
                  controller: controller.idController.value,
                  needValidation: true,
                  validationMessage: "Email",
                ),
                Space.height(40),
                InkWell(
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.callApiForLogin(context: context);
                    }
                  },
                  child: button(
                    title: "Submit",
                    fontsize: MySize.size18!,
                    radius: 8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
