import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_customer/Models/GetAllRoomsModel.dart';
import 'package:hotel_customer/app/modules/home/controllers/global_controller.dart';
import 'package:hotel_customer/app/routes/app_pages.dart';
import 'package:hotel_customer/global/constants/app_color.dart';
import 'package:hotel_customer/global/constants/app_sizeConstant.dart';
import 'package:hotel_customer/global/constants/app_string.dart';
import 'package:hotel_customer/global/widgets/button.dart';
import 'package:hotel_customer/global/widgets/shimmer_widget.dart';
import 'package:hotel_customer/global/widgets/text_field.dart';
import '../../../../global/constants/app_asset.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            barrierDismissible: false, // user must tap button for close dialog!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Exit App'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Are you sure you want to exit?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MySize.size16!,
                      ),
                    ),
                    Space.height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: button(
                            height: 35,
                            width: 80,
                            title: "No",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            exit(0);
                          },
                          child: button(
                              height: 35,
                              width: 80,
                              title: "Yes",
                              textColor: AppColor.primary,
                              backgroundColor: AppColor.white,
                              borderColor: AppColor.primary),
                        ),
                      ],
                    )
                  ],
                ),
                // actions: <Widget>[
                //   button(
                //     height: 35,
                //     width: 80,
                //     title: "No",
                //   ),
                //   Expanded(child: Container()),
                //   button(
                //       height: 35,
                //       width: 80,
                //       title: "Yes",
                //       textColor: AppColor.primary,
                //       backgroundColor: AppColor.white,
                //       borderColor: AppColor.primary),
                //   // Space.width(3),
                //
                //   // FlatButton(
                //   //   child: const Text(
                //   //     'No',
                //   //     style: TextStyle(
                //   //       color: Colors.white,
                //   //     ),
                //   //   ),
                //   //   color: AppColor.primary,
                //   //   onPressed: () {
                //   //     Navigator.of(context).pop();
                //   //   },
                //   // ),
                //   // FlatButton(
                //   //   child: const Text(
                //   //     'Yes',
                //   //     style: TextStyle(
                //   //       color: AppColor.primary,
                //   //     ),
                //   //     ),
                //   //   ),
                //   //   onPressed: () {
                //   //     exit(0);
                //   //   },
                //   // )
                // ],
              );
            },
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: AppColor.primary,
          body:Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MySize.getScaledSizeWidth(12),
                    vertical: MySize.size10!,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.PROFILE);
                        },
                        child: Image(
                          image: const AssetImage(AppAsset.logoPng),
                          // fit: BoxFit.cover,
                          color: AppColor.white,
                          height: MySize.getScaledSizeHeight(63),
                          width: MySize.getScaledSizeWidth(52),
                        ),
                      ),
                      Space.width(15),
                      Expanded(
                        child: commonTextField(
                          hintText: "Search for Room numbers",
                          hintFontSize: 14,
                          textColor: Colors.white,
                          onChangedValue: (val) {
                            controller.filterSearchResults(
                                val.toString().toLowerCase());
                            controller.filterSearchResultsForReserved(
                                val.toString().toLowerCase());
                          },
                          fbColor: Colors.white,
                        ),
                      ),
                      Space.width(30),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.CHOOSE_CATEGORY);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MySize.size16!,
                          ),
                        ),
                      ),
                      Space.width(15),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: MySize.getScaledSizeWidth(15),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        controller.callApiGorGetReseredRoom(context: context);
                        controller.callApiGorGetUnReseredRoom(context: context);
                      },
                      child:ListView(
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        padding: const EdgeInsets.all(0),
                        children: [
                          Space.height(30),
                          Padding(
                            padding: EdgeInsets.only(left: MySize.size3!),
                            child: Text(
                              "Reserved Rooms",
                              style: TextStyle(
                                color: AppColor.titleGrayColor,
                                fontSize: MySize.size18!,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Space.height(23),
                          (controller.hasData.value)
                              ? (controller.reservedRooms.isNotEmpty)
                                  ? GridView.count(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10.0,
                                      shrinkWrap: true,
                                      childAspectRatio: 0.97,
                                      padding: const EdgeInsets.all(0),
                                      physics: const NeverScrollableScrollPhysics(),
                                      mainAxisSpacing: 10.0,
                                      children:  List.generate(
                                        controller.reservedRooms.length,
                                        (index) {
                                          Rooms r =
                                              controller.reservedRooms[index];
                                          List<ImageModel> listImage = [];
                                          if ((r.restaurantOrder ?? 0) > 0) {
                                            listImage.add(ImageModel(
                                                color: AppColor.red,
                                                img: AppAsset.cookPng));
                                          }
                                          if ((r.laundryOrders ?? 0) > 0) {
                                            listImage.add(ImageModel(
                                                color: AppColor.green,
                                                img: AppAsset.ownPng));
                                          }
                                          if ((r.houseKeepingOrders ?? 0) > 0) {
                                            listImage.add(ImageModel(
                                                color: AppColor.purple,
                                                img: AppAsset.hammerPng));
                                          }
                                          if ((r.extraSupplies ?? 0) > 0) {
                                            listImage.add(ImageModel(
                                                color: AppColor.amber,
                                                img: AppAsset.bagPng));
                                          }
                                          if ((r.feedback ?? 0) > 0) {
                                            listImage.add(ImageModel(
                                                color: AppColor.teal,
                                                img: AppAsset.emogiPng));
                                          }

                                          return InkWell(
                                            onTap: () {
                                              // if (index == 0) {
                                              //   Get.toNamed(Routes.QR_CODE_VIEW);
                                              // } else {

                                              Get.find<GlobalController>().hasFromRoomRefresh.value = true;

                                              Get.toNamed(
                                                  Routes.CHECKOUT_REQUEST,
                                                  arguments: {
                                                    ArgumentConstant.roomId:
                                                        controller
                                                            .reservedRooms[
                                                                index]
                                                            .id,
                                                    ArgumentConstant.roomName:
                                                        controller
                                                            .reservedRooms[
                                                                index]
                                                            .roomNo,
                                                    ArgumentConstant.hotelId:
                                                        controller
                                                            .reservedRooms[
                                                                index]
                                                            .hotelId,
                                                  });
                                              // }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                elevation: 0,
                                                // shadowColor: Colors.grey
                                                //     .withOpacity(0.3),
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      MySize.size10!),
                                                  decoration: BoxDecoration(
                                                    // color:
                                                    //     AppColor.cardGrayColor.withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: AppColor
                                                            .cardBorderGrayColor,
                                                        width: 2),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .reservedRooms[
                                                                index]
                                                            .roomNo
                                                            .toString(),
                                                        style: TextStyle(
                                                          color:
                                                              AppColor.primary,
                                                          fontSize:
                                                              MySize.size22!,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Space.height(7),
                                                      Container(
                                                        height: 2,
                                                        color: AppColor
                                                            .borderGrayColor,
                                                      ),
                                                      Space.height(6),
                                                      Container(
                                                        height: 30,
                                                        width: double.infinity,
                                                        child: Center(
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: List.generate(
                                                                listImage
                                                                    .length,
                                                                (index) => getPositiionWidget(
                                                                    img: listImage[
                                                                            index]
                                                                        .img,
                                                                    color: listImage[
                                                                            index]
                                                                        .color!,
                                                                    position:
                                                                        index *
                                                                            15)),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        "No Rooms Found",
                                        style: TextStyle(
                                          color: AppColor.primary,
                                          fontSize: MySize.size18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                              : getShimerForHome(),
                          Space.height(67),
                          Padding(
                            padding: EdgeInsets.only(left: MySize.size3!),
                            child: Text(
                              "Unreserved Rooms",
                              style: TextStyle(
                                color: AppColor.titleGrayColor,
                                fontSize: MySize.size18!,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Space.height(23),
                          (controller.hasDataForUnreserved.value)
                              ? (controller.unReservedRooms.isNotEmpty)
                                  ? GridView.count(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10.0,
                                      shrinkWrap: true,
                                      childAspectRatio: 0.97,
                                      padding: const EdgeInsets.all(0),
                                      physics: const NeverScrollableScrollPhysics(),
                                      mainAxisSpacing: 10.0,
                                      children: List.generate(
                                        controller.unReservedRooms.length,
                                        (index) {
                                          return InkWell(
                                            onTap: () {
                                              Get.toNamed(Routes.QR_CODE_VIEW,
                                                  arguments: {
                                                    ArgumentConstant.roomId:
                                                        controller
                                                            .unReservedRooms[
                                                                index]
                                                            .id,
                                                    ArgumentConstant.roomName:
                                                        controller
                                                            .unReservedRooms[
                                                                index]
                                                            .roomNo,
                                                    ArgumentConstant.hotelId:
                                                        controller
                                                            .unReservedRooms[
                                                                index]
                                                            .hotelId
                                                  });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                elevation: 0,
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      MySize.size10!),
                                                  decoration: BoxDecoration(
                                                    // color:
                                                    //     AppColor.cardGrayColor.withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: AppColor
                                                            .cardBorderGrayColor,
                                                        width: 2),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .unReservedRooms[
                                                                index]
                                                            .roomNo
                                                            .toString(),
                                                        style: TextStyle(
                                                          color:
                                                              AppColor.primary,
                                                          fontSize:
                                                              MySize.size22!,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        "No Rooms Found",
                                        style: TextStyle(
                                          color: AppColor.primary,
                                          fontSize: MySize.size18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                              : Container(
                                  height: MySize.size200!,
                                  child: Center(
                                    child: getShimerForHome(),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  getPositiionWidget(
      {double position = 20, String? img, Color color = AppColor.primary}) {
    return Positioned(
      left: position,
      child: Container(
        height: MySize.size20,
        width: MySize.size20,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: color, width: 1),
        ),
        child: Center(
          child: Image(
            image: AssetImage(img!),
            // height: MySize.size18,
            width: MySize.size11!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ImageModel {
  String? img;

  ImageModel({this.img, this.color});

  Color? color;
}
