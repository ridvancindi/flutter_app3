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
    var initSettingAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettingIos = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: false,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification notification = ReceiveNotification(
              id: id, title: title, body: body);
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

  Future<void> showNightNotification(String title, String subtitle, int id) async {
    var time = Time(21,00,00);
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
      icon: "@mipmap/ic_launcher",
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(android: androidChannel, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin!.showDailyAtTime(
        id, title, subtitle, time,platformChannelSpecifics);
  }
  Future<void> showDayTimeNotification(String title, String subtitle, int id) async {
    var time = Time(09,00,00);
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
      icon: "@mipmap/ic_launcher",
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(android: androidChannel, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin!.showDailyAtTime(
        id, title, subtitle, time,platformChannelSpecifics);
  }
  
}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

class ReceiveNotification {
  final int? id;
  final String? title;
  final String? body;

  ReceiveNotification(
      {@required this.id,
      @required this.title,
      @required this.body});
}
