import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:rxdart/subjects.dart';

class LocalNotifyManager {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  var initSetting;
  
  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();

  LocalNotifyManager.init(){
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
  }
  requestIOSPermission() {
    flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(alert: true, badge: true, sound: false);
  }

  initializePlatform() {
    var initSettingAndroid = AndroidInitializationSettings('app_icon');
    var initSettingIos = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification notification = ReceiveNotification(
              id: id, title: title, body: body, payload: payload);
          didReceiveLocalNotificationSubject.add(notification);
        });
    var initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIos);
  }

  setOnNotificationRecive(Function OnNotificationRecive) {
    didReceiveLocalNotificationSubject.listen((notification) {
      OnNotificationRecive(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin!.initialize(initSetting,
        onSelectNotification: (String? payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification(String title, int id) async {
    var time = DateTime.now().add(Duration(seconds:10));
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(android: androidChannel, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin!.schedule(
        id, title, 'Test Bildirim Açıklama', time,platformChannelSpecifics,
        payload: "New Payload");
  }
  Future<void> show(String title, int id) async {
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(android: androidChannel, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin!.show(
        id, title, 'Test Bildirim Açıklama',platformChannelSpecifics,
        payload: "New Payload");
  }
}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

class ReceiveNotification {
  final int? id;
  final String? title;
  final String? body;
  final String? payload;

  ReceiveNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}
