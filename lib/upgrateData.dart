import 'dart:convert';
import 'dart:ffi';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/addData.dart';
import 'package:flutter_app3/db/dbHelper.dart';
import 'package:flutter_app3/homepage.dart';
import 'package:flutter_app3/models/data.dart';
import 'package:intl/intl.dart';

import 'detailpage.dart';

class upgrateData extends StatefulWidget {
  Data data;
  upgrateData(this.data);

  @override
  _upgrateDataState createState() => _upgrateDataState(data);
}

class _upgrateDataState extends State<upgrateData> {
  Data? data;
  _upgrateDataState(this.data);
  var _name = TextEditingController();
  var _surname = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  int? error;
  String? name;
  DbHelper? _databaseHelper;
  List<Data>? allData;
  var _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    allData = <Data>[];
    _databaseHelper = DbHelper();
    _databaseHelper!.allData().then((allStudentMapList) {
      for (Map<String, dynamic> okunanStudentMap in allStudentMapList) {
        allData!.add(Data.dbdenOkunanDeger(okunanStudentMap));
      }
      setState(() {});
    }).catchError((hata) => print("Hata $hata"));
    _name.text = data!.name;
    _surname.text = data!.surname;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Veri Güncelleme",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Visibility(
                      visible: error != 0 ? false : true, child: Container(alignment: Alignment.bottomLeft, child: Column(
                        children: [
                          Text("Bu İsim Bulunmakta.",style: TextStyle(color: Colors.red),),
                          SizedBox(height: 10,)
                        ],
                      ))),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            decoration: ShapeDecoration(
                              color: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            child: TextFormField(
                                controller: _name,
                                keyboardType: TextInputType.name,
                                style: TextStyle(fontSize: 15),
                                autofocus: false,
                                validator: (kontroledilecekname) {
                                  if (kontroledilecekname!.isEmpty) {
                                    return "Burası Boş Olamaz";
                                  } else if (kontroledilecekname.length < 2) {
                                    return "3 Karakterden Küçük Olamaz...";
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  labelText: "İsim",
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: ShapeDecoration(
                              color: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            child: TextFormField(
                                controller: _surname,
                                keyboardType: TextInputType.name,
                                style: TextStyle(fontSize: 15),
                                autofocus: false,
                                validator: (kontroledilecekname) {
                                  if (kontroledilecekname!.isEmpty) {
                                    return "Burası Boş Olamaz";
                                  } else if (kontroledilecekname.length < 2) {
                                    return "3 Karakterden Küçük Olamaz...";
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  labelText: "Soyisim",
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                            child: Text(
                              "Kaydet",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  _upgrateData(
                                      Data.withId(data!.id, _name.text,
                                          _surname.text, 1),
                                      _name.text);
                                } else {}
                              });
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ]))));
  }

  void _upgrateData(Data data, String name) async {
    var sonuc = await _databaseHelper!.dataUpgrate(data, name);
    if (sonuc != 0) {
       Navigator.of(context).pop(true);
      Navigator.of(context).pop(true);
    } else {
      error = sonuc;
    }
  }
}
