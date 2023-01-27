import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hotel_customer/app/modules/home/controllers/global_controller.dart';
import 'package:hotel_customer/app/modules/home/views/home_view.dart';
import 'package:hotel_customer/app/routes/app_pages.dart';
import 'package:hotel_customer/global/constants/app_asset.dart';
import 'package:hotel_customer/global/constants/app_color.dart';
import 'package:hotel_customer/global/constants/app_string.dart';
import 'package:hotel_customer/global/utils/prefUtils.dart';
import 'package:hotel_customer/global/widgets/appbar.dart';
import 'package:hotel_customer/global/widgets/button.dart';
import 'package:hotel_customer/global/widgets/shimmer_widget.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../Models/OrderDetailModel.dart';
import '../../../../global/constants/app_sizeConstant.dart';
import '../controllers/checkout_request_controller.dart';

class CheckoutRequestView extends GetWidget<CheckoutRequestController> {
  RxList<CheckoutModel> list = [
    CheckoutModel(
        img: AppAsset.cookPng,
        name: "Restaurant",
        color: AppColor.orangeColor,
        productList: [
          ProductModel(
              isAccepted: false.obs,
              productName: "Tea",
              quantity: 2,
              isActive: true.obs),
          ProductModel(
              isAccepted: true.obs,
              productName: "Samosa",
              quantity: 2,
              isActive: false.obs),
        ]),
    CheckoutModel(
        img: AppAsset.ownPng,
        color: AppColor.purple,
        name: "Laundary",
        productList: [
          ProductModel(
              isAccepted: false.obs,
              productName: "Wash",
              quantity: 2,
              isActive: true.obs),
          ProductModel(
              isAccepted: true.obs,
              productName: "Iron",
              quantity: 2,
              isActive: false.obs),
        ]),
    CheckoutModel(
        img: AppAsset.emogiPng,
        color: AppColor.teal,
        name: "Feedback",
        productList: [
          ProductModel(
              isAccepted: false.obs,
              productName: "Wash",
              quantity: 2,
              isActive: true.obs),
          ProductModel(
              isAccepted: true.obs,
              productName: "Washroom",
              quantity: 2,
              isActive: false.obs),
        ]),
    CheckoutModel(
        img: AppAsset.hammerPng,
        color: AppColor.green,
        name: "Housekeeping",
        productList: [
          ProductModel(
              isAccepted: false.obs,
              productName: "Wash",
              quantity: 2,
              isActive: true.obs),
          ProductModel(
              isAccepted: true.obs,
              productName: "Washroom",
              quantity: 2,
              isActive: false.obs),
        ]),
    CheckoutModel(
        img: AppAsset.bagPng,
        color: AppColor.amber,
        name: "Extra-Supplier",
        productList: [
          ProductModel(
              isAccepted: false.obs,
              productName: "Wash",
              quantity: 2,
              isActive: true.obs),
          ProductModel(
              isAccepted: true.obs,
              productName: "Washroom",
              quantity: 2,
              isActive: false.obs),
        ]),
  ].obs;

