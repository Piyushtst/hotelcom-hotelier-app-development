import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_customer/global/constants/app_color.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/app_sizeConstant.dart';

getShimerForHome() {
  return Center(
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      enabled: true,
      child: Container(
        // color: Colors.red,
        // margin: EdgeInsets.only(
        //   bottom: MySize.size14!,
        // ),
        // padding: EdgeInsets.all(
        //   MySize.size10!,
        // ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            MySize.size20!,
          ),
          // border: Border.all(
          //   color: appTheme.gray2Color,
          //   width: 1.5,
          // ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                shrinkWrap: true,
                childAspectRatio: 0.97,
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10.0,
                children: List.generate(
                  9,
                  (ind) => Container(
                    // height: MySize.size90,
                    // width: 100,
                    padding: EdgeInsets.all(MySize.size10!),
                    decoration: BoxDecoration(
                      // color:
                      //     AppColor.cardGrayColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: AppColor.cardBorderGrayColor, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MySize.size30,
                          // width: MySize.size80,
                          color: Colors.white,
                        ),
                        Space.height(15),
                        Container(
                          height: MySize.size2,
                          // width: MySize.size80,
                          color: Colors.white,
                        ),
                        Space.height(9),
                        Container(
                          height: 30,
                          width: double.infinity,
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: List.generate(
                                  4,
                                  (index) => Positioned(
                                        left: index * 15,
                                        child: Container(
                                          height: MySize.size20,
                                          width: MySize.size20,
                                          decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                color: AppColor.primary,
                                                width: 1),
                                          ),
                                        ),
                                      )),
                            ),
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
    ),
  );
}

getShimerForRequest() {
  return Center(
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      enabled: true,
      child: Container(
        // color: Colors.red,
        // margin: EdgeInsets.only(
        //   bottom: MySize.size14!,
        // ),
        // padding: EdgeInsets.all(
        //   MySize.size10!,
        // ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            MySize.size20!,
          ),
          // border: Border.all(
          //   color: appTheme.gray2Color,
          //   width: 1.5,
          // ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  //horizontal: MySize.size20!,
                  top: MySize.size17!,
                  bottom: MySize.size17!,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: AppColor.white,
                  border: Border.all(
                    color: AppColor.borderGrayColor,
                    width: 2,
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
                      Container(
                        width: MySize.size23,
                        height: MySize.size20,
                        color: AppColor.white,
                      ),
                      // Image(
                      //   image: AssetImage(
                      //     list[getIndexOftitle(type: value)].img!,
                      //   ),
                      //   width: MySize.size23,
                      //   height: MySize.size15,
                      //   color:
                      //       list[getIndexOftitle(type: value)].color!,
                      //   fit: BoxFit.fitHeight,
                      // ),
                      Space.width(15),
                      Container(
                        width: MySize.size120,
                        height: MySize.size15,
                        color: AppColor.white,
                      ),
                      // Text(
                      //   list[getIndexOftitle(type: value)]
                      //       .name
                      //       .toString(),
                      //   style: TextStyle(
                      //     color: AppColor.primary,
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: MySize.size18!,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              for (int i = 0; i < 8; i++)
                Container(
                  // color: Colors.white,
                  margin: EdgeInsets.symmetric(
                    vertical: MySize.size10!,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: MySize.size18!,
                    vertical: MySize.size17!,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: AppColor.cardGrayColor.withOpacity(0.6),
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
                                Container(
                                  width: MySize.size70,
                                  height: MySize.size15,
                                  color: AppColor.white,
                                ),
                                Space.height(10),
                                Container(
                                  width: MySize.size80,
                                  height: MySize.size15,
                                  color: AppColor.white,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: MySize.size50,
                                  height: MySize.size15,
                                  color: AppColor.white,
                                ),
                                Space.height(10),
                                Container(
                                  width: MySize.size20,
                                  height: MySize.size15,
                                  color: AppColor.white,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: MySize.size100,
                                height: MySize.size35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: AppColor.cardGrayColor.withOpacity(0.6),
                                  color: AppColor.white,
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
                          Container(
                            width: MySize.size100,
                            height: MySize.size15,
                            color: AppColor.white,
                          ),
                          // Text(
                          //   DateFormat('dd MMM HH:mm a')
                          //       .format(getDateFromString(item.createdAt.toString())),
                          //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          // ),
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
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

getShimerForPayment() {
  return Center(
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      enabled: true,
      child: Container(
        // color: Colors.red,
        // margin: EdgeInsets.only(
        //   bottom: MySize.size14!,
        // ),
        // padding: EdgeInsets.all(
        //   MySize.size10!,
        // ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            MySize.size20!,
          ),
          // border: Border.all(
          //   color: appTheme.gray2Color,
          //   width: 1.5,
          // ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: MySize.size20!,
                        vertical: MySize.size20!,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: AppColor.cardGrayColor.withOpacity(0.6),
                          border: Border.all(
                            color: AppColor.borderGrayColor,
                          )),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MySize.size50,
                                      height: MySize.size20,
                                      color: AppColor.white,
                                    ),
                                    Space.height(10),
                                    Container(
                                      width: MySize.size83,
                                      height: MySize.size20,
                                      color: AppColor.white,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MySize.size50,
                                      height: MySize.size20,
                                      color: AppColor.white,
                                    ),
                                    Space.height(10),
                                    Container(
                                      width: MySize.size23,
                                      height: MySize.size20,
                                      color: AppColor.white,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: MySize.size65,
                                      height: MySize.size20,
                                      color: AppColor.white,
                                    ),
                                    Space.height(10),
                                    Container(
                                      width: MySize.size55,
                                      height: MySize.size20,
                                      color: AppColor.white,
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
                    );
                  },
                  separatorBuilder: (context, i) {
                    return Space.height(15);
                  },
                  itemCount: 7),
            ],
          ),
        ),
      ),
    ),
  );
}

