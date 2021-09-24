import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/Notification.dart';
import 'package:flutter_app3/addData.dart';
import 'package:flutter_app3/models/settings.dart';
import 'package:flutter_app3/upgrateData.dart';
import 'package:intl/intl.dart';
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
  String? _createdDate;
  String? _upgrateDate;
  TabController? tabController;
  int pasif = 0;
  int addDaily = 0;
  int upgrateDaily = 0;
  List<Settings>? notification;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  DbHelper? _databaseHelper;
  int count = 0;
  int count2 = 0;
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
    DateTime now = DateTime.now();
    _createdDate = DateFormat('dd-MM-yyyy').format(now);
    _upgrateDate = DateFormat('dd-MM-yyyy').format(now);
    getNotificationData();
    getData();
    if (data == null) {
      data = <Data>[];
      notification = <Settings>[];
    }
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        actions: [
          Container(
              margin: EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () async {
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
      ),
      body:SingleChildScrollView(
                      child: Container(
          child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Kelimeler",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                data!.length.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Ezberlenen",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                pasif.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Bugün Ezberlenen",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                upgrateDaily.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Bugün Eklenen",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                addDaily.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.yellow,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          DefaultTabController(
              length: 2, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: TabBar(
                          controller: tabController,
                          labelColor: Colors.black,
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                          tabs: [
                            Tab(
                              text: "Aktiler",
                            ),
                            Tab(
                              text: "Pasifler",
                            ),
                          ]),
                    ),
                     Container(
                       height: 570,
                        child: TabBarView(controller: tabController, children: [
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                              Expanded(
                                child: ListView.builder(
                                    itemCount: data!.length,
                                    itemBuilder: (context, index) {
                                      int deneme = data![index].isActive;
                                      if (data![index].isActive == 1) {
                                        return FlipCard(
                                          direction: FlipDirection.HORIZONTAL,
                                          front: Card(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: Text(
                                                        data![index].kelime,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400)),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ListTile(
                                                    title: Text(
                                                        data![index].karsilik,
                                                        style: TextStyle(
                                                            color: Colors.deepOrange,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600)),
                                                    trailing: Checkbox(
                                                      checkColor: Colors.white,
                                                      value: deneme != 0
                                                          ? false
                                                          : true,
                                                      onChanged:
                                                          (bool? value) async {
                                                        setState(() {
                                                          deneme = value != true
                                                              ? 0
                                                              : 1;
                                                          _upgrateData(
                                                              Data.withId(
                                                                  data![index].id,
                                                                  data![index]
                                                                      .kelime,
                                                                  data![index]
                                                                      .karsilik,
                                                                  value != true
                                                                      ? 1
                                                                      : 0,
                                                                  data![index]
                                                                      .createdDate,
                                                                  _upgrateDate),
                                                              data![index]
                                                                  .kelime);
                                                          data!.clear();
                                                        });
                                                      },
                                                    ),
                                                    minVerticalPadding: 25,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          back: Card(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .purple),
                                                        onPressed: () async {
                                                          setState(() {});
                                                          bool result =
                                                              await Navigator
                                                                  .push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    upgrateData(
                                                                        data![
                                                                            index])),
                                                          );
                                                          if (result) {}
                                                        },
                                                        child: Text(
                                                          "Düzenle",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    Colors.red),
                                                        onPressed: () {
                                                          delete(data![index].id,
                                                              index);
                                                        },
                                                        child: Text("Sil",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)))
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
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: Text(
                                                        data![index].kelime,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w400)),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ListTile(
                                                    title: Text(
                                                        data![index].karsilik,
                                                        style: TextStyle(
                                                            color: Colors.deepOrange,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w600)),
                                                    trailing: Checkbox(
                                                      checkColor: Colors.white,
                                                      value: deneme != 0
                                                          ? false
                                                          : true,
                                                      onChanged:
                                                          (bool? value) async {
                                                        setState(() {
                                                          deneme = value != true
                                                              ? 0
                                                              : 1;
                                                          _upgrateData(
                                                              Data.withId(
                                                                  data![index].id,
                                                                  data![index]
                                                                      .kelime,
                                                                  data![index]
                                                                      .karsilik,
                                                                  value != true
                                                                      ? 1
                                                                      : 0,
                                                                  data![index]
                                                                      .createdDate,
                                                                  null),
                                                              data![index]
                                                                  .kelime);
                                                          data!.clear();
                                                        });
                                                      },
                                                    ),
                                                    minVerticalPadding: 25,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          back: Card(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .purple),
                                                        onPressed: () async {
                                                          setState(() {});
                                                          bool result =
                                                              await Navigator
                                                                  .push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    upgrateData(
                                                                        data![
                                                                            index])),
                                                          );
                                                          if (result) {}
                                                        },
                                                        child: Text(
                                                          "Düzenle",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    Colors.red),
                                                        onPressed: () {
                                                          delete(data![index].id,
                                                              index);
                                                        },
                                                        child: Text("Sil",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)))
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
                      ),
                    
                  ])),
        ],
      )),),
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
    int _pasif = 0;
    int _addDaily = 0;
    int _upgrateDaily = 0;
    var dbFuture = _databaseHelper!.initializeDatabase();
    dbFuture.then((value) {
      var proFuture = _databaseHelper!.allData();
      proFuture.then((value) {
        List<Data> productsData = [];
        count = value.length;
        for (var i = 0; i < count; i++) {
          productsData.add(Data.dbdenOkunanDeger(value[i]));
        }
        for (var i = 0; i < productsData.length; i++) {
          if (productsData[i].isActive == 0) {
            _pasif++;
          }
          if (productsData[i].createdDate == _createdDate) {
            _addDaily++;
          }
          if (productsData[i].upgrateDate == _upgrateDate) {
            _upgrateDaily++;
          }
        }
        setState(() {
          pasif = _pasif;
          addDaily = _addDaily;
          upgrateDaily = _upgrateDaily;
          data = productsData;
          count = count;
        });
      });
    });
  }

  void getNotificationData() {
    var dbFuture = _databaseHelper!.initializeDatabase();
    dbFuture.then((value) {
      var proFuture = _databaseHelper!.notificationData();
      proFuture.then((value) {
        List<Settings> _notification = [];
        count2 = value.length;
        for (var i = 0; i < count2; i++) {
          _notification.add(Settings.dbdenOkunanDeger(value[i]));
        }
        setState(() {
          notification = _notification;
          count2 = count2;
        });
      });
    });
  }

  void _upgrateNotification(Settings data) async {
    var sonuc = await _databaseHelper!.notificationUpgrate(data);
    if (sonuc != 0) {
      print("Başarılı");
    } else {
      print("Hata Var");
    }
  }

  Future _upgrateData(Data data, String name) async {
    await _databaseHelper!.dataUpgrate(data, name);
  }

  // void goDetail(Data data, int index) async {
  //   bool result = await Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => DetailPage(data)));
  //   if (result) {
  //     getData();
  //   }
  // }

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

  // void upgrate(Data product) async {
  //   await Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => upgrateData(product)));
  // }
  void showDialogWithFields(context) {
    bool _notification = notification![0].notification != 1 ? true : false;
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
                                    _notification = newdeger;
                                    _upgrateNotification(Settings.withId(
                                        1, newdeger != true ? 1 : 0));
                                    getNotificationData();
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
