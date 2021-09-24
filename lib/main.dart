import 'package:flutter/material.dart';
import 'package:flutter_app3/homepage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'Notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    localNotifyManager.showNightNotification();
    localNotifyManager.showDayTimeNotification();
    return MaterialApp(
        title: 'Flutter Kelimeci',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: HomePage());
  }
}