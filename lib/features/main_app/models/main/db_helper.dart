import 'dart:io';

import 'package:moon/features/main_app/models/main/order_model.dart';
// fix bug: databaseFactory not initialized
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "tb_order";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    // Initial Database
    try {
      print("Current Platform: $Platform");
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        print("sqfliteFfiInit()");
        sqfliteFfiInit();
      }

      String _path = "${await getDatabasesPath()}_task.db";
      print("DB Path: $_path");
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("Create a new one.");
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title STRING, "
          "note TEXT, "
          "date STRING, "
          "startTime String, "
          "endTime String, "
          "remind INTEGER, "
          "repeat STRING, "
          "color INTEGER, "
          "isCompleted INTEGER)",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(OrderResponseModel? task) async {
    print("Insert function called.");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }
}
