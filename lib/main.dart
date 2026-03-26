import "package:flutter/foundation.dart";
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import "UI/myApp.dart";
import "package:sqflite/sqflite.dart";
import "package:sqflite_common_ffi_web/sqflite_ffi_web.dart";
import "package:path/path.dart";

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  final database = openDatabase(
    join(await getDatabasesPath(), 'task_database.db'),
    onCreate: (db, version) {
      await db.execute(
          'CREATE TABLE task (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, tags TEXT, nbhours INTEGER, difficulty INTEGER)'
      );
      await db.execute(
          'CREATE TABLE tag (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)'
      );
      await db.execute(
          'CREATE TABLE task_tag (task_id INTEGER, tag_id INTEGER, FOREIGN KEY task_id REFERENCES task(id), FOREIGN KEY tag_id REFERENCES tag(id))'
      );
    }
  );
  runApp(const MyApp());
}