  Orders? orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          controller.roomName.toString(),
          style: const TextStyle(color: AppColor.white),
        ),
        centerTitle: false,
        backgroundColor: AppColor.primary,
        leadingWidth: 50,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.offAllNamed(Routes.HOME,
                arguments: {ArgumentConstant.isFromRefresh: true});
            Get.find<GlobalController>().hasFromRoomRefresh.value = false;
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back,
              size: 35,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              _asyncConfirmDialog(context);
              // controller.asyncConfirmDialog();
            },
            child: Center(
              child: Text(
                "Checkout",
                style: TextStyle(
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                  fontSize: MySize.size16!,
                ),
              ),
            ),
          ),
          Space.width(20),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(Routes.HOME,
              arguments: {ArgumentConstant.isFromRefresh: true});

          Get.find<GlobalController>().hasFromRoomRefresh.value = false;

          return true;
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MySize.size15!,
          ),
          height: MySize.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Space.height(35),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if (controller.type.value != TabBarType.request) {
                          controller.type.value = TabBarType.request;
                          controller.callApiForGetOrderDetail(context: context);
                        }
                      },
                      child: Text(
                        "Requests",
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight:
                              (controller.type.value == TabBarType.request)
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                          fontSize: MySize.size18!,
                          decoration:
                              (controller.type.value == TabBarType.request)
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                        ),
                      ),
                    ),
                    // Space.width(25),
                    InkWell(
                      onTap: () {
                        if (controller.type.value != TabBarType.history) {
                          controller.type.value = TabBarType.history;
                          controller.callApiForGetOrderDetail(context: context);
                        }
                      },
                      child: Text(
                        "History",
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight:
                              (controller.type.value == TabBarType.history)
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                          fontSize: MySize.size18!,
                          decoration:
                              (controller.type.value == TabBarType.history)
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.type.value != TabBarType.payment) {
                          controller.type.value = TabBarType.payment;
                          controller.callApiForGetOrderDetail(context: context);
                        }
                      },
                      child: Text(
                        "Payments",
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight:
                              (controller.type.value == TabBarType.payment)
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                          fontSize: MySize.size18!,
                          decoration:
                              (controller.type.value == TabBarType.payment)
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                        ),
                      ),
                    ),
                    // Space.width(25),
                    /*InkWell(
                      onTap: () {
                        if (controller.type.value != TabBarType.payment) {
                          controller.type.value = TabBarType.payment;
                        }
                      },
                      child: Text(
                        "Payments",
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight:
                              (controller.type.value == TabBarType.payment)
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                          fontSize: MySize.size18!,
                          decoration:
                              (controller.type.value == TabBarType.payment)
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                        ),
                      ),
                    ),*/
                    // Space.width(25),
                    InkWell(
                      onTap: () {
                        if (controller.type.value != TabBarType.checkout) {
                          controller.type.value = TabBarType.checkout;
                        }
                      },
                      child: Text(
                        "Checkin",
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight:
                              (controller.type.value == TabBarType.checkout)
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                          fontSize: MySize.size18!,
                          decoration:
                              (controller.type.value == TabBarType.checkout)
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                );
              }),
              Space.height(30),
              Obx(() {
                return Expanded(
                  child: (controller.type.value == TabBarType.payment)
                      ? /*Container(
                         *//* child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    (controller.isSwitch.value)
                                        ? "Received payments"
                                        : "Pending payments",
                                    style: TextStyle(
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MySize.size16!,
                                    ),
                                  ),
                                  Space.width(10),
                                  GestureDetector(
                                    onTap: () {
                                      *//**//*controller.isSwitch.toggle();
                                      if (controller.isSwitch.value) {
                                        controller
                                            .callApiForGetTransactionDetail(
                                                context: context,
                                                status: "Paid");
                                      } else {
                                        controller
                                            .callApiForGetTransactionDetail(
                                                context: context);
                                      }*//**//*
                                    },
                                    // child: Image.asset(
                                    //   (controller.isSwitch.value)
                                    //       ? AppAsset.onPng
                                    //       : AppAsset.offPng,
                                    //   height: MySize.size14!,
                                    //   width: MySize.size30!,
                                    // ),
                                    child: SvgPicture.asset(
                                      (controller.isSwitch.value)
                                          ? AppAsset.onSvg
                                          : AppAsset.offSvg,
                                      height: MySize.size40!,
                                      fit: BoxFit.fitHeight,
                                      // width: MySize.size30!,
                                    ),
                                  )
                                  // Switch(
                                  //   value: controller.isSwitch.value,
                                  //   onChanged: (val) {
                                  //     controller.isSwitch.toggle();
                                  //   },
                                  //   activeColor: AppColor.primary,
                                  // ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child:
                                          (controller.hasDataForPayments.value)
                                              ? (controller.listTransaction
                                                      .isNotEmpty)
                                                  ? RefreshIndicator(
                                                      onRefresh: () async {
                                                        controller
                                                            .callApiForGetOrderDetail(
                                                                context: Get
                                                                    .context!);
                                                        if (controller
                                                            .isSwitch.value) {
                                                          controller
                                                              .callApiForGetTransactionDetail(
                                                                  context:
                                                                      context,
                                                                  status:
                                                                      "Paid");
                                                        } else {
                                                          controller
                                                              .callApiForGetTransactionDetail(
                                                                  context:
                                                                      context);
                                                        }
                                                      },
                                                      child: Stack(
                                                        children: [
                                                          ListView.separated(
                                                              itemBuilder:
                                                                  (context, i) {
                                                                return Card(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  elevation: 5,
                                                                  shadowColor: AppColor
                                                                      .cardGrayColor
                                                                      .withOpacity(
                                                                          0.6),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          MySize
                                                                              .size20!,
                                                                      vertical:
                                                                          MySize
                                                                              .size20!,
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        color: AppColor.cardGrayColor.withOpacity(0.6),
                                                                        border: Border.all(
                                                                          color:
                                                                              AppColor.borderGrayColor,
                                                                        )),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    "Item",
                                                                                    style: TextStyle(
                                                                                      color: AppColor.textGrayColor,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontSize: MySize.size16!,
                                                                                    ),
                                                                                  ),
                                                                                  Space.height(10),
                                                                                  Text(
                                                                                    (!isNullEmptyOrFalse(controller.listTransaction[i].order!.houseKeepingItem)) ? controller.listTransaction[i].order!.houseKeepingItem!.name.toString() : controller.listTransaction[i].order!.restaurantItem!.name.toString(),
                                                                                    style: TextStyle(
                                                                                      color: AppColor.primary,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: MySize.size18!,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    "QTY",
                                                                                    style: TextStyle(
                                                                                      color: AppColor.textGrayColor,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontSize: MySize.size16!,
                                                                                    ),
                                                                                  ),
                                                                                  Space.height(10),
                                                                                  Text(
                                                                                    (isNullEmptyOrFalse(controller.listTransaction[i].order!.quantity) || controller.listTransaction[i].order!.quantity == 0) ? "-" : controller.listTransaction[i].order!.quantity.toString(),
                                                                                    style: TextStyle(
                                                                                      color: AppColor.primary,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontSize: MySize.size18!,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                children: [
                                                                                  Text(
                                                                                    "Total",
                                                                                    style: TextStyle(
                                                                                      color: AppColor.textGrayColor,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontSize: MySize.size16!,
                                                                                    ),
                                                                                  ),
                                                                                  Space.height(10),
                                                                                  Text(
                                                                                    (isNullEmptyOrFalse(controller.listTransaction[i].amount) || controller.listTransaction[i].amount == 0) ? "-" : controller.listTransaction[i].amount.toString(),
                                                                                    style: TextStyle(
                                                                                      color: AppColor.primary,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontSize: MySize.size18!,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        // Space.height(
                                                                        //     15),
                                                                        // Container(
                                                                        //   height:
                                                                        //       1,
                                                                        //   width:
                                                                        //       double.infinity,
                                                                        //   color:
                                                                        //       AppColor.cardBorderGrayColor,
                                                                        // ),
                                                                        // Space.height(
                                                                        //     15),
                                                                        // Row(
                                                                        //   mainAxisAlignment:
                                                                        //       MainAxisAlignment.spaceBetween,
                                                                        //   crossAxisAlignment:
                                                                        //       CrossAxisAlignment.center,
                                                                        //   children: [
                                                                        //     Text(
                                                                        //       "Grand Total",
                                                                        //       style: TextStyle(
                                                                        //         color: AppColor.primary,
                                                                        //         fontWeight: FontWeight.bold,
                                                                        //         fontSize: MySize.size18!,
                                                                        //       ),
                                                                        //     ),
                                                                        //     Text(
                                                                        //       controller.listTransaction[i].amount.toString(),
                                                                        //       style: TextStyle(
                                                                        //         color: AppColor.primary,
                                                                        //         fontWeight: FontWeight.bold,
                                                                        //         fontSize: MySize.size18!,
                                                                        //       ),
                                                                        //     ),
                                                                        //   ],
                                                                        // )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              separatorBuilder:
                                                                  (context, i) {
                                                                return Space
                                                                    .height(15);
                                                              },
                                                              itemCount: controller
                                                                  .listTransaction
                                                                  .length),
                                                        ],
                                                      ),
                                                    )
                                                  : RefreshIndicator(
                                                      onRefresh: () async {
                                                        controller
                                                            .callApiForGetOrderDetail(
                                                                context: Get
                                                                    .context!);
                                                        controller
                                                            .callApiForGetTransactionDetail(
                                                                context: Get
                                                                    .context!);
                                                      },
                                                      child: Stack(
                                                        children: [
                                                          const Center(
                                                            child: Text(
                                                                "No Transaction Found."),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                              : getShimerForPayment(),
                                    ),
                                    if (!controller.isSwitch.value)
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
                                          text: 'If received through ',
                                          style: TextStyle(
                                            color: AppColor.primary,
                                            fontSize: MySize.size16,
                                            fontFamily: 'Satoshi',
                                          ),
                                          // style: DefaultTextStyle.of(context).style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Cash',
                                                style: TextStyle(
                                                  fontFamily: 'Satoshi',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MySize.size16!,
                                                )),
                                            TextSpan(
                                                text: ', click ‘paid’.',
                                                style: TextStyle(
                                                  fontFamily: 'Satoshi',

                                                  // fontWeight: FontWeight.bold,
                                                  fontSize: MySize.size20!,
                                                )),
                                          ],
                                        ),
                                      ),
                                    Space.height(10),
                                    if (!controller.isSwitch.value)
                                      Center(
                                        child: InkWell(
                                          child: button(
                                            width: 281,
                                            radius: 10,
                                            title: "Paid",
                                            textColor:
                                                (controller.isButtonTap.isFalse)
                                                    ? AppColor.primary
                                                    : Colors.grey,
                                            fontsize: 18,
                                            borderColor:
                                                (controller.isButtonTap.isFalse)
                                                    ? AppColor.primary
                                                    : Colors.grey,
                                            backgroundColor: Colors.transparent,
                                          ),
                                          onTap: () {
                                            _asyncConfirmDialog(
                                              Get.context!,
                                              onConfirm: () {
                                                if (controller
                                                    .isButtonTap.isFalse) {
                                                  controller
                                                      .callApiForChangePaymentStatus(
                                                    context: Get.context!,
                                                  );
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    // else
                                    //   Center(
                                    //     child: button(
                                    //       width: 281,
                                    //       radius: 10,
                                    //       // title: "Paid",
                                    //       widget: Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.center,
                                    //         children: [
                                    //           Icon(
                                    //             Icons.share,
                                    //             color: AppColor.primary,
                                    //           ),
                                    //           Space.width(10),
                                    //           Text(
                                    //             "Share",
                                    //             style: TextStyle(
                                    //               color: AppColor.primary,
                                    //               fontWeight: FontWeight.bold,
                                    //               fontSize: MySize.size18!,
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       textColor: AppColor.primary,
                                    //       fontsize: 18,
                                    //       borderColor: AppColor.primary,
                                    //       backgroundColor: Colors.transparent,
                                    //     ),
                                    //   ),
                                    Space.height(30),
                                  ],
                                ),
                              ),
                            ],
                          ),*//*
                        )*/
                  payment(context)
                      : (controller.type.value == TabBarType.request ||
                              controller.type.value == TabBarType.history)
                          ? getRequestTab(context)
                          : Container(
                              //height: MySize.screenHeight,
                              width: MySize.screenWidth,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: MySize.getScaledSizeWidth(50)),
                              child: (controller.hasData2.value)
                                  ? ((controller.hasError.isFalse)
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Space.height(20),
                                            QrImage(
                                              data: controller.token,
                                              version: QrVersions.auto,
                                              size: 200.0,
                                            ),
                                            Space.height(50),
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            MySize.size20!,
                                                      )),
                                                  TextSpan(
                                                      text:
                                                          '\nto confirm the checkin \nRoom ',
                                                      style: TextStyle(
                                                        fontFamily: 'Satoshi',

                                                        // fontWeight: FontWeight.bold,
                                                        fontSize:
                                                            MySize.size20!,
                                                      )),
                                                  TextSpan(
                                                      text:
                                                          '${controller.roomName}.',
                                                      style: TextStyle(
                                                        fontFamily: 'Satoshi',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            MySize.size20!,
                                                        color: const Color(
                                                            0xFFFC5012),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            // Space.height(70),
                                            // InkWell(
                                            //   onTap: () {
                                            //     // Get.back();
                                            //     controller
                                            //         .callApiFoeGenerateToken(
                                            //             context: Get.context!);
                                            //   },
                                            //   child: button(
                                            //     title: "Confirm checkin",
                                            //     fontsize: 17,
                                            //   ),
                                            // ),
                                            // Space.height(30),
                                            // InkWell(
                                            //   onTap: () {
                                            //     // Get.back();
                                            //     controller.callApiForCancelCheckIn(
                                            //         context: Get.context!);
                                            //   },
                                            //   child: button(
                                            //     title: "Cancel",
                                            //     textColor: AppColor.primary,
                                            //     fontsize: 17,
                                            //     borderColor: AppColor.primary,
                                            //     backgroundColor: AppColor.white,
                                            //   ),
                                            // ),
                                          ],
                                        )
                                      : Center(
                                          child: Text(
                                              controller.errorMessage.value)))
                                  : getShimerForQrInner(),
                            ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  RefreshIndicator getRequestTab(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.callApiForGetOrderDetail(context: Get.context!);
        if (controller.isSwitch.value) {
         /* controller.callApiForGetTransactionDetail(
              context: context, status: "Paid");*/
        } else {
         // controller.callApiForGetTransactionDetail(context: context);
        }
      },
      child: ListView(
        children: [
          (controller.hasData.value)
              ? (controller.listFeedbackData.isNotEmpty)
                  ? GroupedListView<dynamic, String>(
                      elements: (controller.type.value == TabBarType.history)
                          ? controller.listFeedbackData.value
                              .where((element) => element.isRead == true)
                              .toList()
                          : controller.listFeedbackData.value
                              .where((element) => element.isRead == false)
                              .toList(),

                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      groupBy: (element) => element.type,
                      groupComparator: (value1, value2) =>
                          value2.compareTo(value1),
                      itemComparator: (item1, item2) =>
                          (item1.type).compareTo(item2.type),
                      order: GroupedListOrder.ASC,
                      // useStickyGroupSeparators: true,
                      groupSeparatorBuilder: (String value) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.only(
                          top: MySize.size20!,
                          bottom: MySize.size5!,
                        ),
                        shadowColor: AppColor.cardGrayColor.withOpacity(0.6),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            //horizontal: MySize.size20!,
                            top: MySize.size17!,
                            bottom: MySize.size17!,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.cardGrayColor.withOpacity(0.6),
                            border: Border.all(
                              color: AppColor.borderGrayColor,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MySize.size20!,
                              // vertical: MySize.size20!,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                    list[getIndexOftitle(type: value)].img!,
                                  ),
                                  width: MySize.size23,
                                  height: MySize.size25,
                                  color:
                                      list[getIndexOftitle(type: value)].color!,
                                  fit: BoxFit.fitHeight,
                                ),
                                Space.width(15),
                                Text(
                                  list[getIndexOftitle(type: value)]
                                      .name
                                      .toString(),
                                  style: TextStyle(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: MySize.size18!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemBuilder: (c, element) {
                        Feedbacks hData = element;

                        Orders? orders;
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: MySize.size20!,
                            vertical: MySize.size17!,
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: MySize.size4!,
                              vertical: MySize.size5!),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.cardGrayColor.withOpacity(0.6),
                              border: Border.all(
                                color: AppColor.borderGrayColor,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      hData.feedback.toString(),
                                      style: TextStyle(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: MySize.size18!,
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                      getRattingImage(r: hData.rating ?? 1),
                                      height: MySize.size35!,
                                      width: MySize.size80!)
                                ],
                              ),
                              Space.height(10),
                              Row(
                                children: [
                                  Text(
                                    DateFormat('dd MMM HH:mm a').format(
                                        getDateFromString(
                                                hData.createdAt.toString())
                                            .toLocal()),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  if (controller.type.value !=
                                      TabBarType.history)
                                    InkWell(
                                      child: button(
                                        width: 70,
                                        height: 35,
                                        radius: 10,
                                        title: "Done",
                                        textColor: AppColor.primary,
                                        fontsize: 18,
                                        borderColor: AppColor.primary,
                                        backgroundColor: Colors.transparent,
                                      ),
                                      onTap: () {
                                        controller.callApiForDoneFeedback(
                                            context: Get.context!,
                                            id: element.id);
                                      },
                                    ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Container()
              : Center(
                  child: Container(),
                ),
          (controller.hasData.value)
              ? ((controller.type.value == TabBarType.history)
                      ? controller.listDataForHistory.value.isNotEmpty
                      : controller.listData.value.isNotEmpty)
                  ? GroupedListView<dynamic, String>(
                      elements: (controller.type.value == TabBarType.history)
                          ? controller.listDataForHistory.value
                          : controller.listData.value,

                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      groupBy: (element) => element.type,
                      groupComparator: (value1, value2) =>
                          value2.compareTo(value1),
                      itemComparator: (item1, item2) =>
                          (item1.type).compareTo(item2.type),
                      order: GroupedListOrder.ASC,
                      // useStickyGroupSeparators: true,
                      groupSeparatorBuilder: (String value) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.only(
                          top: MySize.size20!,
                          bottom: MySize.size5!,
                        ),
                        shadowColor: AppColor.cardGrayColor.withOpacity(0.6),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            //horizontal: MySize.size20!,
                            top: MySize.size17!,
                            bottom: MySize.size17!,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.cardGrayColor.withOpacity(0.6),
                            border: Border.all(
                              color: AppColor.borderGrayColor,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MySize.size20!,
                              // vertical: MySize.size20!,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                    list[getIndexOftitle(type: value)].img!,
                                  ),
                                  width: MySize.size23,
                                  height: MySize.size15,
                                  color:
                                      list[getIndexOftitle(type: value)].color!,
                                  fit: BoxFit.fitHeight,
                                ),
                                Space.width(15),
                                Text(
                                  list[getIndexOftitle(type: value)]
                                      .name
                                      .toString(),
                                  style: TextStyle(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: MySize.size18!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemBuilder: (c, element) {
                        Orders hData = element;

                        if (hData.type == OrderType.Restaurant) {
                          return getHouseKeepingContainer(
                            hData.restaurantItem!,
                            status: hData.status ?? "Pending",
                            id: hData.id ?? 1,
                            qty: (isNullEmptyOrFalse(hData.quantity))
                                ? 0
                                : hData.quantity ?? 0,
                            orders: hData,
                          );
                        } else if (hData.type == OrderType.ExtraSupplies ||
                            hData.type == OrderType.Laundry ||
                            hData.type == OrderType.Housekeeping) {
                          return getHouseKeepingContainer(
                            hData.houseKeepingItem!,
                            status: hData.status ?? "Pending",
                            id: hData.id ?? 1,
                            type: hData.type ?? "",
                            qty: (isNullEmptyOrFalse(hData.quantity))
                                ? 0
                                : hData.quantity ?? 0,
                            orders: hData,
                          );
                        }
                        // else if (hData.type ==
                        //     OrderType.ExtraSupplies) {
                        //   return getLaundryContainer(
                        //       hData.houseKeepingItem!,
                        //       qty: (isNullEmptyOrFalse(
                        //               hData.quantity))
                        //           ? 0
                        //           : hData.quantity ?? 0);
                        // }
                        return InkWell(
                          onTap: () {},
                          child: const Text(""),
                        );
                      },
                    )
                  : (controller.listFeedbackData.isEmpty &&
                          ((controller.type.value == TabBarType.history)
                              ? controller.listDataForHistory.isEmpty
                              : controller.listData.isEmpty))
                      ? Container(
                          height: MySize.getScaledSizeHeight(500),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAsset.noDataPng,
                                  width: 166,
                                  height: 190,
                                ),
                                Space.height(10),
                                const Text(
                                  "No requests received yet!",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container():
            (controller.hasData.value)
              ? ((controller.type.value == TabBarType.payment)
                      ? controller.listDataForHistory.value.isNotEmpty
                      : controller.listData.value.isNotEmpty)
                  ? GroupedListView<dynamic, String>(
                      elements: (controller.type.value == TabBarType.payment)
                          ? controller.listDataForHistory.value
                          : controller.listData.value,

                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      groupBy: (element) => element.type,
                      groupComparator: (value1, value2) =>
                          value2.compareTo(value1),
                      itemComparator: (item1, item2) =>
                          (item1.type).compareTo(item2.type),
                      order: GroupedListOrder.ASC,
                      // useStickyGroupSeparators: true,
                      groupSeparatorBuilder: (String value) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.only(
                          top: MySize.size20!,
                          bottom: MySize.size5!,
                        ),
                        shadowColor: AppColor.cardGrayColor.withOpacity(0.6),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            //horizontal: MySize.size20!,
                            top: MySize.size17!,
                            bottom: MySize.size17!,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.cardGrayColor.withOpacity(0.6),
                            border: Border.all(
                              color: AppColor.borderGrayColor,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MySize.size20!,
                              // vertical: MySize.size20!,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                    list[getIndexOftitle(type: value)].img!,
                                  ),
                                  width: MySize.size23,
                                  height: MySize.size15,
                                  color:
                                      list[getIndexOftitle(type: value)].color!,
                                  fit: BoxFit.fitHeight,
                                ),
                                Space.width(15),
                                Text(
                                  list[getIndexOftitle(type: value)]
                                      .name
                                      .toString(),
                                  style: TextStyle(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: MySize.size18!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemBuilder: (c, element) {
                        Orders hData = element;

                        if (hData.type == OrderType.Restaurant) {
                          return getHouseKeepingContainer(
                            hData.restaurantItem!,
                            status: hData.status ?? "Pending",
                            id: hData.id ?? 1,
                            qty: (isNullEmptyOrFalse(hData.quantity))
                                ? 0
                                : hData.quantity ?? 0,
                            orders: hData,
                          );
                        } else if (hData.type == OrderType.ExtraSupplies ||
                            hData.type == OrderType.Laundry ||
                            hData.type == OrderType.Housekeeping) {
                          return getHouseKeepingContainer(
                            hData.houseKeepingItem!,
                            status: hData.status ?? "Pending",
                            id: hData.id ?? 1,
                            type: hData.type ?? "",
                            qty: (isNullEmptyOrFalse(hData.quantity))
                                ? 0
                                : hData.quantity ?? 0,
                            orders: hData,
                          );
                        }
                        // else if (hData.type ==
                        //     OrderType.ExtraSupplies) {
                        //   return getLaundryContainer(
                        //       hData.houseKeepingItem!,
                        //       qty: (isNullEmptyOrFalse(
                        //               hData.quantity))
                        //           ? 0
                        //           : hData.quantity ?? 0);
                        // }
                        return InkWell(
                          onTap: () {},
                          child: const Text(""),
                        );
                      },
                    )
                  : (controller.listFeedbackData.isEmpty &&
                          ((controller.type.value == TabBarType.history)
                              ? controller.listDataForHistory.isEmpty
                              : controller.listData.isEmpty))
                      ? Container(
                          height: MySize.getScaledSizeHeight(500),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAsset.noDataPng,
                                  width: 166,
                                  height: 190,
                                ),
                                Space.height(10),
                                const Text(
                                  "No requests received yet!",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container()
              : getShimerForRequest()
        ],
      ),
    );
  }

  RefreshIndicator payment(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.callApiForGetOrderDetail(context: Get.context!);
        if (controller.isSwitch.value) {
         /* controller.callApiForGetTransactionDetail(
              context: context, status: "Paid");*/
        } else {
         // controller.callApiForGetTransactionDetail(context: context);
        }
      },
      child: ListView(
        children: [
            (controller.hasData.value)
              ? ((controller.type.value == TabBarType.payment)
                      ? controller.listDataForHistory.value.isNotEmpty
                      : controller.listData.value.isNotEmpty)
                  ? GroupedListView<dynamic, String>(
                      elements: (controller.type.value == TabBarType.payment)
                          ? controller.listDataForHistory.value
                          : controller.listData.value,

                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      groupBy: (element) => element.type,
                      groupComparator: (value1, value2) =>
                          value2.compareTo(value1),
                      itemComparator: (item1, item2) =>
                          (item1.type).compareTo(item2.type),
                      order: GroupedListOrder.ASC,
                      // useStickyGroupSeparators: true,
                      groupSeparatorBuilder: (String value) => /*Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.only(
                          top: MySize.size20!,
                          bottom: MySize.size5!,
                        ),
                        shadowColor: AppColor.cardGrayColor.withOpacity(0.6),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            //horizontal: MySize.size20!,
                            top: MySize.size17!,
                            bottom: MySize.size17!,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.cardGrayColor.withOpacity(0.6),
                            border: Border.all(
                              color: AppColor.borderGrayColor,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MySize.size20!,
                              // vertical: MySize.size20!,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                    list[getIndexOftitle(type: value)].img!,
                                  ),
                                  width: MySize.size23,
                                  height: MySize.size15,
                                  color:
                                      list[getIndexOftitle(type: value)].color!,
                                  fit: BoxFit.fitHeight,
                                ),
                                Space.width(15),
                                Text(
                                  list[getIndexOftitle(type: value)]
                                      .name
                                      .toString(),
                                  style: TextStyle(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: MySize.size18!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )*/Container(),
                      itemBuilder: (c, element) {
                        Orders hData = element;
                        if (hData.type == OrderType.Restaurant) {
                          return getHouseKeepingContainer(
                            hData.restaurantItem!,
                            status: hData.status ?? "Pending",
                            id: hData.id ?? 1,
                            qty: (isNullEmptyOrFalse(hData.quantity))
                                ? 0
                                : hData.quantity ?? 0,
                            orders: hData,
                          );
                        } else if (hData.type == OrderType.ExtraSupplies ||
                            hData.type == OrderType.Laundry ||
                            hData.type == OrderType.Housekeeping) {
                          return getHouseKeepingContainer(
                            hData.houseKeepingItem!,
                            status: hData.status ?? "Pending",
                            id: hData.id ?? 1,
                            type: hData.type ?? "",
                            qty: (isNullEmptyOrFalse(hData.quantity))
                                ? 0
                                : hData.quantity ?? 0,
                            orders: hData,
                          );
                        }else if (hData.type == OrderType.Restaurant) {
                          return getHouseKeepingContainer(
                            hData.restaurantItem!,
                            status: hData.status ?? "Pending",
                            id: hData.id ?? 1,
                            qty: (isNullEmptyOrFalse(hData.price))
                                ? 0
                                : hData.price ?? 0,
                            orders: hData,
                          );
                        }
                        // else if (hData.type ==
                        //     OrderType.ExtraSupplies) {
                        //   return getLaundryContainer(
                        //       hData.houseKeepingItem!,
                        //       qty: (isNullEmptyOrFalse(
                        //               hData.quantity))
                        //           ? 0
                        //           : hData.quantity ?? 0);
                        // }
                        return InkWell(
                          onTap: () {},
                          child: const Text(""),
                        );
                      },
                    )
                  : (controller.listFeedbackData.isEmpty &&
                          ((controller.type.value == TabBarType.history)
                              ? controller.listDataForHistory.isEmpty
                              : controller.listData.isEmpty))
                      ? Container(
                          height: MySize.getScaledSizeHeight(500),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAsset.noDataPng,
                                  width: 166,
                                  height: 190,
                                ),
                                Space.height(10),
                                const Text(
                                  "No requests received yet!",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container()
              : getShimerForRequest()
        ],
      ),
    );
  }

  Widget getHouseKeepingContainer(
    RestaurantItem item, {
    String status = OrderStatus.Pending,
    int id = 1,
    qty = 0,
    String type = OrderType.Restaurant,
    Orders? orders,


  }

  ) {
    if (status == OrderStatus.Pending &&
        controller.type.value == TabBarType.request) {
      return
          // (type == OrderType.Housekeeping)
          //   ? Container(
          //       padding: EdgeInsets.symmetric(
          //         horizontal: MySize.size18!,
          //         vertical: MySize.size17!,
          //       ),
          //       margin: EdgeInsets.symmetric(
          //           horizontal: MySize.size4!, vertical: MySize.size5!),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           color: AppColor.cardGrayColor.withOpacity(0.6),
          //           border: Border.all(
          //             color: AppColor.borderGrayColor,
          //           )),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "Item",
          //                     style: TextStyle(
          //                       color: AppColor.textGrayColor,
          //                       fontWeight: FontWeight.normal,
          //                       fontSize: MySize.size16!,
          //                     ),
          //                   ),
          //                   Space.height(10),
          //                   Text(
          //                     item.name.toString(),
          //                     style: TextStyle(
          //                       color: AppColor.primary,
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: MySize.size16!,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               Column(
          //                 crossAxisAlignment: CrossAxisAlignment.end,
          //                 children: [
          //                   Text(
          //                     "QTY",
          //                     style: TextStyle(
          //                       color: AppColor.textGrayColor,
          //                       fontWeight: FontWeight.normal,
          //                       fontSize: MySize.size16!,
          //                     ),
          //                   ),
          //                   Space.height(10),
          //                   Text(
          //                     (isNullEmptyOrFalse(qty) || qty == 0)
          //                         ? "-"
          //                         : qty.toString(),
          //                     style: TextStyle(
          //                       color: AppColor.primary,
          //                       fontWeight: FontWeight.normal,
          //                       fontSize: MySize.size16!,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             ],
          //           ),
          //           Space.height(10),
          //           Text(
          //             DateFormat('dd MMM HH:mm a')
          //                 .format(getDateFromString(item.createdAt.toString())),
          //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          //           )
          //         ],
          //       ),
          //     )
          //   :
          Container(
        padding: EdgeInsets.symmetric(horizontal: MySize.size5!),
        margin: const EdgeInsets.only(
          bottom: 10,
          top: 5,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: MySize.size18!,
                vertical: MySize.size17!,
              ),
              decoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: AppColor.primary,
                ),
                right: BorderSide(
                  color: AppColor.primary,
                ),
                left: BorderSide(
                  color: AppColor.primary,
                ),
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Item",
                            style: TextStyle(
                              color: AppColor.textGrayColor,
                              fontWeight: FontWeight.normal,
                              fontSize: MySize.size16!,
                            ),
                          ),
                          Space.height(10),
                          Text(
                            item.name.toString(),
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: MySize.size16!,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "QTY",
                            style: TextStyle(
                              color: AppColor.textGrayColor,
                              fontWeight: FontWeight.normal,
                              fontSize: MySize.size16!,
                            ),
                          ),
                          Space.height(10),
                          Text(
                            (isNullEmptyOrFalse(qty) || qty == 0)
                                ? "-"
                                : qty.toString(),
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.normal,
                              fontSize: MySize.size16!,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: MySize.size20!,
                vertical: MySize.size17!,
              ),
              decoration: BoxDecoration(
                color: AppColor.white,

                //  borderRadius: BorderRadius.circular(46),
                border: Border.all(color: AppColor.primary),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(MySize.size15!),
                  bottomRight: Radius.circular(MySize.size15!),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: Get.context!,
                          barrierDismissible:
                              false, // user must tap button for close dialog!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  'Reject Order (${item.name.toString()})'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Are you sure you want to reject order?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: MySize.size16!,
                                    ),
                                  ),
                                  Space.height(20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: button(
                                            height: 35,
                                            width: 80,
                                            title: "No",
                                            textColor: AppColor.primary,
                                            backgroundColor: AppColor.white,
                                            borderColor: AppColor.primary),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                          controller
                                              .callApiForChangeOrderStatus(
                                                  context: Get.context!,
                                                  accepted: false,
                                                  id: id);
                                        },
                                        child: button(
                                          height: 35,
                                          width: 80,
                                          title: "Yes",
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        child: Center(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.close,
                                color: AppColor.red,
                              ),
                              Space.width(10),
                              Text(
                                "Unavailable",
                                style: TextStyle(
                                  color: AppColor.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: MySize.size18!,
                                ),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MySize.size28,
                    width: 1,
                    color: AppColor.primary,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: Get.context!,
                          barrierDismissible:
                              false, // user must tap button for close dialog!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  'Accept Order (${item.name.toString()})'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Are you sure you want to accept order?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: MySize.size16!,
                                    ),
                                  ),
                                  Space.height(20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: button(
                                            height: 35,
                                            width: 80,
                                            title: "No",
                                            textColor: AppColor.primary,
                                            backgroundColor: AppColor.white,
                                            borderColor: AppColor.primary),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                          controller
                                              .callApiForChangeOrderStatus(
                                                  context: Get.context!,
                                                  accepted: true,
                                                  id: id);
                                        },
                                        child: button(
                                          height: 35,
                                          width: 80,
                                          title: "Yes",
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        child: Center(
                          child: Row(
                            children: [
                               Icon(
                                Icons.check,
                                color: AppColor.green,
                              ),
                              Space.width(10),
                              Text(
                                "Available",
                                style: TextStyle(
                                  color: AppColor.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: MySize.size18!,
                                ),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (status == OrderStatus.Confirmed &&
        controller.type.value == TabBarType.request) {
      return Container(
        // color: Colors.white,
        margin: EdgeInsets.symmetric(
            horizontal: MySize.size4!, vertical: MySize.size5!),
        padding: EdgeInsets.symmetric(
          horizontal: MySize.size18!,
          vertical: MySize.size17!,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.cardGrayColor.withOpacity(0.6),
            border: Border.all(
              color: AppColor.borderGrayColor,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Item",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        item.name.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "QTY",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        (isNullEmptyOrFalse(qty) || qty == 0)
                            ? "-"
                            : qty.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: Get.context!,
                          barrierDismissible:
                              false, // user must tap button for close dialog!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  'Complete Order (${item.name.toString()})'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Are you sure you want to complete order?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: MySize.size16!,
                                    ),
                                  ),
                                  Space.height(20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: button(
                                            height: 35,
                                            width: 80,
                                            title: "No",
                                            textColor: AppColor.primary,
                                            backgroundColor: AppColor.white,
                                            borderColor: AppColor.primary),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                          controller
                                              .callApiForChangeOrderStatusToComplete(
                                                  context: Get.context!,
                                                  id: id);
                                        },
                                        child: button(
                                          height: 35,
                                          width: 80,
                                          title: "Yes",
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: button(
                        height: 35,
                        width: 100,
                        borderColor: AppColor.primary,
                        textColor: AppColor.primary,
                        title: "Complete",
                        fontsize: 14,
                        backgroundColor: AppColor.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Space.height(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd MMM HH:mm a').format(
                      getDateFromString(orders!.createdAt.toString())
                          .toLocal()),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                // InkWell(
                //   onTap: () {
                //     showDialog(
                //       context: Get.context!,
                //       barrierDismissible:
                //           false, // user must tap button for close dialog!
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //           title:
                //               Text('Complete Order (${item.name.toString()})'),
                //           content: Column(
                //             mainAxisSize: MainAxisSize.min,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Text(
                //                 'Are you sure you want to complete order?',
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: MySize.size16!,
                //                 ),
                //               ),
                //               Space.height(20),
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   InkWell(
                //                     onTap: () {
                //                       Get.back();
                //                     },
                //                     child: button(
                //                         height: 35,
                //                         width: 80,
                //                         title: "No",
                //                         textColor: AppColor.primary,
                //                         backgroundColor: AppColor.white,
                //                         borderColor: AppColor.primary),
                //                   ),
                //                   InkWell(
                //                     onTap: () {
                //                       Get.back();
                //                       controller
                //                           .callApiForChangeOrderStatusToComplete(
                //                               context: Get.context!, id: id);
                //                     },
                //                     child: button(
                //                       height: 35,
                //                       width: 80,
                //                       title: "Yes",
                //                     ),
                //                   ),
                //                 ],
                //               )
                //             ],
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   child: button(
                //     height: 35,
                //     width: 100,
                //     borderColor: AppColor.primary,
                //     textColor: AppColor.primary,
                //     title: "Complete",
                //     backgroundColor: AppColor.white,
                //   ),
                // ),
              ],
            )
          ],
        ),
      );
    } else if (status == OrderStatus.Completed &&
        controller.type.value == TabBarType.history) {
      return Container(
        // color: Colors.white,
        margin: EdgeInsets.symmetric(
            horizontal: MySize.size4!, vertical: MySize.size5!),
        padding: EdgeInsets.symmetric(
          horizontal: MySize.size18!,
          vertical: MySize.size17!,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.cardGrayColor.withOpacity(0.6),
            border: Border.all(
              color: AppColor.borderGrayColor,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Item",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        item.name.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "QTY",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        (isNullEmptyOrFalse(qty) || qty == 0)
                            ? "-"
                            : qty.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Center(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.done_all,
                            color: AppColor.green,
                          ),
                          Space.width(10),
                          Text(
                            "Completed",
                            style: TextStyle(
                              color: AppColor.green,
                              fontWeight: FontWeight.w500,
                              fontSize: MySize.size16!,
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Space.height(10),
            Text(
              DateFormat('dd MMM HH:mm a').format(
                  getDateFromString(orders!.createdAt.toString()).toLocal()),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }
    else if (status == OrderStatus.CANCELLED &&
        controller.type.value == TabBarType.history) {
      return Container(
        // color: Colors.white,
        margin: EdgeInsets.symmetric(
            horizontal: MySize.size4!, vertical: MySize.size5!),
        padding: EdgeInsets.symmetric(
          horizontal: MySize.size18!,
          vertical: MySize.size17!,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.cardGrayColor.withOpacity(0.6),
            border: Border.all(
              color: AppColor.borderGrayColor,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Item",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        item.name.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "QTY",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        (isNullEmptyOrFalse(qty) || qty == 0)
                            ? "-"
                            : qty.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Center(
                      child: Row(
                        children: [
                          // Icon(
                          //   Icons.,
                          //   color: AppColor.green,
                          // ),
                          // Space.width(10),
                          Text(
                            "Cancelled",
                            style: TextStyle(
                              color: AppColor.red,
                              fontWeight: FontWeight.w500,
                              fontSize: MySize.size18!,
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Space.height(10),
            Text(
              DateFormat('dd MMM HH:mm a').format(
                  getDateFromString(orders!.createdAt.toString()).toLocal()),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    } else if (status == OrderStatus.Rejected &&
        controller.type.value == TabBarType.history) {
      return Container(
        // color: Colors.white,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.cardGrayColor.withOpacity(0.6),
            border: Border.all(
              color: AppColor.borderGrayColor,
            )),
        margin: EdgeInsets.symmetric(
            horizontal: MySize.size5!, vertical: MySize.size5!),
        padding: EdgeInsets.symmetric(
          horizontal: MySize.size18!,
          vertical: MySize.size17!,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Item",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        item.name.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "QTY",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        (isNullEmptyOrFalse(qty) || qty == 0)
                            ? "-"
                            : qty.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                /*Expanded(
                  flex: 2,
                  child: Container(
                    child: Center(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.clear,
                            color: AppColor.red,
                          ),
                          Space.width(10),
                          Text(
                            "Unavailable",
                            style: TextStyle(
                              color: AppColor.red,
                              fontWeight: FontWeight.w500,
                              fontSize: MySize.size16!,
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ),
                )*/
              ],
            ),
            Space.height(10),
            Text(
              DateFormat('dd MMM HH:mm a').format(
                  getDateFromString(orders!.createdAt.toString()).toLocal()),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            )
          ],
        ),
      );
    } else if (status == OrderStatus.Accepted &&
        controller.type.value == TabBarType.history) {
      return Container(
        // color: Colors.white,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.cardGrayColor.withOpacity(0.6),
            border: Border.all(
              color: AppColor.borderGrayColor,
            )),
        margin: EdgeInsets.symmetric(
            horizontal: MySize.size5!, vertical: MySize.size5!),
        padding: EdgeInsets.symmetric(
          horizontal: MySize.size18!,
          vertical: MySize.size17!,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Item",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          // fontWeight: FontWeight.bold,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        item.name.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "QTY",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        (isNullEmptyOrFalse(qty) || qty == 0)
                            ? "-"
                            : qty.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Center(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_outlined,
                            color: AppColor.green,
                          ),
                          Space.width(10),
                          Text(
                            "Available",
                            style: TextStyle(
                              color: AppColor.green,
                              fontWeight: FontWeight.w500,
                              fontSize: MySize.size18!,
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Space.height(10),
            Text(
              DateFormat('dd MMM HH:mm a').format(
                  getDateFromString(orders!.createdAt.toString()).toLocal()),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            )
          ],
        ),
      );
    } else if (status == OrderStatus.Completed &&
        controller.type.value == TabBarType.payment) {
      return Container(
        // color: Colors.white,
        margin: EdgeInsets.symmetric(
            horizontal: MySize.size4!, vertical: MySize.size5!),
        padding: EdgeInsets.symmetric(
          horizontal: MySize.size18!,
          vertical: MySize.size17!,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.cardGrayColor.withOpacity(0.6),
            border: Border.all(
              color: AppColor.borderGrayColor,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Item",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        item.name.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "QTY",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        (isNullEmptyOrFalse(qty) || qty == 0)
                            ? "-"
                            : qty.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        (isNullEmptyOrFalse(orders!.price!.obs.toString()) || orders!.price!.obs.toString()== 0)
                            ? "-"
                            : orders!.price!.obs.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
               /* Expanded(
                  flex: 2,
                  child: Container(
                    child: Center(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.done_all,
                            color: AppColor.green,
                          ),
                          Space.width(10),
                          Text(
                            "Completed",
                            style: TextStyle(
                              color: AppColor.green,
                              fontWeight: FontWeight.w500,
                              fontSize: MySize.size16!,
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ),
                )*/
              ],
            ),
            Space.height(10),
            Text(
              DateFormat('dd MMM HH:mm a').format(
                  getDateFromString(orders!.createdAt.toString()).toLocal()),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }
    return Container();
  }



  Widget getHouseKeepingContainer2(
    RestaurantItem item, {
    String status = OrderStatus.Pending,
    int id = 1,
    qty = 0,

    String type = OrderType.Restaurant,
    Orders? orders,


  }) {
     if (status == OrderStatus.Completed &&
        controller.type.value == TabBarType.payment) {
      return Container(
        // color: Colors.white,
        margin: EdgeInsets.symmetric(
            horizontal: MySize.size4!, vertical: MySize.size5!),
        padding: EdgeInsets.symmetric(
          horizontal: MySize.size18!,
          vertical: MySize.size17!,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.cardGrayColor.withOpacity(0.6),
            border: Border.all(
              color: AppColor.borderGrayColor,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Item",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        item.name.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "QTY",
                        style: TextStyle(
                          color: AppColor.textGrayColor,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      ),
                      Space.height(10),
                      Text(
                        (isNullEmptyOrFalse(qty) || qty == 0)
                            ? "-"
                            : qty.toString(),
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Center(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.done_all,
                            color: AppColor.green,
                          ),
                          Space.width(10),
                          Text(
                            "Completed",
                            style: TextStyle(
                              color: AppColor.green,
                              fontWeight: FontWeight.w500,
                              fontSize: MySize.size16!,
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Space.height(10),
            Text(
              DateFormat('dd MMM HH:mm a').format(
                  getDateFromString(orders!.createdAt.toString()).toLocal()),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }
    return Container();
  }






  Widget getLaundryContainer(RestaurantItem item, {qty = 0}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MySize.size18!,
        vertical: MySize.size17!,
      ),
      margin: EdgeInsets.symmetric(
          horizontal: MySize.size4!, vertical: MySize.size5!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.cardGrayColor.withOpacity(0.6),
          border: Border.all(
            color: AppColor.borderGrayColor,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Item",
                    style: TextStyle(
                      color: AppColor.textGrayColor,
                      fontWeight: FontWeight.normal,
                      fontSize: MySize.size16!,
                    ),
                  ),
                  Space.height(10),
                  Text(
                    item.name.toString(),
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: MySize.size16!,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "QTY",
                    style: TextStyle(
                      color: AppColor.textGrayColor,
                      fontWeight: FontWeight.normal,
                      fontSize: MySize.size16!,
                    ),
                  ),
                  Space.height(10),
                  Text(
                    (isNullEmptyOrFalse(qty) || qty == 0)
                        ? "-"
                        : qty.toString(),
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.normal,
                      fontSize: MySize.size16!,
                    ),
                  )
                ],
              ),
            ],
          ),
          Space.height(10),
          Text(
            DateFormat('dd MMM HH:mm a').format(
                getDateFromString(orders!.createdAt.toString()).toLocal()),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  int getIndexOftitle({String type = OrderType.Restaurant}) {
    if (type == OrderType.Restaurant) {
      return 0;
    } else if (type == OrderType.Laundry) {
      return 1;
    } else if (type == OrderType.Feedback) {
      return 2;
    } else if (type == OrderType.Housekeeping) {
      return 3;
    } else if (type == OrderType.ExtraSupplies) {
      return 4;
    }
    return 0;
  }

  String getRattingImage({int r = 1}) {
    if (r == 1) {
      return AppAsset.r1Png;
    } else if (r == 2) {
      return AppAsset.r2Png;
    } else if (r == 3) {
      return AppAsset.r3Png;
    } else if (r == 4) {
      return AppAsset.r4Png;
    } else if (r == 5) {
      return AppAsset.r5Png;
    }
    return AppAsset.r1Png;
  }

  _asyncConfirmDialog(
    BuildContext context, {
    Function()? onConfirm,
  }) async {
    return showDialog(
      context: context,

      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: MySize.size30!),
          title: const Text('Confirm Checkout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Are you sure you want to checkout?',
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
                      Get.back();
                    },
                    child: button(
                        height: 35,
                        width: 80,
                        title: "No",
                        textColor: AppColor.primary,
                        backgroundColor: AppColor.white,
                        borderColor: AppColor.primary),
                  ),
                  InkWell(
                    onTap: () async{
                      if (onConfirm == null) {
                        //Get.back();
                        controller.callApiForCheckOutApi(
                          context: Get.context!,
                        );
                        //await  controller.callApiForSendInvoice(context: Get.context!);
                       // await Get.to(HomeView());
                      } else {
                        //onConfirm();
                        //print("is else-------------------");
                        Get.back();
                      }
                     /* if (onConfirm == null) {
                        Get.back();
                        controller.callApiForCheckOutApi(
                          context: Get.context!,
                        );
                      } else {
                        onConfirm();

                      }*/
                    },
                    child: button(
                      height: 35,
                      width: 80,
                      title: "Yes",
                    ),
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
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Checkout'),
          content: const Text('Are you sure you want to checkout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              // color: Colors.red,

              onPressed: () {
                Get.back();
                controller.callApiForCheckOutApi(context: Get.context!);
              },
            )
          ],
        );
      },
    );
  }
}

class CheckoutModel {
  String? img;
  Color? color;
  String? name;
  List<ProductModel>? productList;

  CheckoutModel({this.img, this.name, this.productList, this.color});
}

class ProductModel {
  String? productName;

  ProductModel(
      {this.productName,
      required this.isAccepted,
      this.quantity,
      required this.isActive});

  RxBool isAccepted;
  RxBool isActive;
  num? quantity;
}
