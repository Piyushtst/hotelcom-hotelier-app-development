import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:hotel_customer/global/constants/app_asset.dart';
import 'package:hotel_customer/global/constants/app_color.dart';
import 'package:hotel_customer/global/constants/app_sizeConstant.dart';

import '../../../../global/widgets/app_logo.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetWidget<SplashController> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MySize.screenHeight,
            width: MySize.screenWidth,
            color: AppColor.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Space.height(164),
                // SvgPicture.asset(AppAsset.logoSvg),
                SvgPicture.asset(
                  AppAsset.logoSvg,
                  height: 260,
                  width: 267,
                ),
                // getLogo(),
                Space.height(85),
                // Text(
                //   "Listening is an ART",
                //   style: TextStyle(
                //     fontSize: MySize.size27,
                //     fontWeight: FontWeight.w500,
                //     color: AppColor.white,
                //   ),
                // ),
              ],
            ),
          ),
          Positioned(
            child: Center(
              child: Text(
                "Up Skill",
                style: TextStyle(
                  fontSize: MySize.size45,
                  fontFamily: 'Script',
                  fontWeight: FontWeight.w500,
                  color: AppColor.white,
                ),
              ),
            ),
            bottom: 206,
          )
        ],
      ),
    );
  }
}