getShimerForQr() {
  return Center(
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      enabled: true,
      child: Container(
        height: MySize.screenHeight,
        width: MySize.screenWidth,
        // margin: EdgeInsets.only(
        //   top: MediaQuery.of(Get.context!).padding.top,
        // ),
        // padding:
        //     EdgeInsets.symmetric(horizontal: MySize.getScaledSizeWidth(50)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Space.height(84),
              Container(
                height: MySize.size200,
                width: MySize.size200,
                color: Colors.white,
              ),
              Space.height(70),
              Container(
                height: MySize.size20,
                width: MySize.size160,
                color: Colors.white,
              ),
              Space.height(35),
              Container(
                height: MySize.size15,
                width: MySize.size300,
                color: Colors.white,
              ),
              Space.height(35),
              Container(
                height: MySize.size20,
                width: MySize.size160,
                color: Colors.white,
              ),
              Space.height(100),
              Container(
                height: MySize.size50,
                width: MySize.size300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),
              Space.height(30),
              Container(
                height: MySize.size50,
                width: MySize.size300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

getShimerForQrInner() {
  return Center(
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      enabled: true,
      child: Container(
        height: MySize.screenHeight,
        width: MySize.screenWidth,
        // margin: EdgeInsets.only(
        //   top: MediaQuery.of(Get.context!).padding.top,
        // ),
        // padding:
        //     EdgeInsets.symmetric(horizontal: MySize.getScaledSizeWidth(50)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Space.height(84),
              Container(
                height: MySize.size200,
                width: MySize.size200,
                color: Colors.white,
              ),
              Space.height(70),
              Container(
                height: MySize.size20,
                width: MySize.size160,
                color: Colors.white,
              ),
              Space.height(35),
              Container(
                height: MySize.size15,
                width: MySize.size300,
                color: Colors.white,
              ),
              Space.height(35),
              Container(
                height: MySize.size20,
                width: MySize.size160,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
