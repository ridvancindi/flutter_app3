import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app3/addData.dart';
import 'package:flutter_app3/detailpage.dart';
import 'package:flutter_app3/upgrateData.dart';

import 'db/dbHelper.dart';
import 'models/data.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data>? allData;
  List<Data>? data;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  DbHelper? _databaseHelper;
  int count = 0;
  @override
  void initState() {
    super.initState();
    _databaseHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      data = <Data>[];
      getData();
    }
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
          title: Text(
        "AnaSayfa",
        style: TextStyle(color: Colors.white),
      )),
      body: Container(
        child: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  int deneme = data![index].isActive;
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.only(top: 15),
                    child: ListTile(
                        title: Text(data![index].name),
                        subtitle: Text(data![index].surname),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  setState(() {});
                                  bool result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            upgrateData(data![index])),
                                  );
                                  if (result) {}
                                },
                                child: Icon(Icons.edit)),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  delete(data![index].id, index);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red.shade400,
                                )),
                          ],
                        ),
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
                                data![index].isActive = value == false ? 0 : 1;
                              });
                            },
                          ),
                        )

                        // onTap: () {
                        //   goDetail(data![index], data![index].id);
                        // },
                        ),
                  );
                }),
          ),
        ]),
      ),
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
          data = productsData;
          count = count;
        });
      });
    });
  }

  void _upgrateData(Data data, String name) async {
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
          data = productsData;
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
}
