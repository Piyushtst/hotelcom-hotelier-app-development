import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotel_customer/Models/GetAllRoomsModel.dart';
import 'package:hotel_customer/global/constants/app_string.dart';
import 'package:hotel_customer/global/utils/prefUtils.dart';

import '../../../../global/constants/apiConstant.dart';
import '../../../../global/utils/services/NetworkClient.dart';
import '../../../../global/widgets/custom_dialogs.dart';
import '../../../../main.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxList list = [
    "106",
    "207",
    "302",
    "301",
    "453",
    "124",
    "125",
  ].obs;
  RxList<Rooms> reservedRooms = RxList();
  RxList<Rooms> unReservedRooms = RxList();
  RxList<Rooms> mainListData = RxList();
  RxList<Rooms> mainListDataForReserved = RxList();
  Hotel responceGetMeApi = Hotel();
  RxBool hasData = false.obs;
  RxBool hasDataForUnreserved = false.obs;
  RxBool hasFromRefresh = false.obs;

  final count = 0.obs;

  @override
  void onInit() async {
    print("gggggggggggggggggggggggggggggggggggggggggggggggg");
    super.onInit();
    callGetMeApi(context: Get.context!);
    if (Get.arguments != null) {
      hasFromRefresh.value =
          Get.arguments[ArgumentConstant.isFromRefresh] ?? false;
    }
    List a = await box.read(Constant.category);
    callApiGorGetReseredRoom(context: Get.context!);
    if (!hasFromRefresh.value) {
      callApiForSendFCMToken(context: Get.context!);
    }
    callApiGorGetUnReseredRoom(context: Get.context!);
    print(a);
    await Future.delayed(const Duration(minutes: 2));

    Timer.periodic(const Duration(minutes: 5), (timer) {
      callApiGorGetReseredRoom(context: Get.context!);
      callApiGorGetUnReseredRoom(context: Get.context!);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

   callGetMeApi({
    required BuildContext context,
  })  {
    debugPrint("-=-=-=-callGetMeApi=-=-");
    debugPrint("-=-=-=-callGetMeApi=-=-${baseURL}");
    debugPrint("-=-=-=-callGetMeApi=-=-${ApiConstant.getMe}");
    debugPrint("-=-=-=-callGetMeApi=-=-${NetworkClient.getInstance.getAuthHeaders()}");

    FocusScope.of(context).unfocus();

    Map<String, dynamic> dict = {};

    return  NetworkClient.getInstance.callApi(
      context,
      baseURL,
      ApiConstant.getMe,
      MethodType.Get,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        debugPrint("-=-=-=-callGetMeApi=-=-successCallback ${message.toString()}${response} ");
        responceGetMeApi = Hotel.fromJson(response);
      },
      failureCallback: (status, message) {
        debugPrint("-=-=-=-callGetMeApi=-=-failureCallback");
      },
    );
  }

  callApiGorGetReseredRoom({required BuildContext context}) {
    hasData.value = false;
    FocusScope.of(context).unfocus();
    // app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    reservedRooms.clear();
    // mainListDataForReserved.clear();
    // GetStorage box = GetStorage();
    List a = [];
    if (!isNullEmptyOrFalse(box.read(Constant.category))) {
      a = box.read(Constant.category);
    } else {
      a = ["0"];
    }

    print(ApiConstant.allRooms + "?isAvailable=1&sections=${a.join(",")}");

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "${ApiConstant.allRooms}/?isAvailable=0&sections=${(a.isEmpty) ? "[]" : a.join(",").toString()}&feedbacks=${((a.contains(5) || a.contains("5")) ? 1 : 0)}",
      MethodType.Post,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasData.value = true;

        // app.resolve<CustomDialogs>().hideCircularDialog(context);
        AllRoomsModel allRoomsModel = AllRoomsModel.fromJson(response);
        if (allRoomsModel != null && !isNullEmptyOrFalse(allRoomsModel.data)) {
          allRoomsModel.data!.forEach((element) {
            reservedRooms.add(element);
            mainListDataForReserved.add(element);
          });
        }
        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        hasData.value = true;

        // app.resolve<CustomDialogs>().hideCircularDialog(context);
        // app
        //     .resolve<CustomDialogs>()
        //     .getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  callApiForSendFCMToken({
    required BuildContext context,
    num? mobileNo,
    num? charges,
  }) async {
    // hasData.value = false;
    String? fcmToken;
    if (Platform.isAndroid) {
      fcmToken = (await FirebaseMessaging.instance.getToken())!;
    } else if (Platform.isIOS) {
      fcmToken = (await FirebaseMessaging.instance.getToken());
    }

    if (fcmToken != null) {
      print("fcm token >?->-> $fcmToken");
    } else {
      print("fcm token is null");
    }
    FocusScope.of(context).unfocus();
    //app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    GetStorage box = GetStorage();
    // dict["advisor_mobile"] = mobileNo!;
    dict["FcmToken"] = fcmToken!;
    // print("new fcm ---> $fcmToken");
    print(box.read(Constant.hotelId).toString() + "SDsdsd");

    // ignore: use_build_context_synchronously
    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "${ApiConstant.fcmToken}/${box.read(Constant.hotelId)}",
      MethodType.Patch,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        // hasData.value = true;
        // app.resolve<CustomDialogs>().hideCircularDialog(context);
        // //"msg" -> "Campaign Submitted Successfully"
        // app.resolve<CustomDialogs>().getDialog(
        //     title: "Success", desc: "Campaign Submitted Successfully");
        // callApiForGetAllCallHistoryList(context: context);

        // box.write(Constant.tokenKey, response["token"]);
        // showOtp.value = true;
      },
      failureCallback: (status, message) {
        // app.resolve<CustomDialogs>().hideCircularDialog(context);
        // hasData.value = true;
        print(" error");
        // app.resolve<CustomDialogs>().getDialog(title: "Oops", desc: message);
        // print(" error");
      },
    );
  }

  callApiGorGetUnReseredRoom({required BuildContext context}) {
    hasDataForUnreserved.value = false;
    FocusScope.of(context).unfocus();
    // app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    unReservedRooms.clear();

    // GetStorage box = GetStorage();
    List a = [];
    if (!isNullEmptyOrFalse(box.read(Constant.category))) {
      a = box.read(Constant.category);
    } else {
      a = ["0"];
    }

    print(ApiConstant.allRooms + "?isAvailable=0&sections=${a.join(",")}");
    update();

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      "${ApiConstant.allRooms}/?isAvailable=1&sections=${a.join(",").toString()}",
      MethodType.Post,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        update();

        hasDataForUnreserved.value = true;

        // app.resolve<CustomDialogs>().hideCircularDialog(context);
        AllRoomsModel allRoomsModel = AllRoomsModel.fromJson(response);
        if (allRoomsModel != null && !isNullEmptyOrFalse(allRoomsModel.data)) {
          allRoomsModel.data!.forEach((element) {
            unReservedRooms.add(element);
            mainListData.add(element);
          });
        }
        //otpController.value.text = "";
      },
      failureCallback: (status, message) {
        hasDataForUnreserved.value = true;
        update();

        // app.resolve<CustomDialogs>().hideCircularDialog(context);
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Oops", desc: status["message"]);
        print(" error");
      },
    );
  }

  void filterSearchResults(String query) {
    RxList<Rooms> dummySearchList = <Rooms>[].obs;
    mainListData.value.forEach((element) {
      dummySearchList.add(element);
    });
    //dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      RxList<Rooms> dummyListData = <Rooms>[].obs;
      dummySearchList.forEach((item) {
        if (item.roomNo.toString().toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });

      unReservedRooms.clear();
      unReservedRooms.addAll(dummyListData);
      update();

      return;
    } else {
      unReservedRooms.clear();
      unReservedRooms.addAll(mainListData.value);
      update();
    }
  }

  void filterSearchResultsForReserved(String query) {
    RxList<Rooms> dummySearchList = <Rooms>[].obs;
    mainListDataForReserved.value.forEach((element) {
      dummySearchList.add(element);
    });
    //dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      RxList<Rooms> dummyListData = <Rooms>[].obs;
      dummySearchList.forEach((item) {
        if (item.roomNo.toString().toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });

      reservedRooms.clear();
      reservedRooms.addAll(dummyListData);
      update();

      return;
    } else {
      reservedRooms.clear();
      reservedRooms.addAll(mainListDataForReserved.value);
      update();
    }
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
