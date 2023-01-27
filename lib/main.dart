import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotel_customer/app/modules/home/controllers/global_controller.dart';
import 'package:kiwi/kiwi.dart';

import 'Services/fcm_services.dart';
import 'app/routes/app_pages.dart';
import 'global/utils/app_module.dart';

late KiwiContainer app;
GetStorage box = GetStorage();

initFireBaseApp() async {
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print(e);
  }
}

initFcm() async {
  Get.put<FCMService>(FCMService()..init());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFireBaseApp();
  await GetStorage.init();
  setup();
  initFcm();

  app = KiwiContainer();

  Get.put(GlobalController());

  runApp(
    GetMaterialApp(
      title: "Application",
      theme: ThemeData(
        fontFamily: 'Satoshi',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
