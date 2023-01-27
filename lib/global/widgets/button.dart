import 'package:flutter/material.dart';

import '../constants/app_color.dart';
import '../constants/app_sizeConstant.dart';

Container button({
  double height = 50,
  double width = 341,
  String? title = "",
  Color? backgroundColor,
  Color? borderColor,
  Color? textColor,
  Widget? widget,
  double? fontsize = 14,
  double? radius = 6,
}) {
  return Container(
    height: MySize.getScaledSizeHeight(height),
    width: MySize.getScaledSizeWidth(width),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius!),
      border: Border.all(
          color: (borderColor == null) ? Colors.transparent : borderColor,
          width: 1),
      color: (backgroundColor == null) ? AppColor.primary : backgroundColor,
    ),
    alignment: Alignment.center,
    child: (widget != null)
        ? Center(child: widget)
        : Text(
            title!,
            style: TextStyle(
                color: (textColor == null) ? Colors.white : textColor,
                fontWeight: FontWeight.bold,
                fontSize: MySize.getScaledSizeHeight(fontsize!)),
          ),
  );
}
