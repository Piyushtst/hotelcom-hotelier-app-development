import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotel_customer/app/modules/home/controllers/home_controller.dart';
import 'package:hotel_customer/app/routes/app_pages.dart';
import 'package:hotel_customer/global/constants/app_asset.dart';
import 'package:hotel_customer/global/constants/app_color.dart';
import 'package:hotel_customer/global/constants/app_sizeConstant.dart';
import 'package:hotel_customer/global/constants/app_string.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetWidget<ProfileController> {
  ProfileView({Key? key}) : super(key: key);


  HomeController? homeController;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    homeController = Get.find<HomeController>();
    // print(" :::::::::::::${homeController?.responceGetMeApi.toJson()}");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        // title: Text('ProfileView'),
        // centerTitle: true,
        centerTitle: true,
        backgroundColor: AppColor.primary,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            size: 35,
          ),
        ),

        title: Text(
          homeController!.responceGetMeApi.hotel!.name.toString(),
          style: TextStyle(
            color: AppColor.titleGrayColor,
            fontSize: MySize.size18!,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: MySize.screenHeight,
        width: MySize.screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: MySize.size24!,
          vertical: MySize.size32!,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 30),
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "P",
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                       const Text(
                        "",
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${homeController!.responceGetMeApi.hotelier?.email}",//premkotion@gmail.com
                        style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.CHOOSE_CATEGORY);
              },
              child: getRowWidget(
                name: "Notification Settings",
                img: AppAsset.notificationPng,
              ),
            ),
            Space.height(30),
            InkWell(
              onTap: () {
                launchURL(url: "https://hotelier.hotelcom.live/auth/login");
              },
              child: getRowWidget(
                name: "Account Settings",
                img: AppAsset.settingPng,
              ),
            ),
            Space.height(30),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.FEEDBACK);
              },
              child: getRowWidget(
                name: "Feedback",
                // isFeedback: true,
                img: AppAsset.feedbackPng,
              ),
            ),
            Space.height(30),
            InkWell(
              onTap: () {
                launchURL(url: "https://hotelcom.live/support.html");
              },
              child: getRowWidget(
                name: "Help",
                img: AppAsset.helpPng,
              ),
            ),
            Space.height(30),
            InkWell(
              onTap: () {
                launchURL(url: "https://hotelcom.live/privacy-policy.html");
              },
              child: getRowWidget(
                name: "Privacy Policy",
                img: AppAsset.privacyPng,
              ),
            ),
            Space.height(30),
            InkWell(
              onTap: () {
                launchURL(url: "https://hotelcom.live/terms-conditions.html");
              },
              child: getRowWidget(
                name: "Terms & Conditions",
                img: AppAsset.termsPng,
              ),
            ),
            Space.height(60),
            Container(
              height: 1,
              width: double.infinity,
              color: AppColor.borderGrayColor,
            ),
            Space.height(20),
            InkWell(
              onTap: () {
                box.remove(Constant.tokenKey);
                Get.offAllNamed(Routes.LOGIN);
              },
              child: getRowWidget(
                name: "Log Out",
                img: AppAsset.logoutPng,
              ),
            ),
            Space.height(20),
            Container(
              height: 1,
              width: double.infinity,
              color: AppColor.borderGrayColor,
            ),
          ],
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

  Widget getRowWidget({String? name = "", String? img = "", bool isFeedback = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(
            img!,
          ),
          height: (isFeedback) ? MySize.size24 : MySize.size20,
          fit: BoxFit.cover,
        ),
        Space.width(20),
        Text(
          name!,
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.w500,
            fontSize: MySize.size18!,
          ),
        )
      ],
    );
  }
}
