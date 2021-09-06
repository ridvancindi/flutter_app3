import 'package:flutter/material.dart';
import 'package:flutter_app3/detailpage.dart';
import 'package:flutter_app3/homepage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('codex_logo');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
          onDidReceiveLocalNotification: (
            int id,
            String? title,
            String? body,
            String? payload,
          ) async {});
          var initializationSettings = InitializationSettings(
            android: initializationSettingsAndroid , iOS: initializationSettingsIOS
          );
          await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? payload) async{
            if (payload != null) {
              debugPrint('notification payload' + payload);
            }
          });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: HomePage());
  }
}
