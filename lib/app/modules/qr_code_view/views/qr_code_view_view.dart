import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotel_customer/global/constants/app_asset.dart';
import 'package:hotel_customer/global/constants/app_color.dart';
import 'package:hotel_customer/global/constants/app_sizeConstant.dart';
import 'package:hotel_customer/global/widgets/appbar.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../global/widgets/button.dart';
import '../../../../global/widgets/shimmer_widget.dart';
import '../controllers/qr_code_view_controller.dart';

class QrCodeViewView extends GetWidget<QrCodeViewController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          height: MySize.screenHeight,
          width: MySize.screenWidth,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          padding:
              EdgeInsets.symmetric(horizontal: MySize.getScaledSizeWidth(50)),
          child: (controller.hasData.value)
              ? ((controller.hasError.isFalse)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Space.height(84),
                        QrImage(
                          data: controller.token,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        Space.height(70),
                        RichText(
                          // Controls visual overflow
                          overflow: TextOverflow.clip,

                          textAlign: TextAlign.center,

                          // Control the text direction
                          // textDirection: TextDirection.rtl,

                          softWrap: true,

                          // Maximum number of lines for the text to span
                          maxLines: 4,

                          textScaleFactor: 1,
                          text: TextSpan(
                            text: '',
                            style: TextStyle(
                              color: AppColor.primary,
                              fontSize: MySize.size20,
                              fontFamily: 'Satoshi',
                            ),
                            // style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Scan QR code  ',
                                  style: TextStyle(
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.bold,
                                    fontSize: MySize.size20!,
                                  )),
                              TextSpan(
                                  text: '\nto confirm the checkin \nRoom ',
                                  style: TextStyle(
                                    fontFamily: 'Satoshi',

                                    // fontWeight: FontWeight.bold,
                                    fontSize: MySize.size20!,
                                  )),
                              TextSpan(
                                  text: '${controller.roomName}.',
                                  style: TextStyle(
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.bold,
                                      fontSize: MySize.size20!,
                                      color: Color(0xFFFC5012))),
                            ],
                          ),
                        ),
                        Space.height(180),
                        InkWell(
                          onTap: () {
                            // Get.back();
                            controller.callApiFoeGenerateToken(
                                context: Get.context!);
                          },
                          child: button(
                            title: "Confirm checkin",
                            fontsize: 17,
                          ),
                        ),
                        Space.height(30),
                        InkWell(
                          onTap: () {
                            // Get.back();
                            controller.callApiForCancelCheckIn(
                                context: Get.context!);
                          },
                          child: button(
                            title: "Cancel",
                            textColor: AppColor.primary,
                            fontsize: 17,
                            borderColor: AppColor.primary,
                            backgroundColor: AppColor.white,
                          ),
                        ),
                      ],
                    )
                  : Center(child: Text(controller.errorMessage.value)))
              : getShimerForQr(),
        ),
      );
    });
  }
}
