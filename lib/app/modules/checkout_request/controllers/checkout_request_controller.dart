import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_customer/Models/transactionModel.dart';
import 'package:hotel_customer/app/modules/home/controllers/home_controller.dart';
import 'package:hotel_customer/app/modules/home/views/home_view.dart';

import '../../../../Models/OrderDetailModel.dart';
import '../../../../global/constants/apiConstant.dart';
import '../../../../global/constants/app_color.dart';
import '../../../../global/constants/app_sizeConstant.dart';
import '../../../../global/constants/app_string.dart';
import '../../../../global/utils/prefUtils.dart';
import '../../../../global/utils/services/NetworkClient.dart';
import '../../../../global/widgets/button.dart';
import '../../../../global/widgets/custom_dialogs.dart';
import '../../../../global/widgets/text_field.dart';
import '../../../../main.dart';
import '../../../routes/app_pages.dart';

class CheckoutRequestController extends GetxController {
  final count = 0.obs;
  RxBool isRequestSelected = true.obs;
  RxBool isSwitch = false.obs;
  String token = "";
  RxBool hasError = false.obs;
  RxBool isButtonTap = false.obs;
  int invoiceId = 1;
  RxString errorMessage = "Something Went Wrong.".obs;
  RxList<Orders> listData = RxList();
  RxList<Orders> listDataForHistory = RxList();
  RxList<Feedbacks> listFeedbackData = RxList();
  RxList<Transaction> listTransaction = RxList();
  RxBool hasData = false.obs;
  RxBool hasData2 = false.obs;
  Rx<TabBarType> type = TabBarType.request.obs;
  Rx<TextEditingController> idController = TextEditingController().obs;

