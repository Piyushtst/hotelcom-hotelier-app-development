// AppBar
import 'package:flutter/material.dart';

import '../constants/app_color.dart';

AppBar appBar({
  String? titleName,
  Function()? onTap,
  Color? backgroundColor,
  isIcon = false,
  Widget? actionWidget,
  textColor,
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? AppColor.white,
    automaticallyImplyLeading: false,
    leadingWidth: 45,
    leading: InkWell(
      onTap: onTap!,
      child: Icon(
        Icons.arrow_back,
        color: textColor ?? AppColor.black,
      ),
    ),
    title: Text(
      titleName!,
      style: TextStyle(
        color: textColor ?? AppColor.black,
      ),
    ),
    centerTitle: true,
    actions: [
      isIcon ? actionWidget! : const SizedBox(),
    ],
    // elevation: 0.0,
  );
}

Widget getCircularBar() {
  return CircularProgressIndicator(
    color: AppColor.primary,
  );
}
