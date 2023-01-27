import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotel_customer/app/routes/app_pages.dart';

import '../../../../global/constants/apiConstant.dart';
import '../../../../global/utils/services/NetworkClient.dart';
import '../../../../global/widgets/custom_dialogs.dart';
import '../../../../main.dart';

class ForgetPasswordController extends GetxController {
  //TODO: Implement ForgetPasswordController

  final count = 0.obs;
  Rx<TextEditingController> idController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
    dict["email"] = idController.value.text;
    // dict["password"] = passwordController.value.text;
    // print(token);

    return NetworkClient.getInstance.callApi(
      context,
      authUrl,
      ApiConstant.passwordForget,
      MethodType.Post,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getConfirmDialog(
            title: "Success",
            desc: "Forger password link successfully sent to respected mail.",
            onTap: () {
              Get.offAllNamed(Routes.LOGIN);
            });
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