  RxBool hasDataForPayments = false.obs;
  String roomName = "";
  int roomId = 0;
  int hotelId = 0;
  bool isFromNotification = false;
HomeController homeController=HomeController();
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      roomId = Get.arguments[ArgumentConstant.roomId];
      hotelId = Get.arguments[ArgumentConstant.hotelId];
      isFromNotification = Get.arguments[ArgumentConstant.isFromNotification] ?? false;
      roomName = Get.arguments[ArgumentConstant.roomName] ?? "";
    }
    callApiForGetOrderDetail(context: Get.context!);
    //callApiForGetTransactionDetail(context: Get.context!);
    callApiGorGetToken(context: Get.context!);

  }

  callApiGorGetToken({required BuildContext context}) {
    hasData2.value = false;
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
        hasData2.value = true;
        token = "https://guest.hotelcom.live/signin-with-url/" + response["token"];

        // app.resolve<CustomDialogs>().hideCircularDialog(context);

        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        hasData2.value = true;
        hasError.value = true;
        errorMessage.value = status["message"];

        // app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getDialog(title: "Oops", desc: status["message"]);
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
        Get.offAllNamed(Routes.HOME, arguments: {ArgumentConstant.isFromRefresh: true});
        Get.snackbar(
          "Success",
          "$roomName Checkedin!",
          backgroundColor: AppColor.white,
        );

        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  callApiForSendInvoice({required BuildContext context}) {
    FocusScope.of(context).unfocus();
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["invoiceId"] = invoiceId;
    dict["email"] = idController.value.text;
    // GetStorage box = GetStorage();

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "invoices/guest/share",
      MethodType.Post,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        Get.offAllNamed(Routes.HOME, arguments: {ArgumentConstant.isFromRefresh: true});
        Get.snackbar(
          "Success",
          "Invoice Sent Successfully.",
          backgroundColor: AppColor.white,
        );

        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  asyncConfirmDialog() async {
    return showDialog(
      context: Get.context!,

      // barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: MySize.size30!),
          title: Text('For Tax Invoice'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              commonTextField(controller: idController.value, needValidation: true, fbColor: AppColor.primary, validationMessage: "Enter Email Id", hintText: "Enter Email Id"),
              Space.height(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // Get.back();
                      Get.offAllNamed(Routes.HOME, arguments: {ArgumentConstant.isFromRefresh: true});
                    },
                    child: button(height: 35, width: 80, title: "Skip", textColor: AppColor.primary, backgroundColor: AppColor.white, borderColor: AppColor.white),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      callApiForSendInvoice(context: Get.context!);
                    },
                    child: button(
                      height: 40,
                      width: 100,
                      // title: "Yes",
                      widget: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            color: AppColor.white,
                          ),
                          Space.width(10),
                          Text(
                            "Share",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
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
        Get.offAllNamed(Routes.HOME, arguments: {ArgumentConstant.isFromRefresh: true});
        Get.snackbar(
          "Success",
          "$roomName Checkedin Cancel!",
          backgroundColor: AppColor.white,
        );

        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  callApiForGetOrderDetail({required BuildContext context}) {
    hasData.value = false;
    FocusScope.of(context).unfocus();
    // app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    List a = [];
    List b = [];

    if (!isNullEmptyOrFalse(box.read(Constant.category))) {
      a = box.read(Constant.category);
    } else {
      a = [];
    }
    dict["sections"] = a.map((e) => int.parse(e.toString())).toList().where((element) => element != 5).toList();
    if (a.contains(5)) {
      dict["feedbackes"] = true;
    } else {
      dict["feedbackes"] = false;
    }
    // GetStorage box = GetStorage();
    listData.clear();
    listDataForHistory.clear();
    listFeedbackData.clear();
    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      // "${ApiConstant.orderRooms}${roomId}",
      "orders/hotels/rooms/${roomId}",
      MethodType.Post,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        debugPrint("---------->---------> + $response");
        hasData.value = true;

        // app.resolve<CustomDialogs>().hideCircularDialog(context);
        OrderDetailModel allRoomsModel = OrderDetailModel.fromJson(response);
        if (allRoomsModel != null && !isNullEmptyOrFalse(allRoomsModel.data!.orders)) {
          allRoomsModel.data!.orders!.forEach((element) {
            if (element.status == OrderStatus.Pending || element.status == OrderStatus.Confirmed) {
              listData.add(element);
            } else {
              listDataForHistory.add(element);
            }
          });
        }
        if (allRoomsModel != null && !isNullEmptyOrFalse(allRoomsModel.data!.feedbacks)) {
          allRoomsModel.data!.feedbacks!.forEach((element) {
            listFeedbackData.add(element);
          });
        }
        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        hasData.value = true;

        // app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  /*callApiForGetTransactionDetail(
      {required BuildContext context, String status = "Pending"}) {
    hasDataForPayments.value = false;
    listTransaction.clear();

    FocusScope.of(context).unfocus();
    // app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    List a = [];
    List b = [];

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "${ApiConstant.transactionRooms}${roomId}?status=$status",
      // "orders/hotels/rooms/${roomId}",
      MethodType.Get,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasDataForPayments.value = true;

        // app.resolve<CustomDialogs>().hideCircularDialog(context);
        TransactionModel allRoomsModel = TransactionModel.fromJson(response);
        if (allRoomsModel != null && !isNullEmptyOrFalse(allRoomsModel.data)) {
          allRoomsModel.data!.forEach((element) {
            listTransaction.add(element);
          });
        }

        //otpController.value.text = "";
      },
      */ /*failureCallback: (status, message) {
        hasDataForPayments.value = true;

        // app.resolve<CustomDialogs>().hideCircularDialog(context);
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },*/ /*
    );
  }*/

  callApiForChangeOrderStatus({required BuildContext context, bool accepted = true, int id = 1}) {
    FocusScope.of(context).unfocus();
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["isApproved"] = accepted;
    // GetStorage box = GetStorage();

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "orders/hotels/approve/orders/$id",
      MethodType.Patch,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        callApiForGetOrderDetail(context: context);

        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  callApiForChangeOrderStatusToComplete({required BuildContext context, bool accepted = true, int id = 1}) {
    FocusScope.of(context).unfocus();
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    // GetStorage box = GetStorage()
    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "orders/completed/$id",
      MethodType.Patch,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        callApiForGetOrderDetail(context: context);

        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  callApiForChangePaymentStatus({required BuildContext context, bool accepted = true, int id = 1}) {
    FocusScope.of(context).unfocus();
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    // dict["isApproved"] = accepted;
    // GetStorage box = GetStorage();

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "transactions/paid/rooms/$roomId",
      MethodType.Patch,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        // callApiForGetTransactionDetail(context: Get.context!);
        isButtonTap.value = true;

        Get.back();

        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  callApiForCheckOutApi({required BuildContext context}) {
    FocusScope.of(context).unfocus();
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["roomId"] = roomId;
    // GetStorage box = GetStorage();

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "rooms/confirm/checkout/id/$roomId",
      MethodType.Patch,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        invoiceId = (response as Map<String, dynamic>)["invoiceId"];
        print(invoiceId.toString());
        // Get.offAllNamed(Routes.HOME,
        //     arguments: {ArgumentConstant.isFromRefresh: true});
        //asyncConfirmDialog();

        Get.snackbar(
          "Success",
          "$roomName CheckedOut!",
          backgroundColor: AppColor.white,
        );
        Get.offAllNamed(Routes.HOME,
            arguments: {ArgumentConstant.isFromRefresh: true});
       //Get.to(HomeView());


        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  callApiForDoneFeedback({required BuildContext context, int id = 1}) {
    FocusScope.of(context).unfocus();
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    // dict["roomId"] = roomId;
    // GetStorage box = GetStorage();

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "guests/feedbacks/id/$id",
      MethodType.Patch,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        callApiForGetOrderDetail(context: Get.context!);

        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app.resolve<CustomDialogs>().getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}

enum TabBarType { request, history, payment, checkout }
