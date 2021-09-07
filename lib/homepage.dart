import 'dart:typed_data';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/Notification.dart';
import 'package:flutter_app3/addData.dart';
import 'package:flutter_app3/detailpage.dart';
import 'package:flutter_app3/main.dart';
import 'package:flutter_app3/upgrateData.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'db/dbHelper.dart';
import 'models/data.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<int> isActive = [];
  List<Data>? data;
  List<Data>? active;
  bool asd = false;
  List<Data>? notactive;
  TabController? tabController;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  DbHelper? _databaseHelper;
  int count = 0;
  @override
  void initState() {
    super.initState();
    localNotifyManager.setOnNotificationRecive(onNotificationReceive);
    //localNotifyManager.setOnNotificationClick(onNotificationClick);
    _databaseHelper = DbHelper();
    tabController = TabController(length: 2, vsync: this);
  }
  onNotificationReceive(ReceiveNotification notification)
  {
    print("Notifacation Received ");
  }
  // onNotificationClick(String payload)
  // {
  //   print("$payload");
  // }
  @override
  Widget build(BuildContext context) {
    
    if (data == null && active == null) {
      data = <Data>[];
      active = <Data>[];
      getData();
    }
    if (active!.length>0) {
     for (var i = 0; i < active!.length; i++) {
       localNotifyManager.showNotification(active![i].name , active![i].id);
      // showWeeklyAtDayAndTime(active![i].name,active![i].id);
     }
    }
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "AnaSayfa",
          style: TextStyle(color: Colors.white),
        ),
        bottom: TabBar(
            controller: tabController,
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            tabs: [
              Tab(
                text: "Aktiler",
              ),
              Tab(
                text: "Pasifler",
              ),
            ]),
      ),
      body: TabBarView(controller: tabController, children: [
        Container(
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                  itemCount: active!.length,
                  itemBuilder: (context, index) {
                    bool _active = true;
                    int deneme = active![index].isActive;
                    return FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      front: Card(
                        child: ListTile(
                          title: Text(active![index].name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400)),
                          trailing: Text(active![index].surname),
                          leading: Checkbox(
                            checkColor: Colors.white,
                            value: deneme == 0 ? false : true,
                            onChanged: (bool? value) async {
                              setState(() {
                                deneme = value == true ? 0 : 1;
                                _upgrateData(
                                    Data.withId(
                                        active![index].id,
                                        active![index].name,
                                        active![index].surname,
                                        value == true ? 1 : 0),
                                    active![index].name);
                                active!.clear();
                                data!.clear();
                               
                              }); 
                              getData();
                            },
                          ),
                        ),
                      ),
                      back: Card(
                          margin: EdgeInsets.only(top: 15),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.purple),
                                    onPressed: () async {
                                      setState(() {});
                                      bool result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                upgrateData(active![index])),
                                      );
                                      if (result) {}
                                    },
                                    child: Text(
                                      "Düzenle",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                    onPressed: () {
                                      delete(active![index].id, index);
                                    },
                                    child: Text("Sil",
                                        style: TextStyle(color: Colors.white)))
                              ],
                            ),
                          )),
                    );
                  }),
            ),
          ]),
        ),
        Container(
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    int deneme = data![index].isActive;
                    return FlipCard(
                      front: Card(
                        elevation: 5,
                        margin: EdgeInsets.only(top: 15),
                        child: ListTile(
                            title: Text(data![index].name),
                            trailing: Text(data![index].surname),
                            leading: GestureDetector(
                              child: Checkbox(
                                checkColor: Colors.white,
                                value: deneme == 0 ? false : true,
                                onChanged: (bool? value) async {
                                  setState(() {
                                    deneme = value == true ? 0 : 1;
                                    _upgrateData(
                                        Data.withId(
                                            data![index].id,
                                            data![index].name,
                                            data![index].surname,
                                            value == true ? 1 : 0),
                                        data![index].name);
                                    active!.clear();
                                    data!.clear();
                                    getData();
                                  });
                                },
                              ),
                            )),
                      ),
                      back: Card(
                          elevation: 5,
                          margin: EdgeInsets.only(top: 15),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.purple),
                                    onPressed: () async {
                                      setState(() {});
                                      bool result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                upgrateData(data![index])),
                                      );
                                      if (result) {}
                                    },
                                    child: Text(
                                      "Düzenle",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                    onPressed: () {
                                      delete(data![index].id, index);
                                    },
                                    child: Text("Sil",
                                        style: TextStyle(color: Colors.white)))
                              ],
                            ),
                          )),
                    );
                  }),
            ),
          ]),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {       
           setState(() {});
           bool result = await Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => addData()),
           );
           if (result) {
             getData();
           }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void getData() {
    var dbFuture = _databaseHelper!.initializeDatabase();
    dbFuture.then((value) {
      var proFuture = _databaseHelper!.allData();
      proFuture.then((value) {
        List<Data> productsData = [];
        List<Data> activeData = [];
        count = value.length;
        for (var i = 0; i < count; i++) {
          if (Data.dbdenOkunanDeger(value[i]).isActive != 0) {
            activeData.add(Data.dbdenOkunanDeger(value[i]));
          } else {
            productsData.add(Data.dbdenOkunanDeger(value[i]));
          }
        }
        setState(() {
          data = productsData;
          active = activeData;
          count = count;
        });
      });
    });
  }

  void getactiveData() {
    var dbFuture = _databaseHelper!.initializeDatabase();
    dbFuture.then((value) {
      var proFuture = _databaseHelper!.activeData();
      proFuture.then((value) {
        List<Data> productsData = [];
        count = value.length;
        for (var i = 0; i < count; i++) {
          productsData.add(Data.dbdenOkunanDeger(value[i]));
        }
        setState(() {
          active = productsData;
          count = count;
        });
      });
    });
  }

  Future _upgrateData(Data data, String name) async {
    var sonuc = await _databaseHelper!.dataUpgrate(data, name);
  }

  void getnotactiveData() {
    var dbFuture = _databaseHelper!.initializeDatabase();
    dbFuture.then((value) {
      var proFuture = _databaseHelper!.notactiveData();
      proFuture.then((value) {
        List<Data> productsData = [];
        count = value.length;
        for (var i = 0; i < count; i++) {
          productsData.add(Data.dbdenOkunanDeger(value[i]));
        }
        setState(() {
          notactive = productsData;
          count = count;
        });
      });
    });
  }

  void goDetail(Data data, int index) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailPage(data)));
    if (result) {
      getData();
    }
  }

  void delete(int id, int id2) async {
    int result;
    setState(() {
      data!.removeAt(id2);
    });
    result = await _databaseHelper!.dataDelete(id);
    if (result == 1) {
      _scaffoldkey.currentState!.showSnackBar(SnackBar(
        content: Text("Başarıyla Silindi"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  void upgrate(Data product) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => upgrateData(product)));
  }
  // Future<void> showWeeklyAtDayAndTime(String asd,int id) async {
  //   var time = Time(11,45,0);
  //   var androidChannelSpecifics = AndroidNotificationDetails(
  //     'CHANNEL_ID_TIME',
  //     'CHANNEL_NAME_TIME',
  //     "CHANNEL_DESCRIPTION_TIME",
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   var iosChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics =
  //       NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.showDailyAtTime(
  //     id,
  //     asd,
  //     'Test Bildirim Açıklama',
  //     time,
  //     platformChannelSpecifics,
  //     payload: "sa"
  //   );
    
  // }
}
