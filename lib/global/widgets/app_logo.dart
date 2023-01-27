import 'package:flutter/cupertino.dart';

import '../constants/app_asset.dart';
import '../constants/app_color.dart';
import '../constants/app_sizeConstant.dart';

Widget getLogo({bool isBlack = false}) {
  return Image(
    image: AssetImage(AppAsset.logoSvg),
    color: (isBlack) ? AppColor.primary : AppColor.white,
    height: MySize.getScaledSizeHeight(338),
    width: MySize.getScaledSizeWidth(358),
    fit: BoxFit.contain,
  );
}

Widget getLogo1({bool isBlack = false}) {
  return Image(
    image: AssetImage(AppAsset.logoPng),
    color: (isBlack) ? AppColor.primary : AppColor.white,
    height: MySize.getScaledSizeHeight(338),
    width: MySize.getScaledSizeWidth(358),
    // fit: BoxFit.contain,
  );
}
