import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tasmarttoilet/main.dart';
import 'package:tasmarttoilet/view/Monitoring_Page.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  message.notification!.title;
  message.notification!.body;
  print("Title: ${message.notification!.title}");
  print("Body: ${message.notification!.body}");
  print("Payload: ${message.data}");
  print("Time : ${DateTime.now()}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => const MonitoringPegawai()));
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.subscribeToTopic("allDevices");
    final FCMToken = await _firebaseMessaging.getToken();
    print('Token : $FCMToken');
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
    initPushNotifications();
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
