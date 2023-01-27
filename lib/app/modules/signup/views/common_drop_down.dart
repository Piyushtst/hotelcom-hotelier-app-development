import 'package:flutter/material.dart';
import 'package:hotel_customer/Models/HotelListModel.dart';
import 'package:hotel_customer/global/constants/app_color.dart';
import 'package:hotel_customer/global/constants/theme/app_text_style.dart';


class CommonDropDownDynamic extends StatelessWidget {
  final String? title;
  final List<HotelList>? itemList;
  final HotelList? dropDownValue;
  final String? validationMessage;
  final String? hintText;
  final double? topPadding;
  final Color? fillColor;
  final bool isTransparentColor;
  final bool needValidation;
  final String? Function(HotelList?)? validator;

  final  Function(HotelList?)? onChange;

  const CommonDropDownDynamic({
    Key? key,
    this.title,
    this.itemList,
    this.dropDownValue,
    this.onChange,
    this.validator,
    this.validationMessage,
    this.topPadding,
    this.hintText,
    this.fillColor,
    this.isTransparentColor = false,
    this.needValidation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topPadding ?? 0),
        if (title != null)
          Text(
            title!,
            style: AppTextStyle.medium.copyWith(fontSize: 17),
          ),
        if (title != null) const SizedBox(height: 10),
        DropdownButtonFormField<HotelList>(
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: AppColor.blackText,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? AppColor.transparent,
            hintText: hintText,
            hintStyle: AppTextStyle.medium
                .copyWith(color: AppColor.black, fontSize: 15),
            contentPadding:
            const EdgeInsets.only(top: 12, bottom: 12, right: 20, left: 20),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isTransparentColor
                        ? AppColor.transparent
                        : AppColor.borderGrayColor),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isTransparentColor
                        ? AppColor.transparent
                        : AppColor.borderGrayColor),
                borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isTransparentColor
                        ? AppColor.transparent
                        : AppColor.borderGrayColor),
                borderRadius: BorderRadius.circular(8)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isTransparentColor
                        ? AppColor.transparent
                        : AppColor.borderGrayColor),
                borderRadius: BorderRadius.circular(8)),
          ),
          validator: needValidation == true
              ? (v) {
            if (v == null) {
              return "$validationMessage is required";
            }
            return null;
          }
              : null,
          isDense: true,
          onChanged: onChange,
          value: dropDownValue,
          items: itemList!.map((selectedType) {
            return DropdownMenuItem(
              value: selectedType,
              child: Text(
                selectedType.name!,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColor.blackText),
              ),
            );
          }).toList(),
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColor.black,
          ),
        ),
      ],
    );
  }
}

class CommonDropDown extends StatelessWidget {
  final String? title;
  final List<String>? itemList;
  final String? dropDownValue;
  final String? validationMessage;
  final String? hintText;
  final double? topPadding;
  final Color? fillColor;
  final bool isTransparentColor;
  final bool needValidation;
  final String? Function(String?)? validator;

  final void Function(String?)? onChange;

  const CommonDropDown({
    Key? key,
    this.title,
    this.itemList,
    this.dropDownValue,
    this.onChange,
    this.validator,
    this.validationMessage,
    this.topPadding,
    this.hintText,
    this.fillColor,
    this.isTransparentColor = false,
    this.needValidation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topPadding ?? 0),
        if (title != null)
          Text(
            title!,
            style: AppTextStyle.medium.copyWith(fontSize: 17),
          ),
        if (title != null) const SizedBox(height: 10),
        DropdownButtonFormField(
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: AppColor.blackText,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? AppColor.transparent,
            hintText: hintText,
            hintStyle: AppTextStyle.medium
                .copyWith(color: AppColor.black, fontSize: 15),
            contentPadding:
                const EdgeInsets.only(top: 12, bottom: 12, right: 20, left: 20),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isTransparentColor
                        ? AppColor.transparent
                        : AppColor.borderGrayColor),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isTransparentColor
                        ? AppColor.transparent
                        : AppColor.borderGrayColor),
                borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isTransparentColor
                        ? AppColor.transparent
                        : AppColor.borderGrayColor),
                borderRadius: BorderRadius.circular(8)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isTransparentColor
                        ? AppColor.transparent
                        : AppColor.borderGrayColor),
                borderRadius: BorderRadius.circular(8)),
          ),
          validator: needValidation == true
              ? (v) {
                  if (v == null) {
                    return "$validationMessage is required";
                  }
                  return null;
                }
              : null,
          isDense: true,
          onChanged: onChange,
          value: dropDownValue,
          items: itemList!.map((selectedType) {
            return DropdownMenuItem(
              value: selectedType,
              child: Text(
                selectedType,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColor.blackText),
              ),
            );
          }).toList(),
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColor.black,
          ),
        ),
      ],
    );
  }
}
