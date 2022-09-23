// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, avoid_function_literals_in_foreach_calls

import 'package:chat_app/database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
late FlutterLocalNotificationsPlugin flutterNotification;

void initMessaging() {
  var androiInit =
      AndroidInitializationSettings('@mipmap/ic_launcher'); //for logo
  var iosInit = const IOSInitializationSettings();
  var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
  var fltNotification = FlutterLocalNotificationsPlugin();
  fltNotification.initialize(initSetting);
  var androidDetails = AndroidNotificationDetails(
    '1',
    'channelName',
  );
  var iosDetails = const IOSNotificationDetails();
  var generalNotificationDetails =
      NotificationDetails(android: androidDetails, iOS: iosDetails);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      fltNotification.show(notification.hashCode, notification.title,
          notification.body, generalNotificationDetails);
    }
  });
}

void configOneSignel(String uid) async {
  WidgetsFlutterBinding.ensureInitialized();
  await OneSignal.shared.setAppId('fc835a9a-cd4b-4101-af16-b90be357f6f9');
  OSDeviceState? state = await OneSignal.shared.getDeviceState();
  if (state != null) {
    registerOneSignal(uid, state.userId!);
  }
}

void sendNotification(
    List<String> uids, String heading, String context, String id) async {
  await getActive(id);
  setUnread(uids, id);
  List<String> nonActives = [];
  uids.forEach((element) {
    if (!isActive(element)) {
      nonActives.add(element);
    }
  });
  var ids = await getpids(nonActives);
  if (ids.isNotEmpty) {
    await OneSignal.shared.postNotification(OSCreateNotification(
      playerIds: ids,
      content: context,
      heading: heading,
    ));
  }
}
