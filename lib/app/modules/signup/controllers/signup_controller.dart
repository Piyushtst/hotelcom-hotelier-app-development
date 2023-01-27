import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_customer/Models/HotelListModel.dart';
import 'package:hotel_customer/Models/logInResponseModel.dart';
import 'package:hotel_customer/Models/signupResponseModel.dart';

import '../../../../global/constants/apiConstant.dart';
import '../../../../global/constants/app_string.dart';
import '../../../../global/utils/prefUtils.dart';
import '../../../../global/utils/services/NetworkClient.dart';
import '../../../../global/widgets/custom_dialogs.dart';
import '../../../../main.dart';
import '../../../routes/app_pages.dart';

class SignupController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> departmentController = TextEditingController().obs;
  Rx<TextEditingController> contactNumberController = TextEditingController().obs;
  Rx<TextEditingController> hotelController = TextEditingController().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isVisible = false.obs;
  RxList<HotelList> hotelList = RxList([]);
  RxList<Data> hotelListName = RxList([]);

  List<String> departmentList = [
    "Restaurant",
    "Housekeeping",
    "Laundary",
    "Extra supplies"
  ];
  List<String> nameData = [
    "mydata"
  ];
  List<HotelListModel> data1 =[];
  RxString selectDepartment = "".obs;
  RxString hotelNameId = "".obs;
  Rx<HotelList> selectHotel = HotelList().obs;

  @override
  void onInit() {
    super.onInit();
    callApiForGetHotelList(context: Get.context!);

  }

  @override
  void onReady() {
    super.onReady();
  }

  callApiForGetHotelList({
    required BuildContext context,
  }) {
    debugPrint("-=-=-=-callGetMeApi=-=-");
    debugPrint("-=-=-=-callGetMeApi=-=-${baseURL}");
    debugPrint("-=-=-=-callGetMeApi=-=-${ApiConstant.getMe}");
    debugPrint(
        "-=-=-=-callGetMeApi=-=-${NetworkClient.getInstance.getAuthHeaders()}");

    FocusScope.of(context).unfocus();

    Map<String, dynamic> dict = {};

    return NetworkClient.getInstance.callApi(
      context,
      baseURL,
      ApiConstant.getHotels,
      MethodType.Get,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        debugPrint("-=-=-=-response=-=-successCallback + $response");

        HotelListModel hotels = HotelListModel.fromJson(response);
        if (hotels != null && !isNullEmptyOrFalse(hotels.data)) {
          hotelList.value = hotels.data!.cast<HotelList>();
        /*  hotels.data!.forEach((element) {
            hotelList.add(element);
          });*/
        }
        for (var element in hotelList) {
          print(element.toJson());
        }
        hotelList.refresh();

      },
      failureCallback: (status, message) {
        debugPrint("-=-=-=-callGetMeApi=-=-failureCallback");
      },
    );
  }

  callApiForSignup({required BuildContext context}) {
    FocusScope.of(context).unfocus();
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {
      //"hotel":hotelController.value.text.trim(),
     // "hotelId": hotelController.value.text.trim(),// selectHotel.value.id,
      "hotelId": hotelNameId.value.trim(),// selectHotel.value.id,
      "department": departmentController.value.text.trim(),
      "name": nameController.value.text.trim(),
      "contactNo": contactNumberController.value.text.trim(),
      "email": emailController.value.text.trim(),
      "password": passwordController.value.text.trim(),



    };
    // GetStorage box = GetStorage();
    // dict["email"] = nameController.value.text.trim();
    // dict["password"] = passwordController.value.text.trim();

    debugPrint("-=-=-=-$dict");

    // print(token);

    return NetworkClient.getInstance.callApi(
      context,
      authUrl,
      ApiConstant.signupApi,
      MethodType.Post,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        // SignupResponseModel authModel = SignupResponseModel.fromJson(response);
        //otpController.value.text = "";

        debugPrint("-=-=-response=-=-$response");

        Get.back();

        app.resolve<CustomDialogs>().getDialog(
              title: "Success",
              desc: "Your request will be accepted\n by the Hotel soon...",
              // desc: response["message"],
            );

        // box.write(Constant.tokenKey, authModel.data.);
        // box.write(Constant.hotelId, authModel.data!.hotelId);

        // callApiForLogin(context: Get.context!);

        // Get.offAllNamed(Routes.HOME);
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

  callApiForLogin({required BuildContext context}) {
    FocusScope.of(context).unfocus();
    app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    // GetStorage box = GetStorage();
    dict["email"] = emailController.value.text.trim();
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

  callApiSearch({required BuildContext context}) {
    //FocusScope.of(context).unfocus();
    //app.resolve<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {
      // selectHotel.value.id,
      "name":hotelController.value.text.trim(),

    };
    // GetStorage box = GetStorage();
    // dict["email"] = nameController.value.text.trim();
    // dict["password"] = passwordController.value.text.trim();

    debugPrint("-=-=-=-$dict");

    // print(token);

    return NetworkClient.getInstance.callApi(
      context,
      authUrl,
      ApiConstant.hotelSearch,
      MethodType.Post,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        //app.resolve<CustomDialogs>().hideCircularDialog(context);
        // SignupResponseModel authModel = SignupResponseModel.fromJson(response);
        //otpController.value.text = "";
        HotelListModel hotelListModel = HotelListModel.fromJson(response);
        if (hotelListModel != null && !isNullEmptyOrFalse(hotelListModel.data)){
          hotelListName.value = hotelListModel.data!.cast<Data>();
          hotelListModel.data!.forEach((element) {
            hotelListName.add(element);
          });
        }for (var element in hotelListName) {
          print(element.toJson());
        }
        hotelListName.refresh();

        debugPrint("-=-=-response=-=-$response");

      //  Get.back();

        /*app.resolve<CustomDialogs>().getDialog(
          title: "Success",
          desc: "Your request will be accepted\n by the Hotel soon...",
          // desc: response["message"],
        );*/

        // box.write(Constant.tokenKey, authModel.data.);
        // box.write(Constant.hotelId, authModel.data!.hotelId);

        // callApiForLogin(context: Get.context!);

        // Get.offAllNamed(Routes.HOME);
      },
      failureCallback: (status, message) {
        //app.resolve<CustomDialogs>().hideCircularDialog(context);

        debugPrint("-=-=-=-=-$status");
        debugPrint("-=-=-=-=-$message");

        /*app
            .resolve<CustomDialogs>()
            //.getDialog(title: "Oops", desc: status["message"]);
        print(" error");
    */  },
    );
  }





}


class HotelListModel {
  int? status;
  int? results;
  List<Data>? data;

  HotelListModel({this.status, this.results, this.data});

  HotelListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;

  Data({this.id, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

