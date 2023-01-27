import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:hotel_customer/global/widgets/button.dart';
import 'package:hotel_customer/global/widgets/text_field.dart';

import '../../../../global/constants/app_color.dart';
import '../../../../global/constants/app_sizeConstant.dart';
import '../controllers/feedback_controller.dart';

class FeedbackView extends GetWidget<FeedbackController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Space.height(30),
            Text(
              "Feedback",
              style: TextStyle(
                color: AppColor.textGrayColor,
                fontWeight: FontWeight.bold,
                fontSize: MySize.size20!,
              ),
            ),
            Text(
              "Share your experience with Hotelcom",
              style: TextStyle(
                color: AppColor.textGrayColor,
                fontWeight: FontWeight.normal,
                fontSize: MySize.size14!,
              ),
            ),

            // Space.height(30)
          ],
        ),
        centerTitle: false,
        backgroundColor: AppColor.primary,
        leading: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      ),
      body: Container(
        height: MySize.screenHeight,
        width: MySize.screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: MySize.size25!,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Space.height(30),
              // Text(
              //   "How satisfied are you with our services?",
              //   style: TextStyle(
              //     color: AppColor.primary,
              //     fontWeight: FontWeight.w600,
              //     fontSize: MySize.size20!,
              //   ),
              // ),
              SizedBox(
                width: double.infinity,
                child: FittedBox(
                  child: Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    "How satisfied are you with our services?",
                    // '${controller.ratingValue.value + 4}',

                    maxLines: 2,
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: MySize.size20!,
                    ),
                  ),
                ),
              ),
              // Space.height(15),
              // Text(
              //   "Select an expression to describe your satisfaction.",
              //   style: TextStyle(
              //     color: AppColor.primary,
              //     fontWeight: FontWeight.normal,
              //     fontSize: MySize.size18!,
              //   ),
              // ),
              Space.height(15),
              // controller.ratingValue.value = index ;
              Center(
                child: RatingBar.builder(
                  // controller.ratingValue.value = index ;
                  // rating: controller.ratingValue.value,
                  initialRating: 5,
                  minRating: 1,
                  maxRating: 5,
                  // onRatingUpdate: (double value) {
                  //   controller.ratingValue.value = value;
                  //   debugPrint("-=-=-=-=${controller.ratingValue.value}");
                  // },
                  itemBuilder: (
                    context,
                    index,
                  ) =>
                      CircleAvatar(
                    radius: controller.ratingValue.value == index + 1 ? 20 : 28,
                    // ignore: avoid_print

                    // radius: 28,
                    backgroundColor: AppColor.cardGrayColor,
                    child: Image(
                      image: AssetImage(
                        controller.emogi[index],
                      ),
                      height: MySize.size40,
                      // height: MySize.size40,
                      width: MySize.size40,
                      // width: MySize.size40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  itemPadding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: 5,
                  itemSize: 45.0,
                  unratedColor: Colors.amber.withOpacity(0.5),
                  direction: Axis.horizontal,

                  // ignoreGestures: true,
                  onRatingUpdate: (double value) {
                    controller.ratingValue.value = value;
                    debugPrint("-=-=-=-=${controller.ratingValue.value}");
                  },
                ),
              ),
              // Space.height(15),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Not satisfied",
              //       style: TextStyle(
              //         color: AppColor.primary,
              //         fontWeight: FontWeight.normal,
              //         fontSize: MySize.size12!,
              //       ),
              //     ),
              //     Text(
              //       "Very satisfied",
              //       style: TextStyle(
              //         color: AppColor.primary,
              //         fontWeight: FontWeight.normal,
              //         fontSize: MySize.size12!,
              //       ),
              //     ),
              //   ],
              // ),
              Space.height(40),
              Container(
                width: double.infinity,
                child: FittedBox(
                  child: Text(
                    "Share your thoughts and suggestions \nwith us.",

                    maxLines: 2,
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: MySize.size20!,
                    ),
                  ),
                ),
              ),
              Space.height(15),
              Text(
                "Tell us about any service that you would like to be improved in the future.",
                style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.normal,
                  fontSize: MySize.size18!,
                ),
              ),
              Space.height(30),
              commonTextField(
                  hintText: "Type your thoughts here...",
                  maxLines: 7,
                  controller: controller.feedbackController.value,
                  tcPadding: 30),
              Space.height(50),
              Center(
                child: InkWell(
                  onTap: () {
                    controller.callApiSubmitFeedback(context: context);
                  },
                  child: button(
                    title: "Submit",
                    fontsize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
