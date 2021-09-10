import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/Notification.dart';
import 'package:flutter_app3/addData.dart';
import 'package:flutter_app3/detailpage.dart';
import 'package:flutter_app3/upgrateData.dart';
import 'db/dbHelper.dart';
import 'models/data.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Data>? data;
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

  onNotificationReceive(ReceiveNotification notification) {
    print("Notifacation Received ");
  }

  // onNotificationClick(String payload)
  // {
  //   print("$payload");
  // }
  @override
  Widget build(BuildContext context) {
    getData();
    if (data == null) {
      data = <Data>[];
    }
    if (data!.length > 0) {
      for (var i = 0; i < data!.length; i++) {
        if (data![i].isActive == 1) {
          //showWeeklyAtDayAndTime(data![i].name,data![i].id);
          localNotifyManager.showNotification(data![i].name , data![i].id);
        }
        //localNotifyManager.showNotification(active![i].name , active![i].id);
        // 
      }
    }
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        actions: [
          Container(
              margin: EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  showDialogWithFields(context);
                },
                icon: Icon(Icons.settings),
                color: Colors.white,
              ))
        ],
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
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    int deneme = data![index].isActive;
                    if (data![index].isActive == 1) {
                      return FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        front: Card(
                          child: ListTile(
                            title: Text(data![index].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400)),
                            trailing: Text(data![index].surname),
                            leading: Checkbox(
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
                                  data!.clear();
                                });
                              },
                            ),
                          ),
                        ),
                        back: Card(
                            margin: EdgeInsets.only(top: 15),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
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
                                          style:
                                              TextStyle(color: Colors.white)))
                                ],
                              ),
                            )),
                      );
                    }
                    return Container();
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
                    if (data![index].isActive == 0) {
                      return FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        front: Card(
                          child: ListTile(
                            title: Text(data![index].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400)),
                            trailing: Text(data![index].surname),
                            leading: Checkbox(
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
                                  data!.clear();
                                });
                              },
                            ),
                          ),
                        ),
                        back: Card(
                            margin: EdgeInsets.only(top: 15),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
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
                                          style:
                                              TextStyle(color: Colors.white)))
                                ],
                              ),
                            )),
                      );
                    }
                    return Container();
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
        count = value.length;
        for (var i = 0; i < count; i++) {
          productsData.add(Data.dbdenOkunanDeger(value[i]));
        }
        setState(() {
          data = productsData;
          count = count;
        });
      });
    });
  }

  Future _upgrateData(Data data, String name) async {
    var sonuc = await _databaseHelper!.dataUpgrate(data, name);
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
  //  Future<void> showWeeklyAtDayAndTime(String asd,int id) async {
  //    var time = DateTime.now().add(Duration(seconds:10));
  //    var androidChannelSpecifics = AndroidNotificationDetails(
  //      'CHANNEL_ID_TIME',
  //      'CHANNEL_NAME_TIME',
  //      "CHANNEL_DESCRIPTION_TIME",
  //      importance: Importance.max,
  //      priority: Priority.high,
  //    );
  //    var iosChannelSpecifics = IOSNotificationDetails();
  //    var platformChannelSpecifics =
  //        NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
  //    await flutterLocalNotificationsPlugin.schedule(
  //      id,
  //      asd,
  //      'Test Bildirim Açıklama',
  //      time,
  //      platformChannelSpecifics,
  //      payload: "sa"
  //    );
  //  }
  void showDialogWithFields(context) {
    bool _notification = false;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                title: Text(
                  'Ayarlar',
                ),
                content: Container(
                  width: double.maxFinite,
                  height: 175,
                  child: Column(
                    children: [
                      Form(
                          child: Container(
                        child: Column(
                          children: [
                            SwitchListTile(
                                title: Text(
                                  "Bildirimler",
                                  style: TextStyle(fontSize: 15),
                                ),
                                value: _notification,
                                onChanged: (newdeger) {
                                  setState(() {
                                    _notification = !_notification;
                                  });
                                })
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Kaydet'),
                  ),
                ],
              );
            },
          );
        });
  }
}
