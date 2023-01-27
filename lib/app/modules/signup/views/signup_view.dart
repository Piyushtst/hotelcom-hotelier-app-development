import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_customer/app/modules/signup/views/common_drop_down.dart';
import 'package:hotel_customer/global/constants/app_color.dart';
import 'package:hotel_customer/global/constants/app_sizeConstant.dart';
import 'package:hotel_customer/global/widgets/button.dart';
import 'package:hotel_customer/global/widgets/text_field.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../global/constants/app_asset.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetWidget<SignupController> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Container(
        height: MySize.screenHeight,
        width: MySize.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: MySize.getScaledSizeWidth(40)),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space.height(45),

                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColor.black,
                      size: 35,
                    )),

                const Center(
                  child: Image(
                    image: AssetImage(AppAsset.logoPng),
                    height: 338,
                    width: 358,
                  ),
                ),

                Space.height(25),

                Obx(
                      () =>
                  controller.hotelList.isEmpty
                      ? const SizedBox()
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hotel",
                        style: TextStyle(
                          fontSize: MySize.size16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Space.height(8),
                      commonTextField(
                        controller: controller.hotelController.value,
                        needValidation: true,
                        onlyAlphabetValidation: true,
                        validationMessage: "Hotel",
                        onChangedValue: (v) {
                          controller.callApiSearch(context: context);
                        },
                      ),
                      controller.hotelListName.isNotEmpty
                          ? Obx(() => Card(
                        elevation: 1,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.hotelListName.length-1,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              // color: Colors.red,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                child: InkWell(
                                  onTap: () async{
                                    print("____________${controller.hotelListName[index].name}");
                                    controller.hotelController.value.text = controller.hotelListName[index].name.toString();
                                    controller.hotelNameId.value=controller.hotelListName[index].id.toString();
                                      controller.hotelListName.clear();
                                  },
                                  child: Text(
                                    "${controller.hotelListName[index].name}",
                                    style: TextStyle(
                                      fontSize: MySize.size16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ))
                          : const SizedBox(),
                      Space.height(25),
                      /*InkWell(
                        onTap: () {

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:Border.all(color: AppColor.borderGrayColor)
                          ),
                          child: Autocomplete(
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<String>.empty();
                              }else{
                                controller.callApiSearch(context: context);
                                List<String> matches = <String>[];
                                matches.addAll(controller.departmentList);
                                matches.retainWhere((s){
                                  return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                });
                                return matches;
                              }
                            },
                            onSelected: (String selection) {
                              print('You just selected $selection');
                            },
                          ),
                        ),
                      )*/
                      /* CommonDropDown(
                        hintText: "Select Department",
                        validationMessage: "Department",
                        needValidation: true,
                        onChange: (v) {
                          controller.selectDepartment.value = v.toString();
                        },
                        topPadding: 10,
                        itemList: controller.departmentList,
                        dropDownValue: controller.selectDepartment.value.isEmpty
                            ? null
                            : controller.selectDepartment.value,
                      ),*/
                    ],
                  ),
                ),

                Text(
                  "Department",
                  style: TextStyle(
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Space.height(8),
                //Space.height(25),
                commonTextField(
                  controller: controller.departmentController.value,
                  needValidation: true,
                  onlyAlphabetValidation: true,
                  validationMessage: "Name",
                ),
                Space.height(25),
                Text(
                  "Name",
                  style: TextStyle(
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Space.height(8),
                commonTextField(
                  controller: controller.nameController.value,
                  needValidation: true,
                  onlyAlphabetValidation: true,
                  validationMessage: "Name",
                ),
                Space.height(25),
                Text(
                  "Contact Number",
                  style: TextStyle(
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Space.height(8),
                commonTextField(
                  controller: controller.contactNumberController.value,
                  maxLength: 10,
                  keyBoardTypeEnter: TextInputType.number,
                  needValidation: true,
                  showNumber: true,
                  validationMessage: "Contact Number",
                ),
                Space.height(25),
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Space.height(8),
                commonTextField(
                  controller: controller.emailController.value,
                  needValidation: true,
                  isEmailValidation: true,
                  upperCaseTextFormatter: false,
                  validationMessage: "Email",
                ),
                Space.height(21),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Space.height(8),
                Obx(() {
                  return commonTextField(
                    controller: controller.passwordController.value,
                    needValidation: true,
                    maxLines: 1,
                    obscureText: !controller.isVisible.value,
                    validationMessage: "Password",
                    iconButton: InkWell(
                        onTap: () {
                          controller.isVisible.toggle();
                        },
                        child: Icon(
                          (controller.isVisible.isTrue) ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        )),
                  );
                }),
                Space.height(41),
                /*InkWell(
                  onTap: () {
                    Get.toNamed(Routes.FORGET_PASSWORD);
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Space.height(35),*/
                InkWell(
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.callApiForSignup(context: context);
                    }
                  },
                  child: button(
                    title: "Sign up",
                    fontsize: MySize.size18!,
                    radius: 8,
                  ),
                ),
                Space.height(25),
                Center(
                  child: InkWell(
                    onTap: () {
                      launchURL(url: "https://hotelcom.live/");
                    },
                    child: Text(
                      "Visit hotelcom.live",
                      style: TextStyle(
                        color: const Color(0xff3120FD),
                        fontSize: MySize.size16!,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                Space.height(25),
                // Space.height(20),
                // Center(
                //   child: Text(
                //     "Or",
                //     style: TextStyle(
                //       fontSize: MySize.size16,
                //       fontWeight: FontWeight.normal,
                //       color: AppColor.textGrayColor,
                //     ),
                //   ),
                // ),
                // Space.height(20),
                // Center(
                //   child: Text(
                //     "Create an account",
                //     style: TextStyle(
                //       fontSize: MySize.size16,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget TextfieldDropdowun(BuildContext context) {
    MySize().init(context);
    return CommonDropDown(
      hintText: "Select Department",
      validationMessage: "Department",
      needValidation: true,
      onChange: (v) {
        controller.selectDepartment.value = v.toString();
      },
      topPadding: 10,
      itemList: controller.departmentList,
      dropDownValue: controller.selectDepartment.value.isEmpty ? null : controller.selectDepartment.value,
    );
  }

  launchURL({required String url}) async {
    // const url = "https://flutter.io";
    //  if (await canLaunch(url)) {
    await launch(url);
    // } else {
    //   throw 'Could not Launch $url';
    // }
  }
}
