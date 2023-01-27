import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:clear_all_notifications/clear_all_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hotel_customer/app/modules/checkout_request/controllers/checkout_request_controller.dart';
import 'package:hotel_customer/app/modules/home/controllers/global_controller.dart';
import 'package:hotel_customer/app/routes/app_pages.dart';
import 'package:hotel_customer/global/constants/app_string.dart';
import 'package:hotel_customer/main.dart';
import '../app/modules/home/controllers/home_controller.dart';

class FCMService extends GetxService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final bool _initialized = false;
  HomeController? homeController;
  CheckoutRequestController? checkoutRequestController;

  Future<void> init() async {
    await Firebase.initializeApp();

    await initFCM();

    findToken();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher_round');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.initialize(initializationSettingsIOS);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: false,
          badge: false,
          sound: false,
        );

    // FirebaseMessaging.onBackgroundMessage(myBackgroundHandler);
  }

  Future selectNotification(String? payload) async {
    Map<String, dynamic> data = jsonDecode(payload!) as Map<String, dynamic>;
    Get.toNamed(
      Routes.CHECKOUT_REQUEST,
      arguments: {
        ArgumentConstant.roomId: int.parse(data["click_action"]),
        ArgumentConstant.isFromNotification: true,
        ArgumentConstant.hotelId: box.read(Constant.hotelId),
      },
    );
    // refreshHomeScreen();
    // await flutterLocalNotificationsPlugin.cancelAll();
  }

  /* Future<void> myBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    return _showNotification(message);
  }*/

  /* Future _showNotification(RemoteMessage message) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    if (kDebugMode) {
      print(message.data);
    }
    Map<String, dynamic> data = message.data;
    AndroidNotification? android = message.notification!.android;
    Map<String, dynamic> dataValue = message.data;
    // if (!isNullEmptyOrFalse(data)) {
    //   flutterLocalNotificationsPlugin.show(
    //     0,
    //     data['title'],
    //     data['body'],
    //     NotificationDetails(
    //       android: AndroidNotificationDetails(
    //         channel.id,
    //         channel.name,
    //         channelDescription: channel.description,
    //         icon: android?.smallIcon,
    //         // other properties...
    //       ),
    //       iOS: IOSNotificationDetails(presentAlert: true, presentSound: true),
    //     ),
    //     payload: 'Default_Sound',
    //   );
    // } else {

    flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: android?.smallIcon,
          // other properties...
        ),
        //iOS: IOSNotificationDetails(presentAlert: true, presentSound: true),
      ),
      payload: jsonEncode(dataValue),
    );
    refreshHomeScreen();
    // }
  }*/

  refreshHomeScreen() {
    if (Get.find<GlobalController>().hasFromRoomRefresh.value == false) {
      debugPrint("-=-=-=-=-=-=-hasFromRoomRefresh = false");
      Get.lazyPut(() => HomeController());
      homeController = Get.find<HomeController>();

      homeController!.callApiGorGetReseredRoom(context: Get.context!);
      homeController!.callApiGorGetUnReseredRoom(context: Get.context!);
      // ClearAllNotifications.clear();
    } else {
      debugPrint("-=-=-=-=-=-=-hasFromRoomRefresh = true");
      Get.put(() => CheckoutRequestController());
      checkoutRequestController = Get.find<CheckoutRequestController>();
      checkoutRequestController!
          .callApiForGetOrderDetail(context: Get.context!);
      // ClearAllNotifications.clear();
    }
  }

  void setToken(String? token) async {
    print('FCM Token: $token');
    if (token != null) {}
  }

  Future<void> saveToken() async {}

  /// Define a top-level named handler which background/terminated messages will
  /// call.
  ///
  /// To verify things are working, check out the native platform logs.
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  initFCM() async {
    if (!_initialized) {
      // For iOS request permission first.
      if (Platform.isIOS) {
        FirebaseMessaging.instance.requestPermission();
      }

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      /*  FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        if (message != null) {
          // showNotification(message);
          RemoteNotification notification = message.notification!;

          AndroidNotification android = message.notification!.android!;
          print(
              'NOtification Call :${notification.apple}${notification.body}${notification.title}');
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              const NotificationDetails(
                android: AndroidNotificationDetails(
                  'high_importance_channel', // id
                  'High Importance Notifications', // title
                  // 'This channel is used for important notifications.',
                  // description
                  importance: Importance.high,
                  icon: '@mipmap/ic_launcher',
                  // color: Colors.yellowAccent,
                  playSound: true,
                ),
              ));
          refreshHomeScreen();
        }
      });*/

      // Set the background messaging handler early on, as a named top-level function
      // FirebaseMessaging.onBackgroundMessage(
      //     _firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        // initFCM();
        homeController?.reservedRooms.clear();
        homeController?.unReservedRooms.clear();
        refreshHomeScreen();
        RemoteNotification notification = message.notification!;

        // ClearAllNotifications.clear();
        AndroidNotification android = notification.android!;
        await ClearAllNotifications.clear();
        // AppleNotification apple = notification.apple!;
        print(
            'NOtification Call :${notification.apple}${notification.body}${notification.title}');

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel', // id
                'High Importance Notifications', // title
                // 'This channel is used for important notifications.',
                // description
                importance: Importance.high,
                icon: '@mipmap/ic_launcher',
                // color: Colors.yellowAccent,
                playSound: true,
              ),
            ));
        // ClearAllNotifications.clear();
        // await ClearAllNotifications.clear();
        // refreshHomeScreen();
      }).onError((e) {
        print('Error Notification : ....$e');
      });

      /* FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('onMessage:-=-=-=- ${message.data}');

        print('onMessage');
        print(message);
        print(message.messageId);
        // refreshHomeScreen();
        showNotification(message);
      });*/

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        Map<String, dynamic> data = message.data;
        ClearAllNotifications.clear();
        print('onMessageOpenedApp');
        print(message.notification);
        print(message.data);
        Get.toNamed(
          Routes.CHECKOUT_REQUEST,
          arguments: {
            ArgumentConstant.roomId: int.parse(data["click_action"]),
            ArgumentConstant.isFromNotification: true,
            ArgumentConstant.hotelId: box.read(Constant.hotelId),
          },
        );
      });

      //find token
      // FirebaseMessaging.instance.getToken().then(setToken);
      //   Stream<String> _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
      //   _tokenStream.listen(setToken);

      //   _initialized = true;
    }

    /*String testMessage =
        '{"notification": {"title": "vishwajit chauhan", "body": "Liked your moment","image": "https://bounsh.s3.amazonaws.com/profile/cbf0a9fb-0cc4-4d0f-9f3d-4391fc43e911.jpg"}, "data": {"profile": "https://bounsh.s3.amazonaws.com/profile/cbf0a9fb-0cc4-4d0f-9f3d-4391fc43e911.jpg", "uid": "vishwajit76", "name": "vishwajit chauhan", "image":"" , "stuff_type": "4", "action_type": "1", "stuff_id": "108"}}';
    Map<String, dynamic> data =
        new Map<String, dynamic>.from(json.decode(testMessage));
    showNotification(data);*/
  }

  /*void showNotification(RemoteMessage message) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    print("notification - " + message.notification!.title!);

    print("notification - " + json.encode(message.data));
    Map<String, dynamic> data = message.data;
    AndroidNotification? android = message.notification!.android;
    Map<String, dynamic> dataValue = message.data;

    // if (!isNullEmptyOrFalse(data)) {
    //   flutterLocalNotificationsPlugin.show(
    //     0,
    //     message.notification!.title,
    //     message.notification!.body,
    //     NotificationDetails(
    //       android: AndroidNotificationDetails(
    //         channel.id,
    //         channel.name,
    //         channelDescription: channel.description,
    //         icon: android?.smallIcon,
    //         // other properties...
    //       ),
    //       //iOS: IOSNotificationDetails(presentAlert: true, presentSound: true),
    //     ),
    //     payload: jsonEncode(dataValue),
    //   );
    // } else {


    await ClearAllNotifications.clear();

    flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: android?.smallIcon,
          // other properties...
        ),
        //iOS: IOSNotificationDetails(presentAlert: true, presentSound: true),
      ),
      payload: jsonEncode(dataValue),
    );
    refreshHomeScreen();

    //   // }
    // }
  }*/

  void fcmSubscribe() {
    _firebaseMessaging.subscribeToTopic('pvc2print');
  }

  void fcmUnSubscribe() {
    _firebaseMessaging.unsubscribeFromTopic('pvc2print');
  }

  void findToken() async {
    String? fcmToken;
    String? apnToken;

    if (Platform.isAndroid) {
      fcmToken = (await FirebaseMessaging.instance.getToken())!;
    } else if (Platform.isIOS) {
      fcmToken = (await FirebaseMessaging.instance.getToken())!;
    }

    if (fcmToken != null) {
      print("fcm token ---> $fcmToken");
    } else {
      print("fcm token is null");
    }
  }
}
