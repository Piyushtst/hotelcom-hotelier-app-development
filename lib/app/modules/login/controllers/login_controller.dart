import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_customer/Models/logInResponseModel.dart';

import '../../../../global/constants/apiConstant.dart';
import '../../../../global/constants/app_string.dart';
import '../../../../global/utils/services/NetworkClient.dart';
import '../../../../global/widgets/custom_dialogs.dart';
import '../../../../main.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  Rx<TextEditingController> idController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isVisible = false.obs;

  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onReady() {
    super.onReady();
  }

  callApiForLogin({required BuildContext context}) {
    FocusScope.of(context).unfocus();
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    // GetStorage box = GetStorage();
    dict["email"] = idController.value.text.trim();
    dict["password"] = passwordController.value.text.trim();
    // print(token);

    return NetworkClient.getInstance.callApi(
      context,
      authUrl,
      ApiConstant.loginApi,
      MethodType.Post,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        LoginResponseModel authModel = LoginResponseModel.fromJson(response);
        //otpController.value.text = "";

        box.write(Constant.tokenKey, authModel.token);
        box.write(Constant.hotelId, authModel.hotelierId);
        Get.offAllNamed(Routes.HOME);
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        debugPrint("-=-=-=-=-$status");
        debugPrint("-=-=-=-=-$message");

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
