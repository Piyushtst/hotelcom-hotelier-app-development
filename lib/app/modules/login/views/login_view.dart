import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_customer/app/routes/app_pages.dart';
import 'package:hotel_customer/global/constants/app_sizeConstant.dart';
import 'package:hotel_customer/global/widgets/button.dart';
import 'package:hotel_customer/global/widgets/text_field.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../global/constants/app_asset.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetWidget<LoginController> {

  @override
  Widget build(BuildContext context) {
   // controller.idController.value.clear();
    //controller.passwordController.value.clear();
    MySize().init(context);
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
                const Center(
                  child: Image(
                    image: AssetImage(AppAsset.logoPng),
                    height: 338,
                    width: 358,
                  ),
                ),
                Space.height(10),
                Text(
                  "Hotelier ID",
                  style: TextStyle(
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Space.height(8),
                commonTextField(
                  controller: controller.idController.value,
                  needValidation: true,
                  isEmailValidation: true,
                  validationMessage:"Enter valid email",
                  //onlyAlphabetValidation: true,
                 // validationMessage: "Hotelier Id",

                ),
                Space.height(31),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Space.height(8),
                Obx(() {
                  return commonTextField(
                    controller: controller.passwordController.value,
                    needValidation: true,
                    maxLines: 1,
                    obscureText: !controller.isVisible.value,
                    validationMessage: "Password",
                    iconButton: InkWell(
                        onTap: () {
                          controller.isVisible.toggle();
                        },
                        child: Icon(
                          (controller.isVisible.isTrue)
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        )),
                  );
                }),

                Space.height(15),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.FORGET_PASSWORD);
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff3120FD),
                      ),
                    ),
                  ),
                ),
                Space.height(35),
                InkWell(
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.callApiForLogin(context: context);
                    }
                  },
                  child: button(
                    title: "Sign In",
                    fontsize: MySize.size18!,
                    radius: 8,
                  ),
                ),
                Space.height(25),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        Routes.SIGNUP,
                      );
                      // launchURL(url: "https://hotelcom.live/");
                    },
                    child: Text(
                      "Sign up here",
                      // "Visit hotelcom.live",
                      style: TextStyle(
                        color: Color(0xff3120FD),
                        fontSize: MySize.size16!,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                // Space.height(20),
                // Center(
                //   child: Text(
                //     "Or",
                //     style: TextStyle(
                //       fontSize: MySize.size16,
                //       fontWeight: FontWeight.normal,
                //       color: AppColor.textGrayColor,
                //     ),
                //   ),
                // ),
                // Space.height(20),
                // Center(
                //   child: Text(
                //     "Create an account",
                //     style: TextStyle(
                //       fontSize: MySize.size16,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  launchURL({required String url}) async {
    // const url = "https://flutter.io";
    //  if (await canLaunch(url)) {
    await launch(url);
    // } else {
    //   throw 'Could not Launch $url';
    // }
  }
}
