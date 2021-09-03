import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/db/dbHelper.dart';
import 'package:flutter_app3/models/data.dart';
import 'package:flutter_app3/upgrateData.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  Data data;
  DetailPage(this.data);
  @override
  _DetailPageState createState() => _DetailPageState(data);
}

class _DetailPageState extends State<DetailPage> {
  var _key = GlobalKey<ScaffoldState>();
  DbHelper? _dbHelper = DbHelper();
  Data? data;
  dynamic back = false;
  _DetailPageState(this.data);
  DbHelper? _databaseHelper;
  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(false);
      },
      child: Scaffold(
          key: _key,
          appBar: AppBar(
            title: Text("Data Detay Sayfası ${data!.name}"),
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: Icon(Icons.chevron_left_rounded)),
          ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: [
              Container(
                alignment: Alignment.center,
                height: 175,
                color: Colors.purple,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Icon(
                      Icons.apartment,
                      color: Colors.white,
                      size: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data!.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {});
                        bool result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => upgrateData(data!)),
                        );
                        if (result) {}
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Düzenle",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 370,
                constraints: BoxConstraints.loose(Size.fromHeight(60.0)),
                child: Stack(
                    alignment: Alignment.topCenter,
                    overflow: Overflow.visible,
                    children: [
                      Positioned(
                        top: -10.0,
                        child: Container(
                          width: 370,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Veri Bilgileri",
                                            style: TextStyle(fontSize: 17),
                                          )),
                                      Container(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              delete();
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                    Icons
                                                        .delete_forever_outlined,
                                                    size: 22,
                                                    color: Colors.red),
                                                Text("Veriyi Sil",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.red))
                                              ],
                                            ),
                                          ))
                                    ]),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Ad",
                                            style: TextStyle(fontSize: 16),
                                          )),
                                      Container(
                                          alignment: Alignment.bottomRight,
                                          child: Row(
                                            children: [
                                              Text(data!.name,
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ))
                                    ]),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  height: 10,
                                  color: Colors.black38,
                                  thickness: 1.5,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Soyad",
                                            style: TextStyle(fontSize: 16),
                                          )),
                                      Container(
                                          alignment: Alignment.bottomRight,
                                          child: Row(
                                            children: [
                                              Text(data!.surname,
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ))
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 175,
              ),
            ]),
          )),
    );
  }

  void upgrate(Data product) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => upgrateData(product)));
  }

  void delete() async {
    int result;
    int result2;
    back = true;
    Navigator.pop(context, back);
    result = await _dbHelper!.dataDelete(data!.id);
  }
}
/*
Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(children: [
          ListView.builder(
                    itemCount: transaction!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        //margin: EdgeInsets.only(top: 15),
                        child: ListTile(
                          title: Text("products![index].name"),
                          subtitle: Text("products![index].email"),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.apartment,
                              color: Colors.black45.withOpacity(0.2),
                              size: 30,
                            ),
                          ),
                        ),
                      );
                    }),
        ]),
              ),
            ),
 */