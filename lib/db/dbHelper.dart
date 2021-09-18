import 'dart:async';
import 'dart:io';
import 'package:flutter_app3/models/data.dart';
import 'package:flutter_app3/models/settings.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  String tbldata = "data";
  String colid = "id";
  String colkelime = "kelime";
  String colkarsilik = "karsilik";
  String colactive = "isactive";
  String colnotification = "notification";
  String tblsettings = "settings";
  String colcreatedDate = "createdDate";
  String colupgrateDate = "upgrateDate";
  static final DbHelper _dbHelper = DbHelper._internal();
  DbHelper._internal();
  factory DbHelper() {
    return _dbHelper;
  }
  static Database? _db;
  Future<Database> _getDatabase() async {
    if (_db == null) {
      _db = await initializeDatabase();
      return _db!;
    } else {
      return _db!;
    }
  }

  Future<Database> initializeDatabase() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    String dbpath = join(klasor.path, "data.db");
    var dataDb = openDatabase(dbpath, version: 1, onCreate: _createDb);
    return dataDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tbldata ($colid INTEGER PRIMARY KEY AUTOINCREMENT, $colkelime text NULL, $colkarsilik text NULL,$colactive int NULL, $colcreatedDate text NULL, $colupgrateDate text NULL)");
    await db.execute(
        "CREATE TABLE $tblsettings ($colid INTEGER PRIMARY KEY AUTOINCREMENT,$colnotification INTEGER DEFAULT 1)");
    await db.execute("INSERT INTO $tblsettings VALUES (1,1)");
  }

  Future<int> addData(Data data, String kelime) async {
    var db = await _getDatabase();
    var son = await db
        .rawQuery("SELECT * FROM $tbldata WHERE $colkelime = '$kelime'");
    if (son.length > 0) {
      return 0;
    } else {
      var sonuc =
          await db.insert(tbldata, data.toMap(), nullColumnHack: "$colid");
      print("eklendi " + sonuc.toString());
      return sonuc;
    }
  }

  Future<List<Map<String, dynamic>>> allData() async {
    var db = await _getDatabase();
    var sonuc = await db.rawQuery("SELECT coalesce(upgrateDate,' ') upgrateDate, id ,kelime ,karsilik ,isactive ,createdDate from data");
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> notificationData() async {
    var db = await _getDatabase();
    var sonuc = await db.rawQuery("SELECT * FROM settings");
    return sonuc;
  }

  Future<int> notificationUpgrate(Settings data) async {
    var db = await _getDatabase();
    var son =
        await db.rawQuery("SELECT * FROM $tbldata WHERE $colid != ${data.id}");
    if (son.length > 0) {
      return 0;
    } else if (son.length == 0) {
      var sonuc = await db.update(tblsettings, data.toMap(),
          where: "$colid = ?", whereArgs: [data.id]);
      return sonuc;
    } else {
      return 0;
    }
  }

  //Kullanıcı Güncelleme
  Future<int> dataUpgrate(Data data, String kelime) async {
    var db = await _getDatabase();
    var son = await db.rawQuery(
        "SELECT * FROM $tbldata WHERE $colkelime = '$kelime' AND $colid != ${data.id}");
    if (son.length > 0) {
      return 0;
    } else if (son.length == 0) {
      var sonuc = await db.update(tbldata, data.toMap(),
          where: "$colid = ?", whereArgs: [data.id]);
      return sonuc;
    } else {
      return 0;
    }
  }

  Future<int> dataDelete(int id) async {
    var db = await _getDatabase();
    var sonuc = await db.delete(tbldata, where: "$colid =?", whereArgs: [id]);
    return sonuc;
  }
}
/*


  DatabaseHelper._internal();
  Future<Database> _getDatabase() async {
    if (_database == null) {
      print("Db Burası Çalıştır null");
      _database = await _initializeDatabase();
      return _database!;
    } else {
      print("Db Burası Çalıştır null");
      return _database!;
    }
  }

  _initializeDatabase() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    String dbpath = join(klasor.path, "student.db");
    print("Data base : $dbpath");
    var studentdb = openDatabase(dbpath, version: 1, onCreate: _createDb);
    return studentdb;
  }

  Future<void> _createDb(Database db, int version) async {
    print("Create db methodu çalıştı");
    await db.execute(
        "");
  }

  //Kullanıcı Ekleme
  Future<int> studentAdd(Student student) async {
    var db = await _getDatabase();
    var sonuc = await db.insert(_studentTable, student.toMap(),
        nullColumnHack: "$_columnId");
    print("eklendi " + sonuc.toString());
    return sonuc;
  }
  //Listeleme
  Future<List<Map<String, dynamic>>> allstudent() async {
    var db = await _getDatabase();
    var sonuc = await db.query(_studentTable, orderBy: "$_columnId DESC");
    return sonuc;
  }
  //Kullanıcı Güncelleme
  Future<int> studentUpgrate(Student student) async{
    var db = await _getDatabase();
    var sonuc = await db.update(_studentTable, student.toMap(),where: "$_columnId = ?",whereArgs: [student.id]);
    return sonuc;
  }
  // 1 Kullanıcı Silme
  Future<int> studentDelete(int id) async{
    var db = await _getDatabase();
    var sonuc =await db.delete(_studentTable,where: "$_columnId =?",whereArgs: [id]);
    print("${id.toString()} İdli Kullanıcı Silindi");
    return sonuc;
  }
  // Tüm Kullanıcıları Silme
  Future<int> studentAllDelete() async{
    var db = await _getDatabase();
    var sonuc =await db.delete(_studentTable);
    print("Tüm Hepsi Silindi");
    return sonuc;

  }
*/
/*
  // void getData(){
  //   var dbFuture = _databaseHelper!.initializeDatabase();
  //   dbFuture.then((value){
  //     var proFuture = _databaseHelper!.listData();
  //     proFuture.then((value){
  //       List<Product>  productsData = [];
  //       count = value.length;
  //       for (var i = 0; i < count; i++) {
  //         productsData.add(Product.dbdenOkunanDeger(value[i]));
  //       }
  //       setState(() {
  //         products = productsData;
  //         count = count;
  //       });
  //     });
  //   });
  // } */