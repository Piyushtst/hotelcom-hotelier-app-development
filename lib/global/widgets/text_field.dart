// Common TextField
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import '../constants/app_color.dart';

Widget commonTextField({
  TextEditingController? controller,
  String? hintText,
  String? labelText,
  String? counterText,
  bool needValidation = false,
  bool? urlValidation = false,
  bool? specialCharacterHideValidation = false,
  bool? onlyAlphabetValidation = false,
  bool? isActive = false,
  String? validationMessage,
  double? horizontal,
  iconButton,
  Widget? prefixButton,
  double? vertical,
  double? lcPadding,
  double? tcPadding,
  double? rcPadding,
  double? bcPadding,
  bool readyOnly = false,
  Function? onPressed,
  bool hintTextBold = false,
  bool showBfBorder = true,
  bool showBeBorder = true,
  bool titleTextBold = false,
  bool labelTextBold = false,
  bool fillColor = false,
  bool textAlign = false,
  bool showNumber = false,
  bool isEmailValidation = false,
  bool isPhoneValidation = false,
  double? hintFontSize,
  double? labelFontSize,
  double? textSize,
  Color? fbColor,
  Color? ebColor,
  Color? hintTextColor,
  Color? labelTextColor,
  Color? textColor,
  int? maxLength = 32,
  int? maxLines,
  FocusNode? focusNode,
  List<TextInputFormatter>? inputFormatters,
  TextInputType? keyBoardTypeEnter,
  bool? isPassWordValidation = false,
  bool obscureText = false,
  Function(String?)? onChangedValue,
  TextInputAction? textInputAction,
  bool upperCaseTextFormatter = true,
  bool numberTextFormatter = false,
  TextCapitalization textCapitalization = TextCapitalization.words,
  bool autofocus = false,
  double borderRadius = 10,
  var prefixIco,
}) {
  var maskFormatterForNumber;
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    child: TextFormField(
      autofocus: autofocus,
      onChanged: onChangedValue,
      obscureText: obscureText,
      controller: controller,
      focusNode: focusNode,
      keyboardType: showNumber ? TextInputType.number : TextInputType.text,
      textAlign: textAlign ? TextAlign.right : TextAlign.start,
      textInputAction: textInputAction ?? TextInputAction.done,
      textCapitalization: textCapitalization,
      style: TextStyle(
        color: textColor ?? Colors.black,
        fontWeight: titleTextBold ? FontWeight.bold : FontWeight.normal,
        fontSize: textSize ?? 16,
      ),
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          left: lcPadding ?? 15,
          top: tcPadding ?? 0,
          right: rcPadding ?? 0,
          bottom: bcPadding ?? 0,
        ),
        fillColor: fillColor ? AppColor.transparent : AppColor.transparent,
        focusedBorder: showBfBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: fbColor ?? AppColor.primary,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: fbColor ?? AppColor.primary,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        enabledBorder: showBeBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: fbColor ?? AppColor.borderGrayColor,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: fbColor ?? AppColor.borderGrayColor,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        counterText: counterText == "" ? null : "",
        filled: true,
        // prefixIcon: prefixIcon,
        suffixIcon: iconButton,
        label: labelText == null
            ? const SizedBox()
            : Container(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                    color: isActive == true || controller!.text.isNotEmpty
                        ? AppColor.white
                        : AppColor.transparent,
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  labelText,
                  style: TextStyle(
                    color: labelTextColor ?? AppColor.grey,
                    /*  backgroundColor:
                        isActive == true ? AppColor.red : AppColor.transparent,*/
                    fontWeight:
                        labelTextBold ? FontWeight.w400 : FontWeight.normal,
                    fontSize: labelFontSize ?? 12,
                  ),
                ),
              ),
        // labelText: labelText,
        /*labelStyle: TextStyle(
          color: labelTextColor ?? AppColor.greyText,
          backgroundColor: isActive == true ? AppColor.red : AppColor.transparent,
          fontWeight: labelTextBold ? FontWeight.w400 : FontWeight.normal,
          fontSize: labelFontSize ?? 12,
        ),*/
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintTextColor ?? AppColor.grey,
          fontWeight: hintTextBold ? FontWeight.bold : FontWeight.normal,
          fontSize: hintFontSize ?? 16,
        ),
        border: const OutlineInputBorder(),
      ),
      // inputFormatters: inputFormatters ?? [],
      inputFormatters: numberTextFormatter
          ? <TextInputFormatter>[maskFormatterForNumber]
          : /*upperCaseTextFormatter
              ? <TextInputFormatter>[UpperCaseTextFormatter()]
              : */
          <TextInputFormatter>[],
      onTap: onPressed as void Function()?,
      maxLength: maxLength,
      readOnly: readyOnly,
      validator: needValidation
          ? isPassWordValidation!
              ? (value) {
                  if (value!.isEmpty) {
                    return '$validationMessage is Required !';
                  } else if (value.length < 8) {
                    return 'Your password is short !';
                  } else if (!RegExp(
                          r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                      .hasMatch(value)) {
                    return 'Your password not contain rules!';
                  }
                  return null;
                }
              : urlValidation!
                  ? (value) {
                      if (value!.isEmpty) {
                        return '$validationMessage is Required !';
                      } else if (!RegExp(
                              r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+')
                          .hasMatch(value)) {
                        return 'Please enter valid URL';
                      }
                      return null;
                    }
                  : specialCharacterHideValidation!
                      ? (value) {
                          if (value!.isEmpty) {
                            return '$validationMessage is Required !';
                          } else if (!RegExp(r'^[\ a-zA-Z0-9]+$')
                              .hasMatch(value.trim())) {
                            return "Please enter a valid name";
                          }
                          return null;
                        }
                      : onlyAlphabetValidation!
                          ? (value) {
                              if (value!.isEmpty) {
                                return '$validationMessage is Required !';
                              } else if (!RegExp(r"^[A-Za-z ]+$")
                                  .hasMatch(value.trim())) {
                                return "Please enter a valid name";
                              }
                              return null;
                            }
                          : isEmailValidation
                              ? (value) {
                                  if (value!.isEmpty) {
                                    return '$validationMessage is Required !';
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return 'Please Enter proper email!';
                                  }
                                  return null;
                                }
                              : isPhoneValidation
                                  ? (value) {
                                      if (value!.length != 10) {
                                        return 'Mobile Number must be of 10 digit';
                                      } else if (!RegExp(r'^[0-9]+$')
                                          .hasMatch(value.trim())) {
                                        return "Please enter a valid number";
                                      } else {
                                        return null;
                                      }
                                    }
                                  : (value) {
                                      if (value!.isEmpty) {
                                        return "$validationMessage is Required !";
                                      } else if (value.trim().isEmpty) {
                                        return "Please enter a valid name!";
                                      } else {
                                        return null;
                                      }
                                    }
          : null,
    ),
  );
}
