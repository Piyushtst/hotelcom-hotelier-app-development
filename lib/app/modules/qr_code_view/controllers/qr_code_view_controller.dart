import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotel_customer/app/routes/app_pages.dart';
import 'package:hotel_customer/global/constants/app_string.dart';

import '../../../../global/constants/apiConstant.dart';
import '../../../../global/constants/app_color.dart';
import '../../../../global/utils/services/NetworkClient.dart';
import '../../../../global/widgets/custom_dialogs.dart';
import '../../../../main.dart';

class QrCodeViewController extends GetxController {
  final count = 0.obs;
  RxBool hasData = false.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = "Something Went Wrong.".obs;
  String token = "";
  String roomName = "";
  int roomId = 0;
  int hotelId = 0;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      roomId = Get.arguments[ArgumentConstant.roomId];
      roomName = Get.arguments[ArgumentConstant.roomName];
      hotelId = Get.arguments[ArgumentConstant.hotelId];
    }
    callApiGorGetToken(context: Get.context!);
  }

  @override
  void onReady() {
    super.onReady();
  }

  callApiGorGetToken({required BuildContext context}) {
    hasData.value = false;
    FocusScope.of(context).unfocus();
    // app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["roomId"] = roomId;
    dict["hotelId"] = hotelId;
    // GetStorage box = GetStorage();

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "${ApiConstant.roomToken}",
      MethodType.Post,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;
        token =
            "https://guest.hotelcom.live/signin-with-url/" + response["token"];

        // app.resolve<CustomDialogs>().hideCircularDialog(context);

        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        hasData.value = true;
        hasError.value = true;
        errorMessage.value = status["message"];

        // app.resolve<CustomDialogs>().hideCircularDialog(context);
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  callApiFoeGenerateToken({required BuildContext context}) {
    FocusScope.of(context).unfocus();
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["roomId"] = roomId;
    // GetStorage box = GetStorage();

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "rooms/confirm/checkin/id/$roomId",
      MethodType.Patch,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        Get.offAllNamed(Routes.HOME,
            arguments: {ArgumentConstant.isFromRefresh: true});
        Get.snackbar(
          "Success",
          "$roomName Checkedin!",
          backgroundColor: AppColor.white,
        );

        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  callApiForCancelCheckIn({required BuildContext context}) {
    FocusScope.of(context).unfocus();
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["roomId"] = roomId;
    // GetStorage box = GetStorage();

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "rooms/cancel/checkin/id/$roomId",
      MethodType.Patch,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        Get.offAllNamed(Routes.HOME,
            arguments: {ArgumentConstant.isFromRefresh: true});
        Get.snackbar(
          "Success",
          "$roomName Checkedin Cancel!",
          backgroundColor: AppColor.white,
        );

        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
