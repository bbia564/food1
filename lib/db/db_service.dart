import 'dart:typed_data';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:foodtimer/db/cons.dart';
import 'package:foodtimer/entity/type_bean.dart';
import 'package:foodtimer/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entity/expired_bean.dart';
import '../entity/food_bean.dart';
import '../entity/stats_bean.dart';

class DatabaseService extends GetxService {
  late Database db;
  final faker = Faker();

  Future<DatabaseService> init() async {
    await initDB();
    return this;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'timeLens_db.db');

    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await createTable(db);
      await createDefaultData(db);
    });
  }

  createTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS foods (id INTEGER PRIMARY KEY,name TEXT,image BLOB,type TEXT,brand TEXT,amount INTEGER,price REAL,start_at TEXT,end_at TEXT,created_at TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS type (id INTEGER PRIMARY KEY,name TEXT NOT NULL UNIQUE)');
  }

  final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');
  final DateFormat formatterDay = DateFormat('yyyy-MM-dd');

  createDefaultData(Database db) async {
    List<String> types = ["Meat", "Fruit", "Alcohol", "Beverage",'Snack','Vegetables','Food','Milk'];
    for (var v in types) {
      await db.insert('type', {
        'name': v,
      });
    }

    List<String> names =["Potato Chips","Chocolate Bar","Popcorn","Cheese Puffs","Gummy Bears"];
    for (var i = 0; i < names.length; i++) {
      var amount = faker.randomGenerator.integer(180, min: 10);
      var price = faker.randomGenerator.integer(5, min: 2);
      var name = names[i];
      var cuDate = DateTime.now();
      DateTime randomDate =
          faker.date.dateTimeBetween(cuDate.subtract(const Duration(days: 50)), cuDate);
      String formattedDateTime = formatter.format(randomDate);
      String staAt = formatterDay.format(randomDate);
      String endAt = formatterDay.format(randomDate.add(const Duration(days: 30)));
      int imdex = i+1;
      Uint8List imge = await loadImageToUint8List("image$imdex.jpeg");
      var count = await db.insert('foods', {
        'image': imge,
        'name': name,
        'type': "Fruit",
        'brand': name,
        'amount': amount,
        'price': price,
        'start_at': staAt,
        'end_at': endAt,
        'created_at': formatter.format(DateTime.now()),
      });
      debugPrint(" ========>$count");
    }
  }
  Future<Uint8List> loadImageToUint8List(String path) async {
    ByteData data = await rootBundle.load('assets/images/$path');
    Uint8List uint8List = data.buffer.asUint8List();
    return uint8List;
  }
  delete(int id) {
    db.delete('timeLens', where: 'id = ?', whereArgs: [id]);
  }

  addFood(Uint8List? image, String name, String type, String brand, int amount, double price,
      String startAt, String endAt) async {
    await db.insert('foods', {
      'image': image,
      'name': name,
      'type': type,
      'brand': brand,
      'amount': amount,
      'price': price,
      'start_at': startAt,
      'end_at': endAt,
      'created_at': formatter.format(DateTime.now()),
    });
  }

  Future<int> update(int id, Map<String, Object?> values) async {
    int rowsAffected = await db.update(
      'foods',
      values,
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rowsAffected;
  }

  clean() async {
    await db.delete('foods');
    await db.delete('type');
  }

  closer() async {
    await db.close();
  }

  Future<List<StatsBean>> getAllStatsByType() async {
    var tyList = await getAllTypes();
    List<StatsBean> list = [];
    await Future.wait(tyList.map((e) async {
      String type = e.name;
      List<Map<String, dynamic>> result = await db.query("foods",
          columns: ['COUNT(*) as count'], where: 'type = ?', whereArgs: [type]);

      int count = 0;
      if (result.isNotEmpty) {
        count = result.first['count'];
      }
      list.add(StatsBean(type, "$count"));
    }));
    return list;
  }

  Future<List<StatsBean>> getAllStatsByDate() async {
    List<StatsBean> list = [];
    await Future.wait(Cons.tags.map((e) async {
      String tag = e;
      List<Map<String, dynamic>> result = [];
      if (tag == "All") {
        result = await db.query("foods", columns: ['COUNT(*) as count']);
        int count = 0;
        if (result.isNotEmpty) {
          count = result.first['count'];
        }
        list.add(StatsBean(tag, "$count"));
      }

      if (tag == "Active") {
        DateTime now = DateTime.now();
        String currentDateString = now.toIso8601String().split('T')[0];
        result = await db.query("foods",
            columns: ['COUNT(*) as count'], where: 'end_at > ?', whereArgs: [currentDateString]);
        int count = 0;
        if (result.isNotEmpty) {
          count = result.first['count'];
        }
        list.add(StatsBean(tag, "$count"));
      }

      if (tag == "Expired") {
        DateTime now = DateTime.now();
        String currentDateString = now.toIso8601String().split('T')[0];
        result = await db.query("foods",
            columns: ['COUNT(*) as count'], where: 'end_at < ?', whereArgs: [currentDateString]);
        int count = 0;
        if (result.isNotEmpty) {
          count = result.first['count'];
        }
        list.add(StatsBean(tag, "$count"));
      }

      if (tag == "Near Expired") {
        int day = await SharedPreferencesUtil.getInt("expiringDay", defaultValue: Cons.expiringDay);
        String today = DateTime.now().toIso8601String().split('T')[0];
        DateTime end = DateTime.now().add(Duration(days: day + 1));
        String endDateString = end.toIso8601String().split('T')[0];
        result = await db.query("foods",
            columns: ['COUNT(*) as count'],
            where: 'end_at <= ? AND end_at >=?',
            whereArgs: [endDateString, today]);
        int count = 0;
        if (result.isNotEmpty) {
          count = result.first['count'];
        }
        list.add(StatsBean(tag, "$count"));
      }

      if (tag == "Total Count") {
        List<Map<String, dynamic>> sumResult = await db
            .rawQuery("SELECT SUM(amount) AS total_amount, SUM(price) AS total_price FROM foods");
        if (sumResult.isNotEmpty) {
          int totalAmount = sumResult.first['total_amount'] ?? 0;
          double totalPrice = sumResult.first['total_price'] ?? 0.0;
          list.add(StatsBean("Total Count", "$totalAmount"));
          list.add(StatsBean("Total Price", "$totalPrice"));
        } else {
          list.add(StatsBean("Total Count", "0"));
          list.add(StatsBean("Total Price", "0"));
        }
      }
    }));
    return list;
  }

  Future<List<ExpiredBean>> getAllDay() async {
    var result =
        await db.query('foods', distinct: true, columns: ['end_at'], orderBy: 'created_at DESC');
    List<ExpiredBean> list = [];
    await Future.wait(result.map((e) async {
      String day = e['end_at'].toString();
      debugPrint(day);
      List<FoodBean> dayRecords = await getByEndDay(day);
      list.add(ExpiredBean(day, dayRecords));
    }));
    return list;
  }

  Future<List<FoodBean>> getByEndDay(String day) async {
    var result =
        await db.query('foods', where: 'end_at = ?', whereArgs: [day], orderBy: 'created_at DESC');
    return result.map((e) => FoodBean.fromJson(e)).toList();
  }

  Future<List<FoodBean>> getFoodsByTabIndex(int tabIndex) async {
    if (tabIndex == 0) {
      var result = await db.query('foods', orderBy: 'created_at DESC');
      return result.map((e) => FoodBean.fromJson(e)).toList();
    }
    if (tabIndex == 1) {
      DateTime now = DateTime.now();
      String currentDateString = now.toIso8601String().split('T')[0];
      var result = await db.query("foods", where: 'end_at > ?', whereArgs: [currentDateString]);
      return result.map((e) => FoodBean.fromJson(e)).toList();
    }

    if (tabIndex == 2) {
      DateTime now = DateTime.now();
      String currentDateString = now.toIso8601String().split('T')[0];
      var result = await db.query("foods", where: 'end_at < ?', whereArgs: [currentDateString]);
      return result.map((e) => FoodBean.fromJson(e)).toList();
    }

    if (tabIndex == 3) {
      int day = await SharedPreferencesUtil.getInt("expiringDay", defaultValue: Cons.expiringDay);
      String today = DateTime.now().toIso8601String().split('T')[0];
      DateTime end = DateTime.now().add(Duration(days: day + 1));
      String endDateString = end.toIso8601String().split('T')[0];
      var result = await db
          .query("foods", where: 'end_at <= ? AND end_at >= ?', whereArgs: [endDateString, today]);
      return result.map((e) => FoodBean.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<TYpeBean>> getAllTypes() async {
    var result = await db.query(
      'type',
      orderBy: 'id DESC',
    );
    return result.map((e) => TYpeBean.fromJson(e)).toList();
  }

  Future<int> addType(String name) async {
    var count = 0;
    try {
      count = await db.insert('type', {
        'name': name,
      });
    } on DatabaseException catch (e) {
      count = 0;
    }
    return count;
  }
}
