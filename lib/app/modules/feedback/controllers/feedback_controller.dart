import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_customer/global/constants/app_asset.dart';

import '../../../../global/constants/apiConstant.dart';
import '../../../../global/utils/services/NetworkClient.dart';
import '../../../../global/widgets/custom_dialogs.dart';
import '../../../../main.dart';

class FeedbackController extends GetxController {
  //TODO: Implement FeedbackController
  Rx<TextEditingController> feedbackController = TextEditingController().obs;

  final count = 0.obs;
  RxDouble ratingValue = 5.0.obs;
  List<String> emogi = [
    AppAsset.r1Png,
    AppAsset.r2Png,
    AppAsset.r3Png,
    AppAsset.r4Png,
    AppAsset.r5Png,
  ];
  @override
  void onInit() {
    super.onInit();
    // ratingValue.value;
  }

  @override
  void onReady() {
    super.onReady();
    // ratingValue.value;
  }

  callApiSubmitFeedback({required BuildContext context}) {
    FocusScope.of(context).unfocus();
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["rating"] = ratingValue.toInt();
    dict["feedback"] = feedbackController.value.text;
    // GetStorage box = GetStorage();

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      ApiConstant.feedbackApi,
      MethodType.Post,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        feedbackController.value.clear();
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getDialog(
            title: "Success", desc: "Feedback submitted successfully.");

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
